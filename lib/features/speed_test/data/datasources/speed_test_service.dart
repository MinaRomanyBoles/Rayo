import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;

class SpeedTestProgress {
  final double currentSpeed;
  final double progress; // 0.0 to 1.0
  final String phase; // 'ping', 'download', 'upload'

  const SpeedTestProgress({
    required this.currentSpeed,
    required this.progress,
    required this.phase,
  });
}

class SpeedTestService {
  static const String _downloadUrl = 'https://speed.cloudflare.com/__down?bytes=';
  static const String _uploadUrl = 'https://speed.cloudflare.com/__up';
  static const String _pingUrl = 'https://speed.cloudflare.com/__down?bytes=0';

  /// Measure ping (ms) — average of multiple attempts
  Future<double> measurePing({int attempts = 5}) async {
    final pings = <double>[];
    for (var i = 0; i < attempts; i++) {
      final sw = Stopwatch()..start();
      try {
        await http.get(Uri.parse(_pingUrl));
        sw.stop();
        pings.add(sw.elapsedMicroseconds / 1000.0);
      } catch (_) {
        // Skip failed pings
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }
    if (pings.isEmpty) return 0;
    return pings.reduce((a, b) => a + b) / pings.length;
  }

  /// Measure jitter (ms) — variation in ping
  Future<double> measureJitter({int attempts = 5}) async {
    final pings = <double>[];
    for (var i = 0; i < attempts; i++) {
      final sw = Stopwatch()..start();
      try {
        await http.get(Uri.parse(_pingUrl));
        sw.stop();
        pings.add(sw.elapsedMicroseconds / 1000.0);
      } catch (_) {}
      await Future.delayed(const Duration(milliseconds: 100));
    }
    if (pings.length < 2) return 0;
    double totalDiff = 0;
    for (var i = 1; i < pings.length; i++) {
      totalDiff += (pings[i] - pings[i - 1]).abs();
    }
    return totalDiff / (pings.length - 1);
  }

  /// Measure packet loss (%)
  Future<double> measurePacketLoss({int attempts = 10}) async {
    int lost = 0;
    for (var i = 0; i < attempts; i++) {
      try {
        final response = await http
            .get(Uri.parse(_pingUrl))
            .timeout(const Duration(seconds: 3));
        if (response.statusCode != 200) lost++;
      } catch (_) {
        lost++;
      }
    }
    return (lost / attempts) * 100.0;
  }

  /// Measure download speed with streaming progress
  Stream<SpeedTestProgress> measureDownloadSpeed({
    int durationSeconds = 10,
  }) async* {
    final sizes = [1000000, 5000000, 10000000, 25000000]; // 1MB, 5MB, 10MB, 25MB
    double totalBytes = 0;
    final sw = Stopwatch()..start();

    for (var sizeIndex = 0;
        sizeIndex < sizes.length && sw.elapsed.inSeconds < durationSeconds;
        sizeIndex++) {
      final size = sizes[min(sizeIndex, sizes.length - 1)];
      try {
        final request = http.Request('GET', Uri.parse('$_downloadUrl$size'));
        final response = await http.Client().send(request);
        await for (final chunk in response.stream) {
          totalBytes += chunk.length;
          final elapsed = sw.elapsedMicroseconds / 1000000.0;
          final speedMbps = (totalBytes * 8) / (elapsed * 1000000);
          final progress = min(1.0, elapsed / durationSeconds);
          yield SpeedTestProgress(
            currentSpeed: speedMbps,
            progress: progress,
            phase: 'download',
          );
          if (sw.elapsed.inSeconds >= durationSeconds) break;
        }
      } catch (_) {
        break;
      }
    }

    sw.stop();
    final elapsed = sw.elapsedMicroseconds / 1000000.0;
    final finalSpeed = elapsed > 0 ? (totalBytes * 8) / (elapsed * 1000000) : 0.0;
    yield SpeedTestProgress(currentSpeed: finalSpeed, progress: 1.0, phase: 'download');
  }

  /// Measure upload speed with streaming progress
  Stream<SpeedTestProgress> measureUploadSpeed({
    int durationSeconds = 10,
  }) async* {
    final chunkSize = 1000000; // 1MB chunks
    double totalBytes = 0;
    final sw = Stopwatch()..start();
    final data = List<int>.filled(chunkSize, 0);

    while (sw.elapsed.inSeconds < durationSeconds) {
      try {
        await http.post(
          Uri.parse(_uploadUrl),
          body: data,
          headers: {'Content-Type': 'application/octet-stream'},
        );
        totalBytes += chunkSize;
        final elapsed = sw.elapsedMicroseconds / 1000000.0;
        final speedMbps = (totalBytes * 8) / (elapsed * 1000000);
        final progress = min(1.0, elapsed / durationSeconds);
        yield SpeedTestProgress(
          currentSpeed: speedMbps,
          progress: progress,
          phase: 'upload',
        );
      } catch (_) {
        break;
      }
    }

    sw.stop();
    final elapsed = sw.elapsedMicroseconds / 1000000.0;
    final finalSpeed = elapsed > 0 ? (totalBytes * 8) / (elapsed * 1000000) : 0.0;
    yield SpeedTestProgress(currentSpeed: finalSpeed, progress: 1.0, phase: 'upload');
  }
}

/// Entity representing a single speed test result
class SpeedTestResult {
  final String id;
  final DateTime timestamp;
  final double pingMs;
  final double downloadMbps;
  final double uploadMbps;
  final String serverName;
  final String serverLocation;
  final String isp;

  const SpeedTestResult({
    required this.id,
    required this.timestamp,
    required this.pingMs,
    required this.downloadMbps,
    required this.uploadMbps,
    required this.serverName,
    required this.serverLocation,
    required this.isp,
  });
}

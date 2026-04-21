class SpeedTestResult {
  final String id;
  final String userId;
  final DateTime testedAt;
  final double downloadSpeed;
  final double uploadSpeed;
  final double ping;
  final double jitter;
  final double packetLoss;
  final String networkType;

  const SpeedTestResult({
    required this.id,
    required this.userId,
    required this.testedAt,
    required this.downloadSpeed,
    required this.uploadSpeed,
    required this.ping,
    required this.jitter,
    required this.packetLoss,
    required this.networkType,
  });

  factory SpeedTestResult.fromMap(Map<String, dynamic> map) {
    return SpeedTestResult(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      testedAt: DateTime.parse(map['tested_at'] as String),
      downloadSpeed: (map['download_speed'] as num).toDouble(),
      uploadSpeed: (map['upload_speed'] as num).toDouble(),
      ping: (map['ping'] as num).toDouble(),
      jitter: (map['jitter'] as num).toDouble(),
      packetLoss: (map['packet_loss'] as num).toDouble(),
      networkType: map['network_type'] as String? ?? 'Unknown',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'download_speed': downloadSpeed,
      'upload_speed': uploadSpeed,
      'ping': ping,
      'jitter': jitter,
      'packet_loss': packetLoss,
      'network_type': networkType,
      'tested_at': testedAt.toIso8601String(),
    };
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/datasources/speed_test_service.dart';

enum SpeedTestState { idle, testing, completed, error }

class SpeedTestProvider extends ChangeNotifier {
  final SpeedTestService _service = SpeedTestService();

  SpeedTestState _state = SpeedTestState.idle;
  double _downloadSpeed = 0.0;
  double _uploadSpeed = 0.0;
  double _ping = 0.0;
  double _jitter = 0.0;
  double _packetLoss = 0.0;
  double _gaugeValue = 0.0;
  String _currentPhase = '';
  double _progress = 0.0;
  List<double> _downloadHistory = [];
  List<double> _uploadHistory = [];
  String? _errorMessage;
  StreamSubscription? _subscription;

  SpeedTestState get state => _state;
  double get downloadSpeed => _downloadSpeed;
  double get uploadSpeed => _uploadSpeed;
  double get ping => _ping;
  double get jitter => _jitter;
  double get packetLoss => _packetLoss;
  double get gaugeValue => _gaugeValue;
  String get currentPhase => _currentPhase;
  double get progress => _progress;
  List<double> get downloadHistory => List.unmodifiable(_downloadHistory);
  List<double> get uploadHistory => List.unmodifiable(_uploadHistory);
  String? get errorMessage => _errorMessage;

  Future<void> startTest() async {
    if (_state == SpeedTestState.testing) return;

    _state = SpeedTestState.testing;
    _downloadSpeed = 0;
    _uploadSpeed = 0;
    _ping = 0;
    _jitter = 0;
    _packetLoss = 0;
    _gaugeValue = 0;
    _downloadHistory = [];
    _uploadHistory = [];
    _errorMessage = null;
    notifyListeners();

    try {
      // Phase 1: Ping
      _currentPhase = 'ping';
      notifyListeners();
      _ping = await _service.measurePing();
      notifyListeners();

      // Phase 2: Jitter
      _jitter = await _service.measureJitter();
      notifyListeners();

      // Phase 3: Packet Loss
      _packetLoss = await _service.measurePacketLoss();
      notifyListeners();

      // Phase 4: Download
      _currentPhase = 'download';
      notifyListeners();
      await for (final update in _service.measureDownloadSpeed(durationSeconds: 10)) {
        _downloadSpeed = update.currentSpeed;
        _gaugeValue = update.currentSpeed;
        _progress = update.progress;
        _downloadHistory.add(update.currentSpeed);
        notifyListeners();
      }

      // Phase 5: Upload
      _currentPhase = 'upload';
      _gaugeValue = 0;
      notifyListeners();
      await for (final update in _service.measureUploadSpeed(durationSeconds: 10)) {
        _uploadSpeed = update.currentSpeed;
        _gaugeValue = update.currentSpeed;
        _progress = update.progress;
        _uploadHistory.add(update.currentSpeed);
        notifyListeners();
      }

      _state = SpeedTestState.completed;
      _currentPhase = '';
      notifyListeners();

      // Save to Supabase
      await _saveResult();
    } catch (e) {
      _errorMessage = e.toString();
      _state = SpeedTestState.error;
      notifyListeners();
    }
  }

  Future<void> _saveResult() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    try {
      await Supabase.instance.client.from('speed_tests').insert({
        'user_id': user.id,
        'download_speed': _downloadSpeed,
        'upload_speed': _uploadSpeed,
        'ping': _ping,
        'jitter': _jitter,
        'packet_loss': _packetLoss,
        'network_type': 'WiFi',
        'tested_at': DateTime.now().toIso8601String(),
      });
    } catch (_) {
      // Silently fail — test result is still shown locally
    }
  }

  void reset() {
    _subscription?.cancel();
    _state = SpeedTestState.idle;
    _downloadSpeed = 0;
    _uploadSpeed = 0;
    _ping = 0;
    _jitter = 0;
    _packetLoss = 0;
    _gaugeValue = 0;
    _currentPhase = '';
    _progress = 0;
    _downloadHistory = [];
    _uploadHistory = [];
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../speed_test/domain/entities/speed_test_result.dart';

class HistoryProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  bool _isLoading = false;
  List<SpeedTestResult> _results = [];
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<SpeedTestResult> get results => _results;
  String? get errorMessage => _errorMessage;

  Future<void> fetchHistory() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _supabase
          .from('speed_tests')
          .select()
          .eq('user_id', user.id)
          .order('tested_at', ascending: false)
          .limit(50);

      _results = (response as List)
          .map((e) => SpeedTestResult.fromMap(e as Map<String, dynamic>))
          .toList();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}

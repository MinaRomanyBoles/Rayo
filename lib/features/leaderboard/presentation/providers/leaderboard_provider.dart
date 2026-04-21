import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeaderboardProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  bool _isLoading = false;
  bool _isGlobalTab = true;
  List<Map<String, dynamic>> _rankings = [];
  String? _errorMessage;
  RealtimeChannel? _subscription;

  bool get isLoading => _isLoading;
  bool get isGlobalTab => _isGlobalTab;
  List<Map<String, dynamic>> get rankings => _rankings;
  String? get errorMessage => _errorMessage;

  LeaderboardProvider() {
    fetchRankings();
    _subscribeToUpdates();
  }

  void setTab(bool isGlobal) {
    _isGlobalTab = isGlobal;
    fetchRankings();
  }

  Future<void> fetchRankings() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch speed tests with profiles
      final response = await _supabase
          .from('speed_tests')
          .select('*, profiles!inner(username, avatar_url, country, governorate)')
          .order('download_speed', ascending: false)
          .limit(100);

      // Group by country or governorate
      final grouped = <String, List<Map<String, dynamic>>>{};
      for (final row in response) {
        final profile = row['profiles'] as Map<String, dynamic>?;
        final key = _isGlobalTab
            ? (profile?['country'] as String? ?? 'Unknown')
            : (profile?['governorate'] as String? ?? 'Unknown');
        grouped.putIfAbsent(key, () => []).add(row);
      }

      // Calculate averages and sort
      _rankings = grouped.entries.map((entry) {
        final users = entry.value;
        final avgPing = users.fold<double>(0, (sum, u) => sum + (u['ping'] as num).toDouble()) / users.length;
        return {
          'name': entry.key,
          'avgPing': avgPing,
          'users': users.map((u) {
            final p = u['profiles'] as Map<String, dynamic>?;
            return {
              'username': p?['username'] ?? 'User',
              'avatar_url': p?['avatar_url'],
              'download': (u['download_speed'] as num).toDouble(),
              'upload': (u['upload_speed'] as num).toDouble(),
              'ping': (u['ping'] as num).toDouble(),
            };
          }).toList(),
        };
      }).toList()
        ..sort((a, b) => ((a['avgPing'] as double)).compareTo(b['avgPing'] as double));

      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void _subscribeToUpdates() {
    _subscription = _supabase
        .channel('speed_tests_realtime')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'speed_tests',
          callback: (_) => fetchRankings(),
        )
        .subscribe();
  }

  @override
  void dispose() {
    _subscription?.unsubscribe();
    super.dispose();
  }
}

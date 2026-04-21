import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/user_entity.dart';

enum AuthState { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  AuthState _state = AuthState.initial;
  UserEntity? _user;
  String? _errorMessage;

  AuthState get state => _state;
  UserEntity? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _state == AuthState.authenticated;
  bool get isGuest => _user?.isGuest ?? false;

  AuthProvider() {
    _initAuth();
  }

  Future<void> _initAuth() async {
    // Keep splash visible for at least 2 seconds for animation
    await Future.delayed(const Duration(seconds: 2));

    final session = _supabase.auth.currentSession;
    if (session != null) {
      _setUserFromSession(session);
    } else {
      _state = AuthState.unauthenticated;
      notifyListeners();
    }

    // Listen for subsequent auth state changes (login/logout)
    _supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      // Ignore the initial session event — we already handled it above
      if (event == AuthChangeEvent.initialSession) return;

      if (session != null) {
        _setUserFromSession(session);
      } else {
        _state = AuthState.unauthenticated;
        _user = null;
        notifyListeners();
      }
    });
  }

  void _setUserFromSession(Session session) {
    final supaUser = session.user;
    final isAnon = supaUser.isAnonymous;
    _user = UserEntity(
      id: supaUser.id,
      username: supaUser.userMetadata?['full_name'] as String? ??
          supaUser.userMetadata?['name'] as String? ??
          (isAnon ? 'Guest' : 'User'),
      email: supaUser.email,
      avatarUrl: supaUser.userMetadata?['avatar_url'] as String?,
      isGuest: isAnon,
    );
    _state = AuthState.authenticated;
    notifyListeners();
  }

  // ─────────────────────────────────────────────
  // Sign-in Methods
  // ─────────────────────────────────────────────

  Future<void> signInWithGoogle() async {
    try {
      _state = AuthState.loading;
      notifyListeners();
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.rayo://login-callback/',
      );
      // OAuth redirects externally; onAuthStateChange handles the return
    } catch (e) {
      _errorMessage = e.toString();
      _state = AuthState.error;
      notifyListeners();
    }
  }

  Future<void> signInWithApple() async {
    try {
      _state = AuthState.loading;
      notifyListeners();
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.apple,
        redirectTo: 'io.supabase.rayo://login-callback/',
      );
    } catch (e) {
      _errorMessage = e.toString();
      _state = AuthState.error;
      notifyListeners();
    }
  }

  Future<void> signInWithHuawei() async {
    try {
      _state = AuthState.loading;
      notifyListeners();
      // Huawei OAuth is not natively supported by Supabase.
      // This uses anonymous sign-in as fallback with Huawei metadata.
      final response = await _supabase.auth.signInAnonymously();
      // Explicitly handle the response instead of relying only on the listener
      if (response.session != null) {
        _setUserFromSession(response.session!);
      } else {
        _state = AuthState.unauthenticated;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('❌ Huawei sign-in error: $e');
      _errorMessage = e.toString();
      _state = AuthState.error;
      notifyListeners();
    }
  }

  Future<void> signInAsGuest() async {
    try {
      _state = AuthState.loading;
      notifyListeners();
      final response = await _supabase.auth.signInAnonymously();
      // Explicitly handle the response — don't depend solely on the listener
      if (response.session != null) {
        _setUserFromSession(response.session!);
      } else {
        debugPrint('⚠️ signInAnonymously returned null session');
        _state = AuthState.unauthenticated;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('❌ Guest sign-in error: $e');
      _errorMessage = e.toString();
      _state = AuthState.error;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      _user = null;
      _state = AuthState.unauthenticated;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}

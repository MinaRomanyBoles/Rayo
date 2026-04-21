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

  void _initAuth() {
    final session = _supabase.auth.currentSession;
    if (session != null) {
      _setUserFromSession(session);
    } else {
      _state = AuthState.unauthenticated;
      notifyListeners();
    }

    _supabase.auth.onAuthStateChange.listen((data) {
      if (data.session != null) {
        _setUserFromSession(data.session!);
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

  Future<void> signInWithGoogle() async {
    try {
      _state = AuthState.loading;
      notifyListeners();
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.rayo://login-callback/',
      );
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
      // For full HMS Core integration, configure AppGallery Connect
      // and add a Supabase Edge Function for token verification.
      await _supabase.auth.signInAnonymously();
    } catch (e) {
      _errorMessage = e.toString();
      _state = AuthState.error;
      notifyListeners();
    }
  }

  Future<void> signInAsGuest() async {
    try {
      _state = AuthState.loading;
      notifyListeners();
      await _supabase.auth.signInAnonymously();
    } catch (e) {
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../router/main_shell.dart';

class AppRouter {
  final AuthProvider authProvider;

  AppRouter(this.authProvider);

  late final GoRouter router = GoRouter(
    initialLocation: '/splash',
    refreshListenable: authProvider,
    redirect: _redirect,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const MainShell(),
      ),
    ],
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    final authState = authProvider.state;
    final currentPath = state.matchedLocation;
    final isSplash = currentPath == '/splash';
    final isSignIn = currentPath == '/sign-in';

    // ── While auth is still initializing, keep showing splash
    if (authState == AuthState.initial || authState == AuthState.loading) {
      return isSplash ? null : '/splash';
    }

    // ── Authenticated → go home
    if (authState == AuthState.authenticated) {
      return (isSplash || isSignIn) ? '/home' : null;
    }

    // ── Unauthenticated / Error → go to sign-in
    return (isSplash || currentPath == '/home') ? '/sign-in' : null;
  }
}

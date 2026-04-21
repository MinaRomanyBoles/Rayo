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

    // ── Still initializing (app just launched) → stay on splash
    if (authState == AuthState.initial) {
      return isSplash ? null : '/splash';
    }

    // ── Loading (user pressed a sign-in button) → stay on current page
    //    Let the sign-in screen show its own loading indicator.
    if (authState == AuthState.loading) {
      return null;
    }

    // ── Authenticated → go home
    if (authState == AuthState.authenticated) {
      return (isSplash || isSignIn) ? '/home' : null;
    }

    // ── Unauthenticated / Error → go to sign-in
    return (isSplash || currentPath == '/home') ? '/sign-in' : null;
  }
}

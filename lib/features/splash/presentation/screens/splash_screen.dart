import 'package:flutter/material.dart';
import 'package:rayo_broadband_speed_test/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _glowPulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.easeOut)),
    );
    _glowPulse = Tween<double>(begin: 8.0, end: 24.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0, curve: Curves.easeInOut)),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeIn.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                // Logo "RAYO" with neon glow
                Text(
                  l10n.appName.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'AbdElRadyPro',
                    fontSize: 72,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    letterSpacing: 12,
                    shadows: [
                      Shadow(
                        color: AppColors.primary.withValues(alpha: 0.6),
                        blurRadius: _glowPulse.value,
                      ),
                      Shadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: _glowPulse.value * 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.internetSpeedTest,
                  style: TextStyle(
                    fontFamily: 'AbdElRadyPro',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary.withValues(alpha: 0.7),
                    letterSpacing: 6,
                  ),
                ),
                const Spacer(flex: 3),
                // Copyright
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '©2026 - ',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.darkTextSecondary.withValues(alpha: 0.5),
                      ),
                    ),
                    Text(
                      l10n.copyrightSimlife,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      ' - ',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.darkTextSecondary.withValues(alpha: 0.5),
                      ),
                    ),
                    Text(
                      l10n.copyrightMina,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.neonAmber,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}

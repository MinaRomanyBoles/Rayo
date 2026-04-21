import 'package:flutter/material.dart';
import 'package:rayo_broadband_speed_test/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 1),
              // Top brand
              Text(
                l10n.appName.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'AbdElRadyPro',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  letterSpacing: 8,
                  shadows: [
                    Shadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.internetSpeedTest,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.primary.withValues(alpha: 0.6),
                  letterSpacing: 4,
                ),
              ),
              const Spacer(flex: 1),
              // Hero logo
              Text(
                l10n.appName.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'AbdElRadyPro',
                  fontSize: 96,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkTextPrimary,
                  letterSpacing: 16,
                  shadows: [
                    Shadow(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      blurRadius: 40,
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              // Loading indicator
              if (auth.state == AuthState.loading)
                const Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              // Social Buttons
              _SocialButton(
                label: l10n.continueWithGoogle,
                iconWidget: const Text('G', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF4285F4))),
                backgroundColor: const Color(0xFFEEEEEE),
                textColor: Colors.black87,
                onTap: auth.state == AuthState.loading ? null : () => auth.signInWithGoogle(),
              ),
              const SizedBox(height: 12),
              _SocialButton(
                label: l10n.continueWithApple,
                iconWidget: const Icon(Icons.apple, color: Colors.white, size: 22),
                backgroundColor: const Color(0xFF2C2C2E),
                textColor: Colors.white,
                onTap: auth.state == AuthState.loading ? null : () => auth.signInWithApple(),
              ),
              const SizedBox(height: 12),
              _SocialButton(
                label: l10n.continueWithHuawei,
                iconWidget: const Icon(Icons.phone_android, color: Color(0xFFCE1D2D), size: 22),
                backgroundColor: const Color(0xFFEEEEEE),
                textColor: Colors.black87,
                onTap: auth.state == AuthState.loading ? null : () => auth.signInWithHuawei(),
              ),
              const SizedBox(height: 20),
              // Continue as Guest
              TextButton(
                onPressed: auth.state == AuthState.loading ? null : () => auth.signInAsGuest(),
                child: Text(
                  l10n.continueAsGuest,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.neonAmber,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              // Copyright
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '©2026 - ',
                    style: TextStyle(fontSize: 11, color: AppColors.darkTextSecondary.withValues(alpha: 0.5)),
                  ),
                  const Text(
                    'Simplife EG',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary),
                  ),
                  Text(
                    ' - ',
                    style: TextStyle(fontSize: 11, color: AppColors.darkTextSecondary.withValues(alpha: 0.5)),
                  ),
                  const Text(
                    'Mina Romany',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.neonAmber),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final Widget iconWidget;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onTap;

  const _SocialButton({
    required this.label,
    required this.iconWidget,
    required this.backgroundColor,
    required this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            const SizedBox(width: 12),
            Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: textColor)),
          ],
        ),
      ),
    );
  }
}

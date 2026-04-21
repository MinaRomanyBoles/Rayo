import 'package:flutter/material.dart';
import 'package:rayo_broadband_speed_test/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/theme/locale_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = context.watch<ThemeProvider>();
    final locale = context.watch<LocaleProvider>();
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(l10n.rayoSettings,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.darkTextPrimary)),
              const SizedBox(height: 4),
              Text(l10n.settingsSubtitle,
                style: const TextStyle(fontSize: 14, color: AppColors.darkTextSecondary)),
              const SizedBox(height: 28),

              // ACCOUNT INFO
              _SectionTitle(l10n.accountInfo),
              _InfoTile(
                icon: Icons.person_outline,
                title: auth.user?.username ?? 'Guest',
                subtitle: auth.user?.email ?? 'No email',
                trailing: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.darkSurfaceVariant,
                  backgroundImage: auth.user?.avatarUrl != null ? NetworkImage(auth.user!.avatarUrl!) : null,
                  child: auth.user?.avatarUrl == null
                      ? const Icon(Icons.person, size: 18, color: AppColors.primary)
                      : null,
                ),
              ),
              const SizedBox(height: 24),

              // THEME & LANGUAGE
              _SectionTitle(l10n.themeAndLanguage),
              _SettingsTile(
                icon: Icons.dark_mode_outlined,
                title: l10n.themeMode,
                subtitle: theme.isDarkMode ? l10n.activeDarkMode : l10n.activeLightMode,
                trailing: Switch.adaptive(
                  value: theme.isDarkMode,
                  activeTrackColor: AppColors.primary,
                  onChanged: (_) => theme.toggleTheme(),
                ),
              ),
              _SettingsTile(
                icon: Icons.language,
                title: l10n.language,
                subtitle: locale.isArabic ? 'العربية' : 'English',
                trailing: Switch.adaptive(
                  value: locale.isArabic,
                  activeTrackColor: AppColors.primary,
                  onChanged: (_) => locale.toggleLocale(),
                ),
              ),
              const SizedBox(height: 24),

              // ABOUT RAYO
              _SectionTitle(l10n.aboutRayo),
              _SettingsTile(
                icon: Icons.description_outlined,
                title: l10n.termsOfService,
                trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.darkTextSecondary),
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.shield_outlined,
                title: l10n.privacyProtocol,
                trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.darkTextSecondary),
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.info_outline,
                title: l10n.coreVersion,
                trailing: const Text('1.0.0', style: TextStyle(fontSize: 13, color: AppColors.darkTextSecondary)),
              ),
              const SizedBox(height: 32),

              // LOGOUT
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () async {
                    await auth.signOut();
                    if (context.mounted) context.go('/sign-in');
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.error, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(l10n.logout,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.error,
                      letterSpacing: 2,
                    )),
                ),
              ),
              const SizedBox(height: 24),

              // Copyright
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('©2026 - ', style: TextStyle(fontSize: 11, color: AppColors.darkTextSecondary.withValues(alpha: 0.5))),
                    const Text('Simplife EG', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary)),
                    Text(' - ', style: TextStyle(fontSize: 11, color: AppColors.darkTextSecondary.withValues(alpha: 0.5))),
                    const Text('Mina Romany', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.neonAmber)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.darkTextSecondary,
          letterSpacing: 1.5,
        )),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;

  const _InfoTile({required this.icon, required this.title, required this.subtitle, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder, width: 0.5),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.darkTextPrimary)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.darkTextSecondary)),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({required this.icon, required this.title, this.subtitle, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder, width: 0.5),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, size: 20, color: AppColors.primary),
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.darkTextPrimary)),
        subtitle: subtitle != null
            ? Text(subtitle!, style: const TextStyle(fontSize: 12, color: AppColors.darkTextSecondary))
            : null,
        trailing: trailing,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

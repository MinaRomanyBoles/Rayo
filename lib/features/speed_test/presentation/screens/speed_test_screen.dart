import 'package:flutter/material.dart';
import 'package:rayo_broadband_speed_test/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/speed_test_provider.dart';
import '../widgets/speed_gauge.dart';
import '../widgets/speed_card.dart';
import '../widgets/stats_row.dart';

class SpeedTestScreen extends StatelessWidget {
  const SpeedTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final auth = context.watch<AuthProvider>();
    final test = context.watch<SpeedTestProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // AppBar with Avatar
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.darkSurface,
                      backgroundImage: auth.user?.avatarUrl != null
                          ? NetworkImage(auth.user!.avatarUrl!)
                          : null,
                      child: auth.user?.avatarUrl == null
                          ? const Icon(Icons.person, color: AppColors.primary, size: 22)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        auth.user?.username ?? 'Guest',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkTextPrimary,
                        ),
                      ),
                      Text(
                        auth.user?.email ?? 'User@Mail.Com',
                        style: const TextStyle(fontSize: 12, color: AppColors.darkTextSecondary),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Speed Gauge
              SpeedGauge(
                value: test.gaugeValue,
                isActive: test.state == SpeedTestState.testing,
              ),
              const SizedBox(height: 24),
              // Start Test Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: test.state == SpeedTestState.testing
                      ? null
                      : () => test.startTest(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.black,
                    disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: test.state == SpeedTestState.testing
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 18, height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              l10n.testing,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          l10n.startTest,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              // Download / Upload Cards
              Row(
                children: [
                  SpeedCard(
                    label: l10n.download,
                    speed: test.downloadSpeed,
                    history: test.downloadHistory,
                    color: AppColors.downloadColor,
                    icon: Icons.arrow_downward,
                  ),
                  const SizedBox(width: 12),
                  SpeedCard(
                    label: l10n.upload,
                    speed: test.uploadSpeed,
                    history: test.uploadHistory,
                    color: AppColors.uploadColor,
                    icon: Icons.arrow_upward,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Stats Row
              StatsRow(
                ping: test.ping,
                jitter: test.jitter,
                packetLoss: test.packetLoss,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

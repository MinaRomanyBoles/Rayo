import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'mini_line_chart.dart';

class SpeedCard extends StatelessWidget {
  final String label;
  final double speed;
  final List<double> history;
  final Color color;
  final IconData icon;

  const SpeedCard({
    super.key,
    required this.label,
    required this.speed,
    required this.history,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.darkBorder, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 14, color: color),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  speed.toStringAsFixed(1),
                  style: const TextStyle(
                    fontFamily: 'AbdElRadyPro',
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkTextPrimary,
                    height: 1.0,
                  ),
                ),
                const SizedBox(width: 4),
                const Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Mbps',
                    style: TextStyle(fontSize: 12, color: AppColors.darkTextSecondary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            MiniLineChart(data: history, color: color, height: 35),
          ],
        ),
      ),
    );
  }
}

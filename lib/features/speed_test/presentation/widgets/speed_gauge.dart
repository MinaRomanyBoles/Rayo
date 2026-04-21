import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SpeedGauge extends StatefulWidget {
  final double value;
  final double maxValue;
  final bool isActive;

  const SpeedGauge({
    super.key,
    required this.value,
    this.maxValue = 1000,
    this.isActive = false,
  });

  @override
  State<SpeedGauge> createState() => _SpeedGaugeState();
}

class _SpeedGaugeState extends State<SpeedGauge> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _animation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void didUpdateWidget(SpeedGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = Tween<double>(begin: _previousValue, end: widget.value).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller.forward(from: 0);
      _previousValue = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          width: 280,
          height: 280,
          child: CustomPaint(
            painter: _GaugePainter(
              value: _animation.value,
              maxValue: widget.maxValue,
              isActive: widget.isActive,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _animation.value.toStringAsFixed(0),
                    style: const TextStyle(
                      fontFamily: 'AbdElRadyPro',
                      fontSize: 64,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkTextPrimary,
                      height: 1.0,
                    ),
                  ),
                  const Text(
                    'MBPS',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkTextSecondary,
                      letterSpacing: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double value;
  final double maxValue;
  final bool isActive;

  _GaugePainter({required this.value, required this.maxValue, required this.isActive});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;
    const startAngle = 135 * pi / 180;
    const sweepAngle = 270 * pi / 180;

    // Background arc
    final bgPaint = Paint()
      ..color = AppColors.darkBorder.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle, sweepAngle, false, bgPaint,
    );

    // Value arc with gradient
    if (value > 0) {
      final valueSweep = (value / maxValue).clamp(0.0, 1.0) * sweepAngle;
      final gradientPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round
        ..shader = SweepGradient(
          startAngle: startAngle,
          endAngle: startAngle + sweepAngle,
          colors: const [AppColors.primary, AppColors.secondary],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle, valueSweep, false, gradientPaint,
      );
    }

    // Tick marks
    for (var i = 0; i <= 10; i++) {
      final angle = startAngle + (i / 10) * sweepAngle;
      final isMain = i % 2 == 0;
      final outerR = radius + 12;
      final innerR = radius + (isMain ? 4 : 7);
      final outer = Offset(center.dx + outerR * cos(angle), center.dy + outerR * sin(angle));
      final inner = Offset(center.dx + innerR * cos(angle), center.dy + innerR * sin(angle));
      canvas.drawLine(inner, outer, Paint()
        ..color = AppColors.darkTextDisabled.withValues(alpha: 0.5)
        ..strokeWidth = isMain ? 2 : 1);
    }

    // Needle
    if (value > 0) {
      final needleAngle = startAngle + (value / maxValue).clamp(0.0, 1.0) * sweepAngle;
      final needleTip = Offset(
        center.dx + (radius - 20) * cos(needleAngle),
        center.dy + (radius - 20) * sin(needleAngle),
      );

      // Needle line
      canvas.drawLine(center, needleTip, Paint()
        ..color = AppColors.primary
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round);

      // Pivot dot with glow
      canvas.drawCircle(center, 8, Paint()
        ..color = AppColors.primary.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8));
      canvas.drawCircle(center, 5, Paint()..color = AppColors.primary);
    }
  }

  @override
  bool shouldRepaint(covariant _GaugePainter old) =>
      old.value != value || old.isActive != isActive;
}

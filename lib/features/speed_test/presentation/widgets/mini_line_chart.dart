import 'dart:math';
import 'package:flutter/material.dart';

class MiniLineChart extends StatelessWidget {
  final List<double> data;
  final Color color;
  final double height;

  const MiniLineChart({
    super.key,
    required this.data,
    required this.color,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _MiniLineChartPainter(data: data, color: color),
      ),
    );
  }
}

class _MiniLineChartPainter extends CustomPainter {
  final List<double> data;
  final Color color;

  _MiniLineChartPainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final maxVal = data.reduce(max);
    if (maxVal == 0) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withValues(alpha: 0.3), color.withValues(alpha: 0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final fillPath = Path();
    final stepX = size.width / (data.length - 1).clamp(1, double.infinity);

    for (var i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - (data[i] / maxVal) * size.height * 0.85;
      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    // Fill area
    fillPath.lineTo((data.length - 1) * stepX, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);

    // Line
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _MiniLineChartPainter old) =>
      old.data.length != data.length || old.color != color;
}

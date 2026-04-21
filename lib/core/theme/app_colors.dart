import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ==========================================
  // 🎨 1. Brand Colors (Figma Design)
  // ==========================================
  static const Color primary = Color(0xFF00D4FF);
  static const Color secondary = Color(0xFFC100FF);
  static const Color neonAmber = Color(0xFFFFAB00);
  static const Color success = Color(0xFF00E676);
  static const Color warning = Color(0xFFFFAB00);
  static const Color error = Color(0xFFFF3B3B);

  // ==========================================
  // 🌈 2. Gradients
  // ==========================================
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const SweepGradient gaugeGradient = SweepGradient(
    startAngle: 2.4,
    endAngle: 7.0,
    colors: [primary, secondary, primary],
  );

  // ==========================================
  // 🌒 3. Dark Mode Colors
  // ==========================================
  static const Color darkBackground = Color(0xFF0B0C10);
  static const Color darkSurface = Color(0xFF141620);
  static const Color darkSurfaceVariant = Color(0xFF1E2030);
  static const Color darkBorder = Color(0xFF2A2D3E);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFA1A1AA);
  static const Color darkTextDisabled = Color(0xFF52525B);

  // ==========================================
  // ☀️ 4. Light Mode Colors
  // ==========================================
  static const Color lightBackground = Color(0xFFF4F6F9);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFEEF0F4);
  static const Color lightBorder = Color(0xFFE0E2E8);
  static const Color lightTextPrimary = Color(0xFF0B0D17);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightTextDisabled = Color(0xFF9CA3AF);

  // ==========================================
  // 🧭 5. Navigation
  // ==========================================
  static const Color navActive = primary;
  static const Color navInactive = Color(0xFF52525B);

  // ==========================================
  // 📊 6. Speed Test Metrics
  // ==========================================
  static const Color downloadColor = primary;
  static const Color uploadColor = secondary;
  static const Color pingColor = Color(0xFFFFAB00);
  static const Color jitterColor = Color(0xFF00E676);
  static const Color lossColor = Color(0xFFFF3B3B);
}
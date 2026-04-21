import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  static const String fontFamily = 'AbdElRadyPro';

  // ==========================================
  // Weights
  // ==========================================
  static const TextStyle regular = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle medium = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle semiBold = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bold = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle extraBold = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w800,
  );

  // ==========================================
  // TextTheme Builder
  // ==========================================
  static TextTheme getTextTheme(Color textColor) {
    return TextTheme(
      displayLarge: extraBold.copyWith(fontSize: 72, color: textColor, letterSpacing: -1.5, height: 1.0),
      displayMedium: bold.copyWith(fontSize: 56, color: textColor, letterSpacing: -1.0, height: 1.1),
      displaySmall: bold.copyWith(fontSize: 40, color: textColor, letterSpacing: -0.5, height: 1.1),
      headlineLarge: bold.copyWith(fontSize: 28, color: textColor, letterSpacing: -0.5, height: 1.2),
      headlineMedium: semiBold.copyWith(fontSize: 24, color: textColor, height: 1.3),
      headlineSmall: semiBold.copyWith(fontSize: 20, color: textColor, height: 1.3),
      titleLarge: semiBold.copyWith(fontSize: 18, color: textColor, height: 1.4),
      titleMedium: medium.copyWith(fontSize: 16, color: textColor, letterSpacing: 0.15, height: 1.4),
      titleSmall: medium.copyWith(fontSize: 14, color: textColor, letterSpacing: 0.1, height: 1.4),
      bodyLarge: regular.copyWith(fontSize: 16, color: textColor, height: 1.5),
      bodyMedium: regular.copyWith(fontSize: 14, color: textColor, height: 1.5),
      bodySmall: regular.copyWith(fontSize: 12, color: textColor, height: 1.5),
      labelLarge: semiBold.copyWith(fontSize: 14, color: textColor, letterSpacing: 0.5, height: 1.4),
      labelMedium: medium.copyWith(fontSize: 12, color: textColor, letterSpacing: 0.5, height: 1.4),
      labelSmall: medium.copyWith(fontSize: 10, color: textColor, letterSpacing: 0.5, height: 1.4),
    );
  }
}
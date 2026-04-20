import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // لمنع إنشاء كائن من هذا الكلاس

  // ==========================================
  // 🎨 1. ألوان الهوية الرئيسية (من تصميم Figma)
  // ==========================================

  /// اللون السيان الرئيسي - زر START TEST، العناوين، الأيقونات النشطة
  static const Color primary = Color(0xFF00D4FF);

  /// اللون البنفسجي الثانوي - مؤشر الرفع (Upload)، تدرج القرص
  static const Color secondary = Color(0xFFC100FF);

  /// اللون الأخضر - مؤشرات النجاح والاتصال الجيد
  static const Color success = Color(0xFF00E676);

  /// اللون البرتقالي/الأصفر - مؤشرات التحذير (Ping العالي)
  static const Color warning = Color(0xFFFFAB00);

  /// اللون الأحمر - أخطاء وزر تسجيل الخروج
  static const Color error = Color(0xFFFF3B3B);

  // ==========================================
  // 🌈 2. تدرجات الألوان (Gradients)
  // ==========================================

  /// التدرج الرئيسي: سيان → بنفسجي (يُستخدم في قوس عداد السرعة)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// التدرج الدائري لعداد السرعة
  static const SweepGradient gaugeGradient = SweepGradient(
    startAngle: 2.4,
    endAngle: 7.0,
    colors: [primary, secondary, primary],
  );

  // ==========================================
  // 🌒 3. الألوان الحيادية والخلفيات (Dark Mode - المطابقة للتصميم)
  // ==========================================

  /// الخلفية الرئيسية للتطبيق - أسود مُزرق عميق
  static const Color darkBackground = Color(0xFF0B0D17);

  /// لون الكروت والحاويات - رمادي داكن مع لمسة زرقاء
  static const Color darkSurface = Color(0xFF141620);

  /// لون السطح النشط/المحدد - أفتح قليلاً
  static const Color darkSurfaceVariant = Color(0xFF1E2030);

  /// حدود الكروت والعناصر
  static const Color darkBorder = Color(0xFF2A2D3E);

  /// نص رئيسي - أبيض ناصع (الأرقام الكبيرة، العناوين)
  static const Color darkTextPrimary = Color(0xFFFFFFFF);

  /// نص ثانوي - رمادي فاتح (التسميات، الأوصاف)
  static const Color darkTextSecondary = Color(0xFFA1A1AA);

  /// نص معطل - رمادي داكن
  static const Color darkTextDisabled = Color(0xFF52525B);

  // ==========================================
  // ☀️ 4. الألوان الحيادية والخلفيات (Light Mode - مقترحة)
  // ==========================================

  /// الخلفية الرئيسية للوضع الفاتح
  static const Color lightBackground = Color(0xFFF4F6F9);

  /// لون الكروت في الوضع الفاتح
  static const Color lightSurface = Color(0xFFFFFFFF);

  /// لون السطح المتغير في الوضع الفاتح
  static const Color lightSurfaceVariant = Color(0xFFEEF0F4);

  /// حدود العناصر في الوضع الفاتح
  static const Color lightBorder = Color(0xFFE0E2E8);

  /// نص رئيسي في الوضع الفاتح
  static const Color lightTextPrimary = Color(0xFF0B0D17);

  /// نص ثانوي في الوضع الفاتح
  static const Color lightTextSecondary = Color(0xFF6B7280);

  /// نص معطل في الوضع الفاتح
  static const Color lightTextDisabled = Color(0xFF9CA3AF);

  // ==========================================
  // 🧭 5. ألوان شريط التنقل (Bottom Navigation)
  // ==========================================

  /// لون الأيقونة النشطة (سيان)
  static const Color navActive = primary;

  /// لون الأيقونة غير النشطة
  static const Color navInactive = Color(0xFF52525B);

  // ==========================================
  // 📊 6. ألوان مخصصة لنتائج الاختبار
  // ==========================================

  /// لون مؤشر التحميل (Download) - سيان
  static const Color downloadColor = primary;

  /// لون مؤشر الرفع (Upload) - بنفسجي
  static const Color uploadColor = secondary;

  /// لون مؤشر الـ Ping
  static const Color pingColor = Color(0xFFFFAB00);

  /// لون مؤشر الـ Jitter
  static const Color jitterColor = Color(0xFF00E676);

  /// لون مؤشر فقد الحزم (Loss)
  static const Color lossColor = Color(0xFFFF3B3B);
}
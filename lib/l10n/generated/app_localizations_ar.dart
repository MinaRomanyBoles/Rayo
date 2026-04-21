// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'رايو';

  @override
  String get internetSpeedTest => 'اختبار سرعة الإنترنت';

  @override
  String get startTest => 'ابدأ الاختبار';

  @override
  String get testing => 'جاري الاختبار...';

  @override
  String get download => 'تحميل';

  @override
  String get upload => 'رفع';

  @override
  String get ping => 'بينج';

  @override
  String get jitter => 'تذبذب';

  @override
  String get packetLoss => 'فقد';

  @override
  String get mbps => 'م.ب/ث';

  @override
  String get ms => 'م.ث';

  @override
  String get networkRankings => 'تصنيف الشبكات';

  @override
  String get rankingsSubtitle => 'بيانات فورية ومقارنة السرعات.';

  @override
  String get globalCountries => 'عالمي (دول)';

  @override
  String get localGovernorates => 'محلي (محافظات)';

  @override
  String avgPing(String value) {
    return 'متوسط البينج: $value م.ث';
  }

  @override
  String get testHistory => 'سجل الاختبارات';

  @override
  String get historySubtitle => 'راجع تشخيصات شبكتك السابقة.';

  @override
  String get settings => 'الإعدادات';

  @override
  String get rayoSettings => 'إعدادات رايو';

  @override
  String get settingsSubtitle => 'يتم حفظ التغييرات فور إجرائها.';

  @override
  String get accountInfo => 'معلومات الحساب';

  @override
  String get themeAndLanguage => 'المظهر واللغة';

  @override
  String get themeMode => 'وضع المظهر';

  @override
  String get activeDarkMode => 'الوضع المظلم مفعّل';

  @override
  String get activeLightMode => 'الوضع المضيء مفعّل';

  @override
  String get language => 'اللغة';

  @override
  String get selectLanguage => 'اختر لغتك';

  @override
  String get aboutRayo => 'عن رايو';

  @override
  String get termsOfService => 'شروط الخدمة';

  @override
  String get privacyProtocol => 'سياسة الخصوصية';

  @override
  String get coreVersion => 'إصدار النواة';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get continueAsGuest => 'المتابعة كزائر';

  @override
  String get continueWithGoogle => 'المتابعة بحساب جوجل';

  @override
  String get continueWithApple => 'المتابعة بحساب آبل';

  @override
  String get continueWithHuawei => 'المتابعة بحساب هواوي';

  @override
  String get noHistory => 'لا توجد اختبارات بعد. ابدأ أول اختبار سرعة!';

  @override
  String get errorOccurred => 'حدث خطأ. يرجى المحاولة مرة أخرى.';

  @override
  String get networkType => 'نوع الشبكة';

  @override
  String get copyrightSimlife => 'سيمبلايف إيجي';

  @override
  String get copyrightMina => 'مينا رماني';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Rayo';

  @override
  String get internetSpeedTest => 'INTERNET SPEED TEST';

  @override
  String get startTest => 'START TEST';

  @override
  String get testing => 'TESTING...';

  @override
  String get download => 'DOWNLOAD';

  @override
  String get upload => 'UPLOAD';

  @override
  String get ping => 'PING';

  @override
  String get jitter => 'JITTER';

  @override
  String get packetLoss => 'LOSS';

  @override
  String get mbps => 'Mbps';

  @override
  String get ms => 'ms';

  @override
  String get networkRankings => 'Network Rankings';

  @override
  String get rankingsSubtitle => 'Real-time telemetry and peer speeds.';

  @override
  String get globalCountries => 'Global (Countries)';

  @override
  String get localGovernorates => 'Local (Governorates)';

  @override
  String avgPing(String value) {
    return 'Avg Ping: ${value}ms';
  }

  @override
  String get testHistory => 'Test History';

  @override
  String get historySubtitle => 'Review your past network diagnostics.';

  @override
  String get settings => 'Settings';

  @override
  String get rayoSettings => 'Rayo Settings';

  @override
  String get settingsSubtitle => 'Changes are saved as soon as they are made.';

  @override
  String get accountInfo => 'ACCOUNT INFO';

  @override
  String get themeAndLanguage => 'THEME & LANGUAGE';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get activeDarkMode => 'Active Dark Mode';

  @override
  String get activeLightMode => 'Active Light Mode';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Your Language';

  @override
  String get aboutRayo => 'ABOUT RAYO';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyProtocol => 'Privacy Protocol';

  @override
  String get coreVersion => 'Core Version';

  @override
  String get logout => 'LOGOUT';

  @override
  String get continueAsGuest => 'CONTINUE AS GUEST';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get continueWithHuawei => 'Continue with Huawei';

  @override
  String get noHistory => 'No tests yet. Run your first speed test!';

  @override
  String get errorOccurred => 'An error occurred. Please try again.';

  @override
  String get networkType => 'Network';

  @override
  String get copyrightSimlife => 'Simplife EG';

  @override
  String get copyrightMina => 'Mina Romany';
}

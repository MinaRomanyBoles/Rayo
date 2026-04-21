import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Rayo'**
  String get appName;

  /// No description provided for @internetSpeedTest.
  ///
  /// In en, this message translates to:
  /// **'INTERNET SPEED TEST'**
  String get internetSpeedTest;

  /// No description provided for @startTest.
  ///
  /// In en, this message translates to:
  /// **'START TEST'**
  String get startTest;

  /// No description provided for @testing.
  ///
  /// In en, this message translates to:
  /// **'TESTING...'**
  String get testing;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'DOWNLOAD'**
  String get download;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'UPLOAD'**
  String get upload;

  /// No description provided for @ping.
  ///
  /// In en, this message translates to:
  /// **'PING'**
  String get ping;

  /// No description provided for @jitter.
  ///
  /// In en, this message translates to:
  /// **'JITTER'**
  String get jitter;

  /// No description provided for @packetLoss.
  ///
  /// In en, this message translates to:
  /// **'LOSS'**
  String get packetLoss;

  /// No description provided for @mbps.
  ///
  /// In en, this message translates to:
  /// **'Mbps'**
  String get mbps;

  /// No description provided for @ms.
  ///
  /// In en, this message translates to:
  /// **'ms'**
  String get ms;

  /// No description provided for @networkRankings.
  ///
  /// In en, this message translates to:
  /// **'Network Rankings'**
  String get networkRankings;

  /// No description provided for @rankingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Real-time telemetry and peer speeds.'**
  String get rankingsSubtitle;

  /// No description provided for @globalCountries.
  ///
  /// In en, this message translates to:
  /// **'Global (Countries)'**
  String get globalCountries;

  /// No description provided for @localGovernorates.
  ///
  /// In en, this message translates to:
  /// **'Local (Governorates)'**
  String get localGovernorates;

  /// No description provided for @avgPing.
  ///
  /// In en, this message translates to:
  /// **'Avg Ping: {value}ms'**
  String avgPing(String value);

  /// No description provided for @testHistory.
  ///
  /// In en, this message translates to:
  /// **'Test History'**
  String get testHistory;

  /// No description provided for @historySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review your past network diagnostics.'**
  String get historySubtitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @rayoSettings.
  ///
  /// In en, this message translates to:
  /// **'Rayo Settings'**
  String get rayoSettings;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Changes are saved as soon as they are made.'**
  String get settingsSubtitle;

  /// No description provided for @accountInfo.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT INFO'**
  String get accountInfo;

  /// No description provided for @themeAndLanguage.
  ///
  /// In en, this message translates to:
  /// **'THEME & LANGUAGE'**
  String get themeAndLanguage;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// No description provided for @activeDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Active Dark Mode'**
  String get activeDarkMode;

  /// No description provided for @activeLightMode.
  ///
  /// In en, this message translates to:
  /// **'Active Light Mode'**
  String get activeLightMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Your Language'**
  String get selectLanguage;

  /// No description provided for @aboutRayo.
  ///
  /// In en, this message translates to:
  /// **'ABOUT RAYO'**
  String get aboutRayo;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @privacyProtocol.
  ///
  /// In en, this message translates to:
  /// **'Privacy Protocol'**
  String get privacyProtocol;

  /// No description provided for @coreVersion.
  ///
  /// In en, this message translates to:
  /// **'Core Version'**
  String get coreVersion;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'LOGOUT'**
  String get logout;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE AS GUEST'**
  String get continueAsGuest;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @continueWithHuawei.
  ///
  /// In en, this message translates to:
  /// **'Continue with Huawei'**
  String get continueWithHuawei;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No tests yet. Run your first speed test!'**
  String get noHistory;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get errorOccurred;

  /// No description provided for @networkType.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get networkType;

  /// No description provided for @copyrightSimlife.
  ///
  /// In en, this message translates to:
  /// **'Simplife EG'**
  String get copyrightSimlife;

  /// No description provided for @copyrightMina.
  ///
  /// In en, this message translates to:
  /// **'Mina Romany'**
  String get copyrightMina;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

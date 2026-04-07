import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
    Locale('en'),
    Locale('pl'),
  ];

  /// No description provided for @appHomeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get appHomeTab;

  /// No description provided for @appProfileTab.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get appProfileTab;

  /// No description provided for @changeThemeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Change theme'**
  String get changeThemeTooltip;

  /// No description provided for @changeLanguageTooltip.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguageTooltip;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languagePolish.
  ///
  /// In en, this message translates to:
  /// **'Polish'**
  String get languagePolish;

  /// No description provided for @dailyMomentumTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Momentum'**
  String get dailyMomentumTitle;

  /// No description provided for @noHabitsYetTitle.
  ///
  /// In en, this message translates to:
  /// **'No habits yet'**
  String get noHabitsYetTitle;

  /// No description provided for @noHabitsYetDescription.
  ///
  /// In en, this message translates to:
  /// **'Start with one tiny routine and build your daily momentum.'**
  String get noHabitsYetDescription;

  /// No description provided for @createFirstHabit.
  ///
  /// In en, this message translates to:
  /// **'Create first habit'**
  String get createFirstHabit;

  /// No description provided for @completionPercentLabel.
  ///
  /// In en, this message translates to:
  /// **'{percent}% Complete'**
  String completionPercentLabel(int percent);

  /// No description provided for @createHabitTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Habit'**
  String get createHabitTitle;

  /// No description provided for @editHabitTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Habit'**
  String get editHabitTitle;

  /// No description provided for @habitNameRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get habitNameRequiredError;

  /// No description provided for @creatingHabit.
  ///
  /// In en, this message translates to:
  /// **'Creating...'**
  String get creatingHabit;

  /// No description provided for @savingHabit.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get savingHabit;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @createHabit.
  ///
  /// In en, this message translates to:
  /// **'Create habit'**
  String get createHabit;

  /// No description provided for @habitNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get habitNameLabel;

  /// No description provided for @habitNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Drink water'**
  String get habitNameHint;

  /// No description provided for @habitDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get habitDescriptionLabel;

  /// No description provided for @habitDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Optional notes for this habit'**
  String get habitDescriptionHint;

  /// No description provided for @habitIconLabel.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get habitIconLabel;

  /// No description provided for @habitActionsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Habit actions'**
  String get habitActionsTooltip;

  /// No description provided for @editAction.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editAction;

  /// No description provided for @deleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAction;

  /// No description provided for @completedToday.
  ///
  /// In en, this message translates to:
  /// **'Completed today'**
  String get completedToday;

  /// No description provided for @tapToComplete.
  ///
  /// In en, this message translates to:
  /// **'Tap to complete'**
  String get tapToComplete;

  /// No description provided for @deleteHabitTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete habit?'**
  String get deleteHabitTitle;

  /// No description provided for @deleteHabitMessage.
  ///
  /// In en, this message translates to:
  /// **'This will permanently remove \"{habitName}\" from your list.'**
  String deleteHabitMessage(String habitName);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track consistency, review your history, and plan your next streak.'**
  String get profileSubtitle;

  /// No description provided for @statsToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get statsToday;

  /// No description provided for @statsHabitsDone.
  ///
  /// In en, this message translates to:
  /// **'Habits done'**
  String get statsHabitsDone;

  /// No description provided for @statsCompletion.
  ///
  /// In en, this message translates to:
  /// **'Completion'**
  String get statsCompletion;

  /// No description provided for @statsDailySuccess.
  ///
  /// In en, this message translates to:
  /// **'Daily success'**
  String get statsDailySuccess;

  /// No description provided for @statsAllTime.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get statsAllTime;

  /// No description provided for @statsCompletions.
  ///
  /// In en, this message translates to:
  /// **'Completions'**
  String get statsCompletions;

  /// No description provided for @statsBestStreak.
  ///
  /// In en, this message translates to:
  /// **'Best Streak'**
  String get statsBestStreak;

  /// No description provided for @statsCurrentStreakMax.
  ///
  /// In en, this message translates to:
  /// **'Current streak max'**
  String get statsCurrentStreakMax;

  /// No description provided for @lastSevenDays.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get lastSevenDays;

  /// No description provided for @weeklyTooltip.
  ///
  /// In en, this message translates to:
  /// **'{day}\n{count} completed'**
  String weeklyTooltip(String day, int count);

  /// No description provided for @legendCompletedHabitsPerDay.
  ///
  /// In en, this message translates to:
  /// **'Completed habits per day'**
  String get legendCompletedHabitsPerDay;

  /// No description provided for @legendTimelineLastSevenDays.
  ///
  /// In en, this message translates to:
  /// **'Mon-Sun timeline (last 7 days)'**
  String get legendTimelineLastSevenDays;

  /// No description provided for @completedOnDay.
  ///
  /// In en, this message translates to:
  /// **'Completed on {dayLabel}'**
  String completedOnDay(String dayLabel);

  /// No description provided for @noCompletedHabitsOnDay.
  ///
  /// In en, this message translates to:
  /// **'No completed habits on this day.'**
  String get noCompletedHabitsOnDay;

  /// No description provided for @iconLabelGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get iconLabelGeneral;

  /// No description provided for @iconLabelHydration.
  ///
  /// In en, this message translates to:
  /// **'Hydration'**
  String get iconLabelHydration;

  /// No description provided for @iconLabelMindfulness.
  ///
  /// In en, this message translates to:
  /// **'Mindfulness'**
  String get iconLabelMindfulness;

  /// No description provided for @iconLabelWorkout.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get iconLabelWorkout;

  /// No description provided for @iconLabelReading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get iconLabelReading;

  /// No description provided for @iconLabelSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get iconLabelSleep;

  /// No description provided for @iconLabelNutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get iconLabelNutrition;

  /// No description provided for @iconLabelRunning.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get iconLabelRunning;

  /// No description provided for @iconLabelMusic.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get iconLabelMusic;

  /// No description provided for @iconLabelLearning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get iconLabelLearning;

  /// No description provided for @iconLabelFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get iconLabelFinance;

  /// No description provided for @iconLabelWellness.
  ///
  /// In en, this message translates to:
  /// **'Wellness'**
  String get iconLabelWellness;

  /// No description provided for @iconLabelHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get iconLabelHealth;

  /// No description provided for @iconLabelHygiene.
  ///
  /// In en, this message translates to:
  /// **'Hygiene'**
  String get iconLabelHygiene;

  /// No description provided for @iconLabelCoding.
  ///
  /// In en, this message translates to:
  /// **'Coding'**
  String get iconLabelCoding;

  /// No description provided for @iconLabelLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get iconLabelLanguage;

  /// No description provided for @iconLabelPetCare.
  ///
  /// In en, this message translates to:
  /// **'Pet Care'**
  String get iconLabelPetCare;

  /// No description provided for @iconLabelNature.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get iconLabelNature;

  /// No description provided for @iconLabelStyle.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get iconLabelStyle;

  /// No description provided for @iconLabelTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get iconLabelTravel;

  /// No description provided for @iconLabelNoSmoking.
  ///
  /// In en, this message translates to:
  /// **'No Smoking'**
  String get iconLabelNoSmoking;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Build momentum, one habit at a time'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'HabitForge helps you stay consistent every day and grow streaks that matter.'**
  String get onboardingSubtitle;

  /// No description provided for @onboardingPointConsistency.
  ///
  /// In en, this message translates to:
  /// **'Track daily habits with one tap'**
  String get onboardingPointConsistency;

  /// No description provided for @onboardingPointProgress.
  ///
  /// In en, this message translates to:
  /// **'See your progress on clear charts'**
  String get onboardingPointProgress;

  /// No description provided for @onboardingPointFocus.
  ///
  /// In en, this message translates to:
  /// **'Keep your routine simple and focused'**
  String get onboardingPointFocus;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onboardingGetStarted;
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
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

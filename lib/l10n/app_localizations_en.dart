// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appHomeTab => 'Home';

  @override
  String get appProfileTab => 'Profile';

  @override
  String get changeThemeTooltip => 'Change theme';

  @override
  String get changeLanguageTooltip => 'Change language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languagePolish => 'Polish';

  @override
  String get dailyMomentumTitle => 'Daily Momentum';

  @override
  String get noHabitsYetTitle => 'No habits yet';

  @override
  String get noHabitsYetDescription =>
      'Start with one tiny routine and build your daily momentum.';

  @override
  String get createFirstHabit => 'Create first habit';

  @override
  String completionPercentLabel(int percent) {
    return '$percent% Complete';
  }

  @override
  String get createHabitTitle => 'Create Habit';

  @override
  String get editHabitTitle => 'Edit Habit';

  @override
  String get habitNameRequiredError => 'Name is required';

  @override
  String get creatingHabit => 'Creating...';

  @override
  String get savingHabit => 'Saving...';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get createHabit => 'Create habit';

  @override
  String get habitNameLabel => 'Name';

  @override
  String get habitNameHint => 'e.g. Drink water';

  @override
  String get habitDescriptionLabel => 'Description';

  @override
  String get habitDescriptionHint => 'Optional notes for this habit';

  @override
  String get habitReminderLabel => 'Daily reminder';

  @override
  String get habitReminderDescription => 'Get a local notification every day.';

  @override
  String habitReminderTime(String time) {
    return 'Reminder time: $time';
  }

  @override
  String get habitIconLabel => 'Icon';

  @override
  String get habitActionsTooltip => 'Habit actions';

  @override
  String get editAction => 'Edit';

  @override
  String get deleteAction => 'Delete';

  @override
  String get completedToday => 'Completed today';

  @override
  String get tapToComplete => 'Tap to complete';

  @override
  String get deleteHabitTitle => 'Delete habit?';

  @override
  String deleteHabitMessage(String habitName) {
    return 'This will permanently remove \"$habitName\" from your list.';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileSubtitle =>
      'Track consistency, review your history, and plan your next streak.';

  @override
  String get statsToday => 'Today';

  @override
  String get statsHabitsDone => 'Habits done';

  @override
  String get statsCompletion => 'Completion';

  @override
  String get statsDailySuccess => 'Daily success';

  @override
  String get statsAllTime => 'All Time';

  @override
  String get statsCompletions => 'Completions';

  @override
  String get statsBestStreak => 'Best Streak';

  @override
  String get statsCurrentStreakMax => 'Current streak max';

  @override
  String get lastSevenDays => 'Last 7 days';

  @override
  String weeklyTooltip(String day, int count) {
    return '$day\n$count completed';
  }

  @override
  String get legendCompletedHabitsPerDay => 'Completed habits per day';

  @override
  String get legendTimelineLastSevenDays => 'Mon-Sun timeline (last 7 days)';

  @override
  String completedOnDay(String dayLabel) {
    return 'Completed on $dayLabel';
  }

  @override
  String get noCompletedHabitsOnDay => 'No completed habits on this day.';

  @override
  String get iconLabelGeneral => 'General';

  @override
  String get iconLabelHydration => 'Hydration';

  @override
  String get iconLabelMindfulness => 'Mindfulness';

  @override
  String get iconLabelWorkout => 'Workout';

  @override
  String get iconLabelReading => 'Reading';

  @override
  String get iconLabelSleep => 'Sleep';

  @override
  String get iconLabelNutrition => 'Nutrition';

  @override
  String get iconLabelRunning => 'Running';

  @override
  String get iconLabelMusic => 'Music';

  @override
  String get iconLabelLearning => 'Learning';

  @override
  String get iconLabelFinance => 'Finance';

  @override
  String get iconLabelWellness => 'Wellness';

  @override
  String get iconLabelHealth => 'Health';

  @override
  String get iconLabelHygiene => 'Hygiene';

  @override
  String get iconLabelCoding => 'Coding';

  @override
  String get iconLabelLanguage => 'Language';

  @override
  String get iconLabelPetCare => 'Pet Care';

  @override
  String get iconLabelNature => 'Nature';

  @override
  String get iconLabelStyle => 'Style';

  @override
  String get iconLabelTravel => 'Travel';

  @override
  String get iconLabelNoSmoking => 'No Smoking';

  @override
  String get onboardingTitle => 'Build momentum, one habit at a time';

  @override
  String get onboardingSubtitle =>
      'HabitForge helps you stay consistent every day and grow streaks that matter.';

  @override
  String get onboardingPointConsistency => 'Track daily habits with one tap';

  @override
  String get onboardingPointProgress => 'See your progress on clear charts';

  @override
  String get onboardingPointFocus => 'Keep your routine simple and focused';

  @override
  String get onboardingGetStarted => 'Get started';
}

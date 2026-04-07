// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appHomeTab => 'Start';

  @override
  String get appProfileTab => 'Profil';

  @override
  String get changeThemeTooltip => 'Zmień motyw';

  @override
  String get changeLanguageTooltip => 'Zmień język';

  @override
  String get languageEnglish => 'Angielski';

  @override
  String get languagePolish => 'Polski';

  @override
  String get dailyMomentumTitle => 'Dzisiejszy impet';

  @override
  String get noHabitsYetTitle => 'Brak nawyków';

  @override
  String get noHabitsYetDescription =>
      'Zacznij od jednego małego nawyku i buduj codzienną regularność.';

  @override
  String get createFirstHabit => 'Utwórz pierwszy nawyk';

  @override
  String completionPercentLabel(int percent) {
    return '$percent% ukończono';
  }

  @override
  String get createHabitTitle => 'Utwórz nawyk';

  @override
  String get editHabitTitle => 'Edytuj nawyk';

  @override
  String get habitNameRequiredError => 'Nazwa jest wymagana';

  @override
  String get creatingHabit => 'Tworzenie...';

  @override
  String get savingHabit => 'Zapisywanie...';

  @override
  String get saveChanges => 'Zapisz zmiany';

  @override
  String get createHabit => 'Utwórz nawyk';

  @override
  String get habitNameLabel => 'Nazwa';

  @override
  String get habitNameHint => 'np. Pij wodę';

  @override
  String get habitDescriptionLabel => 'Opis';

  @override
  String get habitDescriptionHint => 'Opcjonalne notatki do tego nawyku';

  @override
  String get habitIconLabel => 'Ikona';

  @override
  String get habitActionsTooltip => 'Akcje nawyku';

  @override
  String get editAction => 'Edytuj';

  @override
  String get deleteAction => 'Usuń';

  @override
  String get completedToday => 'Ukończono dziś';

  @override
  String get tapToComplete => 'Dotknij, aby ukończyć';

  @override
  String get deleteHabitTitle => 'Usunąć nawyk?';

  @override
  String deleteHabitMessage(String habitName) {
    return 'To trwale usunie \"$habitName\" z Twojej listy.';
  }

  @override
  String get cancel => 'Anuluj';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileSubtitle =>
      'Śledź regularność, przeglądaj historię i planuj kolejną serię.';

  @override
  String get statsToday => 'Dzisiaj';

  @override
  String get statsHabitsDone => 'Nawyki ukończone';

  @override
  String get statsCompletion => 'Skuteczność';

  @override
  String get statsDailySuccess => 'Dzienny wynik';

  @override
  String get statsAllTime => 'Łącznie';

  @override
  String get statsCompletions => 'Ukończenia';

  @override
  String get statsBestStreak => 'Najlepsza seria';

  @override
  String get statsCurrentStreakMax => 'Najdłuższa bieżąca seria';

  @override
  String get lastSevenDays => 'Ostatnie 7 dni';

  @override
  String weeklyTooltip(String day, int count) {
    return '$day\n$count ukończono';
  }

  @override
  String get legendCompletedHabitsPerDay => 'Ukończone nawyki na dzień';

  @override
  String get legendTimelineLastSevenDays => 'Oś pon.-niedz. (ostatnie 7 dni)';

  @override
  String completedOnDay(String dayLabel) {
    return 'Ukończono dnia: $dayLabel';
  }

  @override
  String get noCompletedHabitsOnDay => 'Brak ukończonych nawyków tego dnia.';

  @override
  String get iconLabelGeneral => 'Ogólne';

  @override
  String get iconLabelHydration => 'Nawodnienie';

  @override
  String get iconLabelMindfulness => 'Uważność';

  @override
  String get iconLabelWorkout => 'Trening';

  @override
  String get iconLabelReading => 'Czytanie';

  @override
  String get iconLabelSleep => 'Sen';

  @override
  String get iconLabelNutrition => 'Odżywianie';

  @override
  String get iconLabelRunning => 'Bieganie';

  @override
  String get iconLabelMusic => 'Muzyka';

  @override
  String get iconLabelLearning => 'Nauka';

  @override
  String get iconLabelFinance => 'Finanse';

  @override
  String get iconLabelWellness => 'Wellbeing';

  @override
  String get iconLabelHealth => 'Zdrowie';

  @override
  String get iconLabelHygiene => 'Higiena';

  @override
  String get iconLabelCoding => 'Programowanie';

  @override
  String get iconLabelLanguage => 'Język';

  @override
  String get iconLabelPetCare => 'Opieka nad zwierzęciem';

  @override
  String get iconLabelNature => 'Natura';

  @override
  String get iconLabelStyle => 'Styl';

  @override
  String get iconLabelTravel => 'Podróże';

  @override
  String get iconLabelNoSmoking => 'Bez palenia';

  @override
  String get onboardingTitle => 'Buduj regularność, jeden nawyk na raz';

  @override
  String get onboardingSubtitle =>
      'HabitForge pomaga Ci codziennie trzymać rytm i rozwijać serie, które mają znaczenie.';

  @override
  String get onboardingPointConsistency =>
      'Śledź codzienne nawyki jednym dotknięciem';

  @override
  String get onboardingPointProgress =>
      'Sprawdzaj postępy na czytelnych wykresach';

  @override
  String get onboardingPointFocus => 'Utrzymuj prostą i skupioną rutynę';

  @override
  String get onboardingGetStarted => 'Zaczynaj';
}

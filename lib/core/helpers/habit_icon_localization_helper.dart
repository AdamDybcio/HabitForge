import 'package:habit_forge/l10n/app_localizations.dart';

/// Maps icon keys to localized labels.
String localizedHabitIconLabel({
  required String iconKey,
  required AppLocalizations l10n,
  required String fallbackLabel,
}) {
  switch (iconKey) {
    case 'task_alt':
      return l10n.iconLabelGeneral;
    case 'water_drop':
      return l10n.iconLabelHydration;
    case 'self_improvement':
      return l10n.iconLabelMindfulness;
    case 'fitness_center':
      return l10n.iconLabelWorkout;
    case 'book':
      return l10n.iconLabelReading;
    case 'bedtime':
      return l10n.iconLabelSleep;
    case 'restaurant':
      return l10n.iconLabelNutrition;
    case 'directions_run':
      return l10n.iconLabelRunning;
    case 'music_note':
      return l10n.iconLabelMusic;
    case 'school':
      return l10n.iconLabelLearning;
    case 'savings':
      return l10n.iconLabelFinance;
    case 'spa':
      return l10n.iconLabelWellness;
    case 'medication':
      return l10n.iconLabelHealth;
    case 'brush':
      return l10n.iconLabelHygiene;
    case 'code':
      return l10n.iconLabelCoding;
    case 'language':
      return l10n.iconLabelLanguage;
    case 'pets':
      return l10n.iconLabelPetCare;
    case 'local_florist':
      return l10n.iconLabelNature;
    case 'checkroom':
      return l10n.iconLabelStyle;
    case 'flight_takeoff':
      return l10n.iconLabelTravel;
    case 'smoke_free':
      return l10n.iconLabelNoSmoking;
    default:
      return fallbackLabel;
  }
}

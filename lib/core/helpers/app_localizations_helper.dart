import 'package:flutter/widgets.dart';
import 'package:habit_forge/l10n/app_localizations.dart';
import 'package:habit_forge/l10n/app_localizations_en.dart';

/// Returns app localizations or a safe English fallback.
AppLocalizations appL10n(BuildContext context) {
  return AppLocalizations.of(context) ?? AppLocalizationsEn();
}

import 'package:intl/intl.dart';

const _daysInWeek = 7;
const _referenceYear = 2026;
const _referenceMonth = 1;
const _referenceMondayDay = 5;

/// Builds localized short week labels starting from Monday.
List<String> buildWeekdayShortLabels(String localeTag) {
  return List<String>.generate(_daysInWeek, (index) {
    final day = DateTime(
      _referenceYear,
      _referenceMonth,
      _referenceMondayDay + index,
    );

    return DateFormat('EEE', localeTag).format(day);
  });
}

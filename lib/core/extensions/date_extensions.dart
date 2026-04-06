// ignore_for_file: prefer_match_file_name
/// Extension for comparing only the date part of DateTime objects.
extension DateOnlyCompare on DateTime {
  /// Checks if this DateTime is on the same calendar day as another DateTime.
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

import 'package:intl/intl.dart';

class DateUtilsForThirtyDays {
  /// Gets the current date
  static DateTime get now => DateTime.now();

  /// Formats a date as 'EEE d' (e.g., 'Mon 28')
  static String formatDayMonth(DateTime date) {
    return DateFormat('EEE d').format(date);
  }

  /// Gets the next [daysCount] days starting from [startDate]
  /// If [startDate] is not provided, uses current date
  static List<DateTime> getNextDays({int daysCount = 30, DateTime? startDate}) {
    final start = startDate ?? now;
    return List.generate(daysCount, (index) => start.add(Duration(days: index)));
  }

  /// Gets formatted next days as strings (e.g., ['Mon 28', 'Tue 29', ...])
  static List<String> getFormattedNextDays({int daysCount = 30, DateTime? startDate}) {
    return getNextDays(daysCount: daysCount, startDate: startDate)
        .map(formatDayMonth)
        .toList();
  }

  /// Checks if two dates are the same day (ignores time)
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Formats time as 'h:mma' (e.g., '8:30am')
  static String formatTime(DateTime time) {
    return DateFormat('h:mma').format(time).toLowerCase();
  }

  /// Formats time range (e.g., '8:30am - 9:15am')
  static String formatTimeRange(DateTime start, DateTime end) {
    return '${formatTime(start)} - ${formatTime(end)}';
  }
}
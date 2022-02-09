import 'package:intl/intl.dart';

class CalendarUtils {
  static bool isTheSameDay(DateTime dateL, DateTime dateR) =>
      dateL.year == dateR.year &&
      dateL.month == dateR.month &&
      dateL.day == dateR.day;

  static String getFormattedMonth(DateTime date) =>
      DateFormat('MMMM yyyy').format(date);

  static String getFormattedDate(DateTime date) => DateFormat('d').format(date);

  static int getDaysCount(DateTime date) =>
      DateTime(date.year, date.month + 1, date.day).difference(date).inDays;

  static bool isIncludedInPeriod(DateTime date,
          {required DateTime start, required DateTime end}) =>
      date.isAfter(start) && date.isBefore(end);
}

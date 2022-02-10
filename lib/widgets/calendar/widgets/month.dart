import 'package:flutter/material.dart';
import '../index.dart';
import '../utils.dart';
import './day_cell.dart';
import '../styles.dart';

class Month extends StatelessWidget {
  final DateTime date;
  final CalendarMode mode;
  final List<DateTime> availableDates;
  final List<DateTime> unavailableDates;
  final Function(DateTime) onChange;
  final DateTime? activeDateStart;
  final DateTime? activeDateEnd;
  final bool isReverse;

  const Month(
      {Key? key,
      required this.date,
      required this.onChange,
      required this.mode,
      this.isReverse = false,
      this.activeDateStart,
      this.activeDateEnd,
      this.availableDates = const [],
      this.unavailableDates = const []})
      : super(key: key);

  Widget _getEmptyCell(int index) {
    return const FractionallySizedBox(widthFactor: 1 / DateTime.daysPerWeek);
  }

  bool _checkIsActive(DateTime _date) {
    return activeDateStart != null &&
            CalendarUtils.isTheSameDay(_date, activeDateStart!) ||
        activeDateEnd != null &&
            CalendarUtils.isTheSameDay(_date, activeDateEnd!);
  }

  bool _checkInPeriod(DateTime _date) {
    return activeDateStart != null &&
        activeDateEnd != null &&
        CalendarUtils.isIncludedInPeriod(_date,
            start: activeDateStart!, end: activeDateEnd!);
  }

  Widget _getDayCell(int index) {
    DateTime _date = DateTime(date.year, date.month, index + 1);

    return DayCell(
      onChange: onChange,
      isPeriod: mode == CalendarMode.period,
      isActive: _checkIsActive(_date),
      isInPeriod: _checkInPeriod(_date),
      isReverse: isReverse,
      date: _date,
      availableDates: availableDates,
      unavailableDates: unavailableDates,
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime _dateBegin = DateTime(date.year, date.month, 1);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Center(
              child: Text(CalendarUtils.getFormattedMonth(date),
                  style: MonthStyles.textStyle)),
          const SizedBox(height: 8),
          Stack(
            children: [
              Wrap(children: [
                ...List.generate(_dateBegin.weekday - 1, _getEmptyCell),
                ...List.generate(CalendarUtils.getDaysCount(date), _getDayCell)
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

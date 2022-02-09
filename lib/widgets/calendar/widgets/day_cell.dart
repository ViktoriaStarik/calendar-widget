import 'package:flutter/material.dart';
import '../colors.dart';
import '../utils.dart';
import '../styles.dart';

enum DayType { active, available, unavailable, base }

class DayCell extends StatelessWidget {
  final DateTime date;
  final bool isPeriod;
  final bool isInPeriod;
  final List<DateTime> availableDates;
  final List<DateTime> unavailableDates;
  final Function(DateTime) onChange;
  final bool isActive;

  DayCell(
      {Key? key,
      required this.date,
      required this.onChange,
      this.isPeriod = false,
      this.isInPeriod = false,
      this.isActive = false,
      this.availableDates = const [],
      this.unavailableDates = const []})
      : super(key: key);

  final Map<DayType, Color> _colorsBackground = {
    DayType.active: WidgetColors.accentColor,
    DayType.unavailable: WidgetColors.disableColor,
    DayType.available: Colors.white,
    DayType.base: Colors.transparent,
  };

  final Map<DayType, Color> _colorsText = {
    DayType.active: Colors.white,
    DayType.unavailable: WidgetColors.disableTextColor,
    DayType.available: WidgetColors.accentColor,
    DayType.base: WidgetColors.accentColor,
  };

  _checkIsAvailable() {
    return availableDates
        .any((element) => CalendarUtils.isTheSameDay(element, date));
  }

  _checkIsUnavailable() {
    return unavailableDates
        .any((element) => CalendarUtils.isTheSameDay(element, date));
  }

  _checkIsToday() {
    return CalendarUtils.isTheSameDay(DateTime.now(), date);
  }

  _checkIsBefore() {
    return date.isBefore(DateTime.now()) && !_checkIsToday();
  }

  _checkIsFirst() {
    return date.weekday == 1 || date.day == 1;
  }

  _checkIsLast() {
    return date.weekday == DateTime.daysPerWeek ||
        date.day == CalendarUtils.getDaysCount(date);
  }

  @override
  Widget build(BuildContext context) {
    bool isAvailable = !isPeriod && _checkIsAvailable();
    bool isUnavailable = !isPeriod && _checkIsUnavailable();

    bool isToday = _checkIsToday();
    bool isBefore = _checkIsBefore();

    DayType type = DayType.base;

    if (isAvailable) {
      type = DayType.available;
    }
    if (isUnavailable) {
      type = DayType.unavailable;
    }
    if (isActive) {
      type = DayType.active;
    }

    bool isFirst = _checkIsFirst();
    bool isLast = _checkIsLast();

    return FractionallySizedBox(
      widthFactor: 1 / DateTime.daysPerWeek,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (isInPeriod)
              Positioned(
                  top: 2,
                  left: isFirst ? -4 : -8,
                  right: isLast ? -4 : -8,
                  bottom: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: WidgetColors.disableColor,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(isFirst ? 8 : 0),
                            right: Radius.circular(isLast ? 8 : 0))),
                  )),
            GestureDetector(
              onTap: () => !isUnavailable ? onChange(date) : null,
              child: Container(
                  height: 32,
                  decoration: DayStyles.getContainerDecoration(
                      _colorsBackground[type], isToday),
                  alignment: Alignment.center,
                  child: Text(CalendarUtils.getFormattedDate(date),
                      style: DayStyles.getTextStyle(
                          isBefore
                              ? WidgetColors.disableTextColor
                              : _colorsText[type],
                          isAvailable))),
            ),
          ],
        ),
      ),
    );
  }
}

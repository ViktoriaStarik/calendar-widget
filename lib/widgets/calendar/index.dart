import 'package:flutter/material.dart';
import './widgets/month.dart';
import './colors.dart';

enum CalendarMode { period, single }

class Calendar extends StatefulWidget {
  final DateTime initialDate;
  final CalendarMode mode;
  final List<DateTime> availableDates;
  final List<DateTime> unavailableDates;
  final Function(DateTime)? onChange;
  final Function(DateTime, DateTime)? onChangePeriod;

  Calendar(
      {Key? key,
      DateTime? initialDate,
      this.onChange,
      this.onChangePeriod,
      this.mode = CalendarMode.single,
      this.availableDates = const [],
      this.unavailableDates = const []})
      : initialDate = initialDate ?? DateTime.now(),
        super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  static const _monthCount = 6;

  DateTime? activeDateStart;
  DateTime? activeDateEnd;

  _updateDates(DateTime date) {
    DateTime? dateStart = date;
    DateTime? dateEnd;

    if (widget.mode == CalendarMode.period) {
      if (activeDateStart == null) {
        dateEnd = activeDateEnd;
      } else if (activeDateEnd != null) {
        dateEnd = null;
      } else if (activeDateStart!.isAfter(date)) {
        dateEnd = activeDateStart;
      } else {
        dateStart = activeDateStart;
        dateEnd = date;
      }
    }

    setState(() {
      activeDateStart = dateStart;
      activeDateEnd = dateEnd;
    });
  }

  _onChange(DateTime date) {
    _updateDates(date);

    if (widget.mode == CalendarMode.period &&
        activeDateStart != null &&
        activeDateEnd != null) {
      widget.onChangePeriod?.call(activeDateStart!, activeDateEnd!);
    } else {
      widget.onChange?.call(date);
    }
  }

  Widget _getMonth(int index) {
    DateTime date = DateTime(widget.initialDate.year,
        widget.initialDate.month + index, widget.initialDate.day);

    return Month(
        mode: widget.mode,
        availableDates: widget.availableDates,
        unavailableDates: widget.unavailableDates,
        activeDateStart: activeDateStart,
        activeDateEnd: activeDateEnd,
        onChange: _onChange,
        date: date);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: WidgetColors.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...List.generate(_monthCount, _getMonth),
          ],
        ),
      ),
    );
  }
}

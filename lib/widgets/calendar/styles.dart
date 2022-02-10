import 'package:flutter/material.dart';
import './colors.dart';

class MonthStyles {
  static TextStyle textStyle =
      const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, height: 1.43);
}

class DayStyles {
  static TextStyle getTextStyle(Color? color, bool isAvailable) => TextStyle(
      color: color,
      fontSize: 14,
      height: 1.43,
      fontWeight: isAvailable ? FontWeight.w600 : FontWeight.w400);

  static BoxDecoration getContainerDecoration(Color? color, bool isToday) =>
      BoxDecoration(
          border: isToday
              ? Border.all(color: WidgetColors.accentColor, width: 2)
              : null,
          borderRadius: BorderRadius.circular(8),
          color: color);
}

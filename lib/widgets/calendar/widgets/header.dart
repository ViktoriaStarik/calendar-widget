import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../styles.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime beginOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      color: Colors.white,
      child: Wrap(
        children: List.generate(
            DateTime.daysPerWeek,
            (index) => FractionallySizedBox(
                  widthFactor: 1 / DateTime.daysPerWeek,
                  child: Center(
                    child: Text(
                        DateFormat('E')
                            .format(beginOfWeek.add(Duration(days: index))),
                        style: Styles.dayOfWeekTextStyle),
                  ),
                )),
      ),
    );
  }
}

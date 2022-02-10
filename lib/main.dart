import 'package:calendarwidget/widgets/calendar/index.dart';
import 'package:calendarwidget/widgets/header/index.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Демо календаря'),
      ),
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: Calendar(
              onChange: (date) => print('Calendar date: $date'),
              onChangePeriod: (date1, date2) =>
                  print('Calendar period: $date1 - $date2'),
              initialDate: DateTime.now(),
              mode: CalendarMode.period,
              availableDates: [DateTime.parse('2022-02-22 22:00:00')],
              unavailableDates: [DateTime.parse('2022-02-20 22:00:00')],
            ),
          )
        ],
      ),
    );
  }
}

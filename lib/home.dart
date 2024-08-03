import 'package:alarm_sample/alarm_list_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Alarm',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AlarmListPage(),
    );
  }
}

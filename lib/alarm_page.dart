import 'package:alarm_sample/main.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

void alarmCallback() {
  _showNotification();
}

Future<void> _showNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('your', 'your channel name',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'Alarm', 'Time to wake up!', platformChannelSpecifics,
      payload: 'item x');
}

Future<void> saveAlarmTime(TimeOfDay time) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('alarm_hour', time.hour);
  await prefs.setInt('alarm_minute', time.minute);
}

Future<TimeOfDay> getAlarmTime() async {
  final prefs = await SharedPreferences.getInstance();
  final int hour = prefs.getInt('alarm_hour') ?? 0;
  final int minute = prefs.getInt('alarm_minute') ?? 0;
  return TimeOfDay(hour: hour, minute: minute);
}

Future<void> setAlarm(DateTime dateTime) async {
  await AndroidAlarmManager.oneShotAt(
    dateTime,
    0, // 알람 ID
    alarmCallback,
    exact: true,
    wakeup: true,
  );
}

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != selectedTime) {
      setState(() {
        selectedTime = picked!;
      });
    }
  }

  void _setAlarm() async {
    final now = DateTime.now();
    final alarmTime = DateTime(
        now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
    await saveAlarmTime(selectedTime);
    await setAlarm(alarmTime);
    debugPrint(alarmTime.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Alarm'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Selected time: ${selectedTime.format(context)}",
            ),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: const Text('Select time'),
            ),
            ElevatedButton(
              onPressed: _setAlarm,
              child: const Text('Set Alarm'),
            ),
          ],
        ),
      ),
    );
  }
}

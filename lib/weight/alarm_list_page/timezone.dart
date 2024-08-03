import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

Container TimeZone(double maxWidth) {
  return Container(
    alignment: Alignment.center,
    width: maxWidth,
    height: 100,
    decoration: const BoxDecoration(color: Colors.green),
    child: TimerBuilder.periodic(
      const Duration(seconds: 1),
      builder: (context) {
        return Text(
          formatDate(DateTime.now(), [am, " ", hh, "시", dd, "분", ss, "초"]),
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        );
      },
    ),
  );
}

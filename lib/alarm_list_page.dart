import 'package:alarm_sample/alarm_page.dart';
import 'package:alarm_sample/weight/alarm_list_page/timezone.dart';
import 'package:alarm_sample/weight/public/display_size.dart';
import 'package:flutter/material.dart';

class AlarmListPage extends StatefulWidget {
  const AlarmListPage({super.key});

  @override
  State<AlarmListPage> createState() => _AlarmListPageState();
}

class _AlarmListPageState extends State<AlarmListPage> {
  bool onChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 50,
        title: const Text('WakeTime'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const AlarmPage())),
            icon: const Icon(
              Icons.add,
              color: Colors.black,
              size: 30,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          //time zone
          TimeZone(DisplaySize(context).maxWidth),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(index),
                  child: alarmItem(ap: "오전", time: "00:00"),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  SwitchListTile alarmItem({required ap, required time, title}) {
    return SwitchListTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(ap),
          const SizedBox(width: 5),
          Text(time, style: const TextStyle(fontSize: 30)),
        ],
      ),
      subtitle: Text(title ?? "알람"),
      value: onChecked,
      onChanged: (value) {
        setState(() {
          onChecked = value;
        });
      },
    );
  }
}

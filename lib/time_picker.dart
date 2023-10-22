import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_showtimepicker/TimeSpinnerPicker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Time Picker Spinner Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  Rx<DateTime> _dateTime = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Time Picker Spinner Demo'),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              hourMinute12HCustomStyle(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 50),
                child: Text(
                  _dateTime.value.hour.toString().padLeft(2, '0') +
                      ':' +
                      _dateTime.value.minute.toString().padLeft(2, '0') +
                      ':' +
                      _dateTime.value.second.toString().padLeft(2, '0'),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }

  Widget hourMinute12HCustomStyle() {
    return Obx(() {
      return TimePickerSpinner(
        time: _dateTime.value,
          is24HourMode: false,
          normalTextStyle: const TextStyle(fontSize: 24, color: Colors.black),
          highlightedTextStyle:
          const TextStyle(fontSize: 24, color: Colors.purple),
          spacing: 20,
          itemHeight: 45,
          isForce2Digits: true,
          minutesInterval: 1,
          onTimeChange: (time) {
            onTimeChangeCallBack(time);
          });
    });
  }

  void onTimeChangeCallBack(DateTime time) {
    DateTime now = DateTime.now();
    if (time.isBefore(now)) {
      _dateTime.value = DateTime.now();
    } else {
      _dateTime.value = time;
    }
    ;
  }
}

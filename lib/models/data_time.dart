import 'package:flutter/material.dart';

class ChooseTime {
  final String time;
  final bool status;
  final TimeOfDay datetime;

  ChooseTime({this.time, this.status, this.datetime});

  final startTime = TimeOfDay(hour: 8, minute: 0);
  final endTime = TimeOfDay(hour: 17, minute: 0);
  final step = Duration(minutes: 30);

  Future<List<ChooseTime>> create() async {
    List<ChooseTime> list = [];
    var times = await getTimes(startTime, endTime, step).toList();
    for (var v in times) {
      list.add(new ChooseTime(
          time: "${v.hour}:${v.minute}", status: false, datetime: v));
    }
    return list;
  }
}

Iterable<TimeOfDay> getTimes(
    TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
  var hour = startTime.hour;
  var minute = startTime.minute;

  do {
    yield TimeOfDay(hour: hour, minute: minute);
    minute += step.inMinutes;
    while (minute >= 60) {
      minute -= 60;
      hour++;
    }
  } while (hour < endTime.hour ||
      (hour == endTime.hour && minute <= endTime.minute));
}

List<ChooseTime> chooseTimeList = [
  ChooseTime(time: "08:00", status: false),
  ChooseTime(time: "08:30", status: true),
  ChooseTime(time: "09:00", status: false),
  ChooseTime(time: "09:30", status: false),
  ChooseTime(time: "10:00", status: false),
  ChooseTime(time: "10:30", status: true),
  ChooseTime(time: "11:00", status: true),
  ChooseTime(time: "11:30", status: false),
  ChooseTime(time: "12:00", status: false),
  ChooseTime(time: "12:30", status: false),
  ChooseTime(time: "13:00", status: false),
  ChooseTime(time: "13:30", status: true),
  ChooseTime(time: "14:00", status: true),
  ChooseTime(time: "14:30", status: false),
  ChooseTime(time: "15:00", status: false),
  ChooseTime(time: "15:30", status: false),
  ChooseTime(time: "16:00", status: true),
  ChooseTime(time: "16:30", status: false),
  ChooseTime(time: "17:00", status: true),
];

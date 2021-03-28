import 'package:flutter/material.dart';

class ChooseTime {
  String time;
  bool status;
  TimeOfDay datetime;

  ChooseTime({this.time, this.status, this.datetime});

  final startTime = TimeOfDay(hour: 8, minute: 0);
  final endTime = TimeOfDay(hour: 16, minute: 30);
  final step = Duration(minutes: 30);

  List<ChooseTime> create() {
    List<ChooseTime> list = [];
    var times = getTimes(startTime, endTime, step).toList();

    for (var v in times) {
      list.add(new ChooseTime(
          time: "${v.hour}:${v.minute}", status: true, datetime: v));
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

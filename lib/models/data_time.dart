class ChooseTime {
  final String time;
  final bool status;

  ChooseTime({this.time, this.status});
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

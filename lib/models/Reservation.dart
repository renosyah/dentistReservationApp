class Reservation {
  String userId;
  String name;
  DateTime time;
  int queueNumber;

  Reservation({this.userId, this.name, this.time, this.queueNumber});

  Reservation.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    time = json['time'].toDate();
    queueNumber = json['queue_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['time'] = this.time;
    data['queue_number'] = this.queueNumber;
    return data;
  }
}
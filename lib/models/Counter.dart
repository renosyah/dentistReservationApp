class Counter {
  int counterId;
  DateTime time;

  Counter({this.counterId, this.time});

  Counter.fromJson(Map<String, dynamic> json) {
    counterId = json['counter_id'];
    time = json['time'].toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counter_id'] = this.counterId;
    data['time'] = this.time;
    return data;
  }
}
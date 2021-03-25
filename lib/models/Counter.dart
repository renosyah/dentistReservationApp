class Counter {
  int counterId;
  Counter({this.counterId});

  Counter.fromJson(Map<String, dynamic> json) {
    counterId = json['counter_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counter_id'] = this.counterId;
    return data;
  }
}
class QuestionAndAnswer {
  String userId;
  String question;
  String answer;
  DateTime time;

  QuestionAndAnswer({this.userId, this.question, this.answer,this.time });

  QuestionAndAnswer.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    question = json['question'];
    answer = json['answer'];
    time = json['time'].toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['time'] = this.time;
    return data;
  }
}
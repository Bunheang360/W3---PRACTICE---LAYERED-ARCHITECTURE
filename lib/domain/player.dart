import './quiz.dart';

class Player {
  String name;
  List<Answer> answers = [];

  Player({required this.name, List<Answer>? answers}) {
    if (answers != null) {
      this.answers = answers;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'answers': this.answers.map((a) => a.toJson()).toList(),
    };
  }

  factory Player.fromJson(Map<String, dynamic> json, Quiz quiz) {
    var answersJson = json['answers'] as List? ?? [];
    var answers = answersJson.map((a) => Answer.fromJson(a, quiz)).toList();

    return Player(
      name: json['name'],
      answers: answers,
    );
  }
}

import './player.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Question {
  final String title;
  final List<String> choices;
  final String goodChoice;
  int points;
  String id;

  Question({
    String? id,
    required this.title,
    required this.choices,
    required this.goodChoice,
    this.points = 1,
  }) : id = id ?? uuid.v4(); //AI Help

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'choices': choices,
      'goodChoice': goodChoice,
      'points': points,
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'],
      choices: List<String>.from(json['choices']),
      goodChoice: json['goodChoice'],
      points: json['points'] ?? 1,
    );
  }
}

class Answer {
  Question question;
  String answerChoice;
  String id;

  Answer({
    String? id,
    required this.question,
    required this.answerChoice,
  }) : id = id ?? uuid.v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionId': question.id,
      'answerChoice': answerChoice,
    };
  }

  factory Answer.fromJson(Map<String, dynamic> json, Quiz quiz) {
    Question? question = quiz.getQuestionById(json['questionId']);
    if (question == null) {
      throw Exception('Question not found');
    }
    return Answer(
      id: json['id'],
      question: question,
      answerChoice: json['answerChoice'],
    );
  }

  bool isGood() {
    return this.answerChoice == question.goodChoice;
  }
}

class Quiz {
  List<Question> questions;
  List<Player> players = [];
  final String id;

  Quiz({
    String? id,
    required this.questions,
    List<Player>? players,
  }) : id = id ?? uuid.v4() {
    if (players != null) {
      this.players = players;
    }
  }

  Question? getQuestionById(String questionId) {
    try {
      return questions.firstWhere((q) => q.id == questionId);
    } catch (e) {
      return null;
    }
  }

  Answer? getAnswerById(String answerId) {
    for (var player in players) {
      try {
        return player.answers.firstWhere((a) => a.id == answerId);
      } catch (e) {
        continue;
      }
    }
    return null;
  }

  Player getOrCreatePlayer(String name) {
    for (var player in players) {
      if (player.name == name) {
        player.answers.clear();
        return player;
      }
    }

    Player newPlayer = Player(name: name);
    players.add(newPlayer);
    return newPlayer;
  }

  int getScoreInPercentage(Player player) {
    int totalScore = 0;
    for (Answer answer in player.answers) {
      Question? question = getQuestionById(answer.question.id);
      if (question != null && answer.answerChoice == question.goodChoice) {
        totalScore++;
      }
    }
    return ((totalScore / questions.length) * 100).toInt();
  }

  int getScoreInPoints(Player player) {
    int totalPoints = 0;
    for (var answer in player.answers) {
      Question? question = getQuestionById(answer.question.id);
      if (question != null && answer.answerChoice == question.goodChoice) {
        totalPoints += question.points;
      }
    }
    return totalPoints;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questions': questions.map((q) => q.toJson()).toList(),
      'players': players.map((p) => p.toJson()).toList(),
    };
  }

  factory Quiz.fromJson(Map<String, dynamic> json) {
    var questionsJson = json['questions'] as List;
    var questions = questionsJson.map((q) => Question.fromJson(q)).toList();

    var quiz = Quiz(
      id: json['id'],
      questions: questions,
    );

    if (json['players'] != null) {
      var playersJson = json['players'] as List;
      quiz.players = playersJson.map((p) => Player.fromJson(p, quiz)).toList();
    }

    return quiz;
  }

}

import 'dart:math';

import 'package:first_flutter/Week-3/domain/player.dart';
import 'package:test/test.dart';
import 'package:first_flutter/Week-3/domain/quiz.dart';

void main() {
  test(' Score 100% - Both answer is correct! Congrat!!', () {
    List<Question> questions = [
      Question(
        title: "Capital of France?",
        choices: ["Paris", "London", "Rome"],
        goodChoice: "Paris",
        points:10,
      ),
      Question(
        title: "2 + 2 = ?",
        choices: ["2", "4", "5"],
        goodChoice: "4",
        points: 50,
      ),
    ];

    Quiz quiz = Quiz(questions: questions);
    Player player1 = quiz.getOrCreatePlayer('Test Player1');

    player1.answers.add(Answer(question: questions[0], answerChoice: "Paris"));
    player1.answers.add(Answer(question: questions[1], answerChoice: "4"));

    expect(quiz.getScoreInPercentage(player1), equals(100));
    expect(quiz.getScoreInPoints(player1), equals(60));
  });

  test(' Score 50% - Your answer is one correct and one wrong! ', () {
    List<Question> questions = [
      Question(
        title: "Capital of France?",
        choices: ["Paris", "London", "Rome"],
        goodChoice: "Paris",
        points:10,
      ),
      Question(
        title: "2 + 2 = ?",
        choices: ["2", "4", "5"],
        goodChoice: "4",
        points: 50,
      ),
    ];

    Quiz quiz = Quiz(questions: questions);
    Player player2 = quiz.getOrCreatePlayer('Test Player2');

    player2.answers.add(Answer(question: questions[0], answerChoice: "Paris"));
    player2.answers.add(Answer(question: questions[1], answerChoice: "5"));

    expect(quiz.getScoreInPercentage(player2), equals(50));
    expect(quiz.getScoreInPoints(player2), equals(10));
  });

  test(' Score 0% - Your answer is all wrong! Study Harder! ', () {
    List<Question> questions = [
      Question(
        title: "Capital of France?",
        choices: ["Paris", "London", "Rome"],
        goodChoice: "Paris",
        points:10,
      ),
      Question(
        title: "2 + 2 = ?",
        choices: ["2", "4", "5"],
        goodChoice: "4",
        points: 50,
      ),
    ];

    Quiz quiz = Quiz(questions: questions);
    Player player3 = quiz.getOrCreatePlayer('Test Player3');

    player3.answers.add(Answer(question: questions[0], answerChoice: "London"));
    player3.answers.add(Answer(question: questions[1], answerChoice: "5"));

    expect(quiz.getScoreInPercentage(player3), equals(0));
    expect(quiz.getScoreInPoints(player3), equals(0));
  });

}

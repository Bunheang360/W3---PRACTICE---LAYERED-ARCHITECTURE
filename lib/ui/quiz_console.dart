import 'dart:io';

import '../domain/player.dart';
import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    while (true) {
      print('--- Welcome to the Quiz ---\n');
      stdout.write('Enter your name (or press Enter to quit): ');
      String? playerName = stdin.readLineSync();

      if (playerName == null || playerName.isEmpty) {
        print('Goodbye!');
        break;
      }

      startQuizForPlayer(playerName);
      print('\n--- Press Enter to continue with next player ---');
      stdin.readLineSync();
      clearConsole();
    }
  }

  void clearConsole() {
    print('\n' * 50);
  }

  void startQuizForPlayer(String playerName) {
    Player player = quiz.getOrCreatePlayer(playerName);

    // print('\nHello, $playerName! Let\'s start the quiz.\n');

    for (var question in quiz.questions) {
      print('Question: ${question.title} (${question.points} points)');
      print('Choices: ${question.choices}');
      stdout.write('Your answer: ');
      String? userInput = stdin.readLineSync();

      if (userInput != null && userInput.isNotEmpty) {
        Answer answer = Answer(question: question, answerChoice: userInput);
        player.answers.add(answer);
      } else {
        print('No answer entered. Skipping question.');
      }

      print('');
    }

    displayScores(player);
  }

  void displayScores(Player currentPlayer) {
    int scorePercentage = quiz.getScoreInPercentage(currentPlayer);
    int scorePoints = quiz.getScoreInPoints(currentPlayer);

    print('--- Quiz Finished ---');
    print('Your score in percentage: $scorePercentage %');
    print('Your score in points: $scorePoints\n');

    if (quiz.players.isNotEmpty) {
      print('--- Previous Players Scores ---');
      for (var player in quiz.players) {
        int playerPercentage = quiz.getScoreInPercentage(player);
        int playerPoints = quiz.getScoreInPoints(player);
        print('${player.name}: $playerPercentage% ($playerPoints points)');
      }
    }
  }
}

import 'dart:io';
import 'dart:convert';
import '../domain/quiz.dart';

class QuizRepository {
  final String filePath;

  QuizRepository(this.filePath);

  // Read Quiz from JSON
  Quiz readQuiz() {
    final file = File(filePath);
    final content = file.readAsStringSync();
    final data = jsonDecode(content);

    return Quiz.fromJson(data);
  }

  // Write Quiz to JSON 
  void writeQuiz(Quiz quiz) {
    final file = File(filePath);
    final jsonData = quiz.toJson();
    final jsonString = JsonEncoder.withIndent('  ').convert(jsonData);
    file.writeAsStringSync(jsonString);
  }

}

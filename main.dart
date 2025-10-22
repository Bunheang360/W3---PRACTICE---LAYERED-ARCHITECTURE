import './data/quiz_file_provider.dart';
import 'domain/quiz.dart';
import 'ui/quiz_console.dart';

void main() {
  //Create quiz manually
  // List<Question> questions = [
  //   Question(
  //     title: "Capital of France?",
  //     choices: ["Paris", "London", "Rome"],
  //     goodChoice: "Paris",
  //     points: 10,
  //   ),
  //   Question(
  //     title: "2 + 2 = ?",
  //     choices: ["2", "4", "5"],
  //     goodChoice: "4",
  //     points: 50,
  //   ),
  // ];
  // Quiz quiz = Quiz(questions: questions);

  //Load quiz from JSON
  QuizRepository repository = QuizRepository('Assets/quiz.json');
  Quiz quiz = repository.readQuiz();

  QuizConsole console = QuizConsole(quiz: quiz);
  console.startQuiz();

  // Save quiz and player score
  repository.writeQuiz(quiz);
  print('\nQuiz data saved to file!');
}


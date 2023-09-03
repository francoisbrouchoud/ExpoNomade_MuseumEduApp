import 'package:expo_nomade_mobile/util/base_business_object.dart';
import 'package:expo_nomade_mobile/util/multilingual_string.dart';

/// Class contain all questions
class Quiz {
  final List<QuizQuestion> questions;

  Quiz({required this.questions});

  /// Convert a json into the buisness object quiz class
  factory Quiz.fromJson(dynamic json) {
    var quizQuestionJson = json['questions'] as List;
    List<QuizQuestion> questions = quizQuestionJson
        .map((questionJson) => QuizQuestion.fromJson(questionJson))
        .toList();
    return Quiz(questions: questions);
  }
}

/// Contain the question text in différente language and a list of option
class QuizQuestion extends BaseBusinessObject {
  MultilingualString question;
  final List<QuizOption> options;

  QuizQuestion({required this.question, required this.options});

  /// Convert a json into the buisness object quizQuestion class
  factory QuizQuestion.fromJson(questionJson) {
    var quizQuestionJson = questionJson['options'] as List;
    List<QuizOption> options = quizQuestionJson
        .map((questionJson) => QuizOption.fromJson(questionJson))
        .toList();
    MultilingualString question =
        MultilingualString(Map<String, String>.from(questionJson['question']));
    return QuizQuestion(question: question, options: options);
  }

  @override
  String toListText(String langCode) {
    return question[langCode];
  }
}

/// Contain the option text in différente language and if it is the right answer
class QuizOption {
  final Map<String, String> label;
  final bool isCorrect;

  QuizOption({required this.label, this.isCorrect = false});

  /// Convert a json into the buisness object quizOption class
  factory QuizOption.fromJson(quizOptionJson) {
    Map<String, String> label =
        Map<String, String>.from(quizOptionJson['optionText']);
    return QuizOption(
        label: label, isCorrect: quizOptionJson['isCorrect'] == 1);
  }
}

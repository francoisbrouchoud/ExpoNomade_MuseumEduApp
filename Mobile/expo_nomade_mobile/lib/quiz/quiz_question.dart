class QuizQuestion {
  final String question;
  final List<QuizOption> options;

  QuizQuestion({required this.question, required this.options});
}

class QuizOption {
  final String label;
  final bool isCorrect;

  QuizOption({required this.label, this.isCorrect = false});
}
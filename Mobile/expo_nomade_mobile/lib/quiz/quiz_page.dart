import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../app_localization.dart';
import 'score_page.dart';
import '../bo/quiz_question.dart';

class QuizPage extends StatefulWidget {
  final List<QuizQuestion> questions;

  QuizPage({required this.questions});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<int?> selectedOptionIdx = [];
  List<bool> answeredCorrectly = [];
  int currentQuestionIdx = 0;

  @override
  void initState() {
    super.initState();
    selectedOptionIdx = List.filled(widget.questions.length, null);
    answeredCorrectly = List.filled(widget.questions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final langCode = translations.getCurrentLangCode();
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        children: [
          Text(widget.questions[currentQuestionIdx].question[langCode] ?? ""),
          ...List.generate(
            widget.questions[currentQuestionIdx].options.length,
            (index) => ListTile(
              title: Text(widget.questions[currentQuestionIdx].options[index]
                      .label[langCode] ??
                  ""),
              leading: Radio(
                value: index,
                groupValue: selectedOptionIdx[currentQuestionIdx],
                onChanged: (int? value) {
                  setState(() {
                    selectedOptionIdx[currentQuestionIdx] = value;
                    answeredCorrectly[currentQuestionIdx] = widget
                        .questions[currentQuestionIdx]
                        .options[value!]
                        .isCorrect;
                  });
                },
              ),
            ),
          ),
          if (currentQuestionIdx == widget.questions.length - 1)
            ElevatedButton(
              onPressed: () {
                int correctAnswers =
                    answeredCorrectly.where((correct) => correct).length;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ScorePage(
                        correctAnswers: correctAnswers,
                        totalQuestions: widget.questions.length),
                  ),
                );
              },
              child: Text('Terminer'),
            )
          else
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentQuestionIdx++;
                });
              },
              child: Text('Suivant'),
            ),
        ],
      ),
    );
  }
}

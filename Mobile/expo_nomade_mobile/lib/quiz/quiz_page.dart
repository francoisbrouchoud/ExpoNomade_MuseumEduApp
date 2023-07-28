import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'quiz_question';

class QuizPage extends StatefulWidget {
  final List<QuizQuestion> questions;

  QuizPage({required this.questions});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIdx = 0;
  List<int?> selectedOptionIdx = [];
  List<bool> answeredCorrectly = [];

  @override
  void initState() {
    super.initState();
    selectedOptionIdx = List.filled(widget.questions.length, null);
    answeredCorrectly = List.filled(widget.questions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        children: [
          Text(widget.questions[currentQuestionIdx].question),
          ...List.generate(
            widget.questions[currentQuestionIdx].options.length,
            (index) => ListTile(
              title: Text(widget.questions[currentQuestionIdx].options[index]),
              leading: Radio(
                value: index,
                groupValue: selectedOptionIdx[currentQuestionIdx],
                onChanged: (int? value) {
                  setState(() {
                    selectedOptionIdx[currentQuestionIdx] = value;
                    answeredCorrectly[currentQuestionIdx] = (value == widget.questions[currentQuestionIdx].answerIdx);
                  });
                },
              ),
            ),
          ),
          if (currentQuestionIdx == widget.questions.length - 1)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
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

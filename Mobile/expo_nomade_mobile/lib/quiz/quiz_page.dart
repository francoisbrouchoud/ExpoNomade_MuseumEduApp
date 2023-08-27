import 'dart:math';
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
  List<QuizQuestion> randomSelectedQuestions = [];
  int currentQuestionIdx = 0;

  @override
  void initState() {
    super.initState();

    // Shuffle questins and take only 5
    randomSelectedQuestions = List.from(widget.questions);
    randomSelectedQuestions.shuffle(Random());
    randomSelectedQuestions = randomSelectedQuestions.take(5).toList();
    selectedOptionIdx = List.filled(randomSelectedQuestions.length, null);
    answeredCorrectly = List.filled(randomSelectedQuestions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final langCode = translations.getCurrentLangCode();
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: screenWidth * 0.85,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.blueGrey[100],
              ),
              child: Text(
                randomSelectedQuestions[currentQuestionIdx]
                        .question[langCode] ??
                    "",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20),
          ...List.generate(
            randomSelectedQuestions[currentQuestionIdx].options.length,
            (index) => Center(
              child: Container(
                width: screenWidth * 0.7,
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.blueGrey[100],
                ),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      selectedOptionIdx[currentQuestionIdx] = index;
                      answeredCorrectly[currentQuestionIdx] =
                          randomSelectedQuestions[currentQuestionIdx]
                              .options[index]
                              .isCorrect;
                    });
                  },
                  title: Text(
                    randomSelectedQuestions[currentQuestionIdx]
                            .options[index]
                            .label[langCode] ??
                        "",
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Radio(
                    value: index,
                    groupValue: selectedOptionIdx[currentQuestionIdx],
                    onChanged: (int? value) {
                      setState(() {
                        selectedOptionIdx[currentQuestionIdx] = value;
                        answeredCorrectly[currentQuestionIdx] =
                            randomSelectedQuestions[currentQuestionIdx]
                                .options[value!]
                                .isCorrect;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          if (currentQuestionIdx == randomSelectedQuestions.length - 1)
            ElevatedButton(
              onPressed: () {
                int correctAnswers =
                    answeredCorrectly.where((correct) => correct).length;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ScorePage(
                      correctAnswers: correctAnswers,
                      totalQuestions: randomSelectedQuestions.length,
                    ),
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

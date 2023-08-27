import 'dart:math';
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

    // Shuffle questions and take only 5
    randomSelectedQuestions = List.from(widget.questions);
    randomSelectedQuestions.shuffle(Random());
    randomSelectedQuestions = randomSelectedQuestions.take(5).toList();
    selectedOptionIdx = List.filled(randomSelectedQuestions.length, null);
    answeredCorrectly = List.filled(randomSelectedQuestions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translations = AppLocalization.of(context);
    final langCode = translations.getCurrentLangCode();
    final QuestionTextStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.secondary,
      fontSize: 25,
    );
    final OptionTextStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.secondary,
      fontSize: 20,
    );

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
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
                color: theme.colorScheme.background,
              ),
              child: Text(
                randomSelectedQuestions[currentQuestionIdx]
                        .question[langCode] ??
                    "",
                style: QuestionTextStyle,
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
                  color: theme.colorScheme.background,
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
                    style: OptionTextStyle,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Don't show previous button on first question
              if (currentQuestionIdx > 0)
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        currentQuestionIdx--;
                      });
                    },
                    icon: Icon(Icons.navigate_before),
                    color: theme.colorScheme.secondary,
                  ),
                ),

              // Show the current question index
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '${currentQuestionIdx + 1} / ${randomSelectedQuestions.length}',
                  style: QuestionTextStyle,
                ),
              ),

              // Show finish button on last question
              if (currentQuestionIdx == randomSelectedQuestions.length - 1)
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
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
                    icon: Icon(Icons.check),
                    color: theme.colorScheme.secondary,
                  ),
                )

              // Next button
              else
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        currentQuestionIdx++;
                      });
                    },
                    icon: Icon(Icons.navigate_next),
                    color: theme.colorScheme.secondary,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

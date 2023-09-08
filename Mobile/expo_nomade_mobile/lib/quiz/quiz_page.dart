import 'dart:math';
import 'package:flutter/material.dart';
import '../app_localization.dart';
import '../util/globals.dart';
import 'score_page.dart';
import '../bo/quiz_question.dart';

/// Class QuizPage displays the quiz for the user to answer.
class QuizPage extends StatefulWidget {
  final List<QuizQuestion> questions;

  /// Creates a new QuizPage
  const QuizPage({super.key, required this.questions});

  @override
  _QuizPageState createState() => _QuizPageState();
}

/// State class for the QuizPage
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
    randomSelectedQuestions =
        randomSelectedQuestions.take(GlobalConstants.quizQuestionsNb).toList();
    selectedOptionIdx = List.filled(randomSelectedQuestions.length, null);
    answeredCorrectly = List.filled(randomSelectedQuestions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translations = AppLocalization.of(context);
    final langCode = translations.getCurrentLangCode();
    final questionTextStyle = theme.textTheme.displayMedium;
    final optionTextStyle = theme.textTheme.displaySmall;

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: screenWidth * GlobalConstants.quizPageWidthMult,
              padding: const EdgeInsets.all(GlobalConstants.quizDefPaddingSize),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(GlobalConstants.defaultBorderRadius),
                color: theme.colorScheme.background,
              ),
              child: Text(
                randomSelectedQuestions[currentQuestionIdx].question[langCode],
                style: questionTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: GlobalConstants.sizeOfTheBlock),
          ...List.generate(
            randomSelectedQuestions[currentQuestionIdx].options.length,
            (index) => Center(
              child: Container(
                width: screenWidth * GlobalConstants.defaultWidgetWidthMult,
                margin: const EdgeInsets.symmetric(
                    vertical: GlobalConstants.quizPageContMargin),
                padding:
                    const EdgeInsets.all(GlobalConstants.quizPageContPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      GlobalConstants.defaultBorderRadius),
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
                        .label[langCode],
                    style: optionTextStyle,
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
                    icon: const Icon(Icons.navigate_before),
                    color: theme.colorScheme.secondary,
                  ),
                ),

              // Show the current question index
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: GlobalConstants.quizDefPaddingSize),
                child: Text(
                  '${currentQuestionIdx + 1} / ${randomSelectedQuestions.length}',
                  style: questionTextStyle,
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
                    icon: const Icon(Icons.check),
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
                    icon: const Icon(Icons.navigate_next),
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

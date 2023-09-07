import 'package:expo_nomade_mobile/quiz/score_submission_page.dart';
import 'package:flutter/material.dart';
import '../app_localization.dart';
import '../util/globals.dart';

class ScorePage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ScorePage(
      {super.key, required this.correctAnswers, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translations = AppLocalization.of(context);

    final eltTextStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.secondary,
      fontSize: 30, //TODO uniformizer Julienne
    );
//TODO uniformizer Julienne
    final pointTextStyle = theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.secondary,
        fontSize: 75,
        fontWeight: FontWeight.bold);

    double screenWidth = MediaQuery.of(context).size.width;
    int correctPercentage = ((correctAnswers / totalQuestions) * 100).toInt();

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: screenWidth * 0.9,
              padding: const EdgeInsets.all(16.0), //TODO uniformizer
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: theme.colorScheme.background,
              ),
              child: Text(
                translations.getTranslation("quiz_result").toString(),
                style: eltTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: GlobalConstants.sizeOfTheBlock),
          Center(
            child: Container(
              width: screenWidth * 0.9,
              padding: const EdgeInsets.all(16.0), //TODO uniformizer
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: theme.colorScheme.background,
              ),
              child: Column(
                children: [
                  if (correctPercentage >= 90)
                    Text(
                      translations
                          .getTranslation("very_good_result")
                          .toString(),
                      style: eltTextStyle,
                    )
                  else if (correctPercentage >= 80)
                    Text(
                      translations.getTranslation("good_result").toString(),
                      style: eltTextStyle,
                    )
                  else if (correctPercentage >= 60)
                    Text(
                      translations.getTranslation("average_result").toString(),
                      style: eltTextStyle,
                    )
                  else
                    Text(
                      translations.getTranslation("bad_result").toString(),
                      style: eltTextStyle,
                    ),
                  const SizedBox(height: GlobalConstants.sizeOfTheBlock),
                  Text(
                    '${correctPercentage.toStringAsFixed(0)}%',
                    style: pointTextStyle,
                  ),
                  const SizedBox(height: GlobalConstants.sizeOfTheBlock),
                  Text(
                    ('${translations.getTranslation("answer_msg_0")} $correctAnswers '
                        '${correctAnswers == 0 ? translations.getTranslation("answer_msg_1_sing") : translations.getTranslation("answer_msg_1_plur")} '
                        '$totalQuestions'
                        '${translations.getTranslation("answer_msg_2")}'),
                    style: eltTextStyle,
                  ),
                  const SizedBox(height: GlobalConstants.sizeOfTheBlock),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ScoreSubmissionPage(score: correctPercentage),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          theme.colorScheme.secondary),
                    ),
                    child: Text(
                      translations.getTranslation("next").toString(),
                      style: TextStyle(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

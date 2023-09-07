import 'package:expo_nomade_mobile/quiz/score_submission_page.dart';
import 'package:flutter/material.dart';
import '../app_localization.dart';

class ScorePage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ScorePage(
      {super.key, required this.correctAnswers, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translations = AppLocalization.of(context);
    final langCode = translations.getCurrentLangCode();

    final EltTextStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.secondary,
      fontSize: 30,
    );

    final PointTextStyle = theme.textTheme.displayMedium!.copyWith(
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
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: theme.colorScheme.background,
              ),
              child: Text(
                translations.getTranslation("quiz_result").toString(),
                style: EltTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Container(
              width: screenWidth * 0.9,
              padding: EdgeInsets.all(16.0),
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
                      style: EltTextStyle,
                    )
                  else if (correctPercentage >= 80)
                    Text(
                      translations.getTranslation("good_result").toString(),
                      style: EltTextStyle,
                    )
                  else if (correctPercentage >= 60)
                    Text(
                      translations.getTranslation("average_result").toString(),
                      style: EltTextStyle,
                    )
                  else
                    Text(
                      translations.getTranslation("bad_result").toString(),
                      style: EltTextStyle,
                    ),
                  SizedBox(height: 20),
                  Text(
                    '${correctPercentage.toStringAsFixed(0)}%',
                    style: PointTextStyle,
                  ),
                  SizedBox(height: 20),
                  Text(
                    ('${translations.getTranslation("answer_msg_0")} $correctAnswers '
                        '${correctAnswers == 0 ? translations.getTranslation("answer_msg_1_sing") : translations.getTranslation("answer_msg_1_plur")} '
                        '$totalQuestions'
                        '${translations.getTranslation("answer_msg_2")}'),
                    style: EltTextStyle,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ScoreSubmissionPage(score: correctPercentage),
                        ),
                      );
                    },
                    child: Text(
                      translations.getTranslation("next").toString(),
                      style: TextStyle(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          theme.colorScheme.secondary),
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

import 'package:expo_nomade_mobile/bo/exposition.dart';
import 'package:expo_nomade_mobile/bo/paticipation.dart';
import 'package:expo_nomade_mobile/helper/firebase_service.dart';
import 'package:expo_nomade_mobile/helper/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/app_localization.dart';
import '../helper/validation_helper.dart';
import '../helper/notifer_helper.dart';

/// Class ScoreSubmissionPage is the widget that will display the final score and let the user choose to save his score or return to the home page.
class ScoreSubmissionPage extends StatelessWidget {
  final int score;
  final TextEditingController emailController = TextEditingController();

  /// Creates a new ScoreSubmissionPage
  ScoreSubmissionPage({super.key, required this.score});

  /// Shows a dialog to tell that the input e-mail address is not valid.
  Future<void> _showInvalidEmailDialog(BuildContext context) async {
    final translations = AppLocalization.of(context);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translations.getTranslation("invalid_email").toString()),
          content: Text(
              translations.getTranslation("please_email_valid").toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(GlobalConstants.okMsg),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translations = AppLocalization.of(context);

    final dataProvider = Provider.of<ExpositionNotifier>(context);
    final Exposition expo = dataProvider.exposition;

    final scoreTextStyle = theme.textTheme.displayLarge;
    final contentTextStyle = theme.textTheme.displaySmall;

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: screenWidth * GlobalConstants.quizWidgetsWidthMult,
              padding: const EdgeInsets.all(GlobalConstants.quizDefPaddingSize),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(GlobalConstants.defaultBorderRadius),
                color: theme.colorScheme.background,
              ),
              child: Text(
                translations.getTranslation("submit_score").toString(),
                style: scoreTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: GlobalConstants.sizeOfTheBlock),
          Center(
            child: Container(
              width: screenWidth * GlobalConstants.quizWidgetsWidthMult,
              padding: const EdgeInsets.all(GlobalConstants.quizDefPaddingSize),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(GlobalConstants.defaultBorderRadius),
                color: theme.colorScheme.background,
              ),
              child: Column(
                children: [
                  Text(
                    translations.getTranslation("contact_input").toString(),
                    style: contentTextStyle,
                  ),
                  const SizedBox(height: GlobalConstants.sizeOfTheBlock),
                  Row(
                    children: [
                      Text(
                        translations.getTranslation("email"),
                        style: contentTextStyle,
                      ),
                      Expanded(
                        child: TextFormField(controller: emailController),
                      ),
                    ],
                  ),
                  const SizedBox(height: GlobalConstants.sizeOfTheBlock),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        child: Text(
                          translations.getTranslation("quit").toString(),
                          style: contentTextStyle,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          String email = emailController.text;
                          if (ValidationHelper.isValidEmail(email)) {
                            // Send to Firebase
                            Participation? participation =
                                await FirebaseService.submitScore(email, score);

                            if (participation != null) {
                              expo.quiz.participations.add(participation);
                            }

                            // Navigate to the main page
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          } else {
                            _showInvalidEmailDialog(context);
                          }
                        },
                        child: Text(
                          translations.getTranslation("send").toString(),
                          style: contentTextStyle,
                        ),
                      ),
                    ],
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

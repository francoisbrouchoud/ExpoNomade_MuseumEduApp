import 'package:expo_nomade_mobile/bo/exposition.dart';
import 'package:expo_nomade_mobile/bo/paticipation.dart';
import 'package:expo_nomade_mobile/firebase_service.dart';
import 'package:expo_nomade_mobile/util/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_localization.dart';

class ScoreSubmissionPage extends StatelessWidget {
  final int score;
  final TextEditingController emailController = TextEditingController();

  ScoreSubmissionPage({super.key, required this.score});

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }

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
              child: Text('OK'),
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
    final langCode = translations.getCurrentLangCode();

    final dataProvider = Provider.of<ExpositionNotifier>(context);
    final Exposition expo = dataProvider.exposition;

    final ScoreTextStyle = theme.textTheme.bodyText1!.copyWith(
      color: theme.colorScheme.secondary,
      fontSize: 30,
    );

    final ContentTextStyle = theme.textTheme.bodyText1!.copyWith(
      color: theme.colorScheme.secondary,
      fontSize: 20,
    );

    double screenWidth = MediaQuery.of(context).size.width;

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
                translations.getTranslation("submit_score").toString(),
                style: ScoreTextStyle,
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
                  Text(
                    translations.getTranslation("contact_input").toString(),
                    style: ContentTextStyle,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Email: ",
                        style: ContentTextStyle,
                      ),
                      Expanded(
                        child: TextFormField(controller: emailController),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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
                          style: ContentTextStyle,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          String email = emailController.text;
                          if (isValidEmail(email)) {
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
                          style: ContentTextStyle,
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

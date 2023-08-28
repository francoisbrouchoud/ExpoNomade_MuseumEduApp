import 'package:flutter/material.dart';
import '../app_localization.dart';

class ScoreSubmissionPage extends StatelessWidget {
  final int score;
  final TextEditingController emailController = TextEditingController();

  ScoreSubmissionPage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translations = AppLocalization.of(context);
    final langCode = translations.getCurrentLangCode();

    final EltTextStyle = theme.textTheme.bodyText1!.copyWith(
      color: theme.colorScheme.secondary,
      fontSize: 30,
    );

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Score'),
      ),
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
                  Text(
                    translations.getTranslation("contact_input").toString(),
                    style: EltTextStyle,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text("Email: ", style: TextStyle(fontSize: 18)),
                      Expanded(
                        child: TextFormField(controller: emailController),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Ici, vous pouvez envoyer le score et l'email.
                    },
                    child: Text('Submit Score'),
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

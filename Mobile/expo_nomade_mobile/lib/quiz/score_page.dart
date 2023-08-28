import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ScorePage(
      {super.key, required this.correctAnswers, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final EltTextStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.secondary,
      fontSize: 30,
    );

    final PointTextStyle = theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.secondary,
        fontSize: 75,
        fontWeight: FontWeight.bold);

    double screenWidth = MediaQuery.of(context).size.width;
    double correctPercentage = (correctAnswers / totalQuestions) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats'),
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
                'Résultats du quiz',
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
                    'Félititations ! Voici ton score : ',
                    style: EltTextStyle,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${correctPercentage.toStringAsFixed(0)}%',
                    style: PointTextStyle,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Tu as obtenu $correctAnswers réponses correctes sur $totalQuestions',
                    style: EltTextStyle,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) =>
                          route.isFirst); // Revenir à la première page
                    },
                    child: Text(
                      'Suivant',
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

import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ScorePage(
      {super.key, required this.correctAnswers, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Résultats du quiz',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text('Correctes : $correctAnswers / $totalQuestions',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil(
                    (route) => route.isFirst); // Revenir à la première page
              },
              child: const Text('Retour au menu principal'),
            ),
          ],
        ),
      ),
    );
  }
}

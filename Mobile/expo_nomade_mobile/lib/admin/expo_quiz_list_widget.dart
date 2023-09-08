import 'package:expo_nomade_mobile/admin/expo_quiz_editor_widget.dart';
import 'package:expo_nomade_mobile/helper/app_localization.dart';
import 'package:expo_nomade_mobile/bo/quiz_question.dart';
import 'package:expo_nomade_mobile/util/base_bo_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/globals.dart';

/// Class ExpoQuestionListWidget is used to list a collection of QuizQuestion. Inherits from BaseBOListWidget.
class ExpoQuizListWidget extends BaseBOListWidget {
  /// Creates a new QuizQuestionListWidget.
  ExpoQuizListWidget({super.key, required BuildContext context})
      : super(
            title: AppLocalization.of(context).getTranslation("quiz"),
            listableItems:
                Provider.of<ExpositionNotifier>(context, listen: true)
                    .exposition
                    .quiz
                    .questions,
            itemTap: (item) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExpoQuizEditorWidget(
                    quizQuestion: (item as QuizQuestion),
                  ),
                ),
              );
            },
            itemAddRequested: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ExpoQuizEditorWidget(),
                ),
              );
            },
            addButtonText: AppLocalization.of(context)
                .getTranslation("question_creation"));
}

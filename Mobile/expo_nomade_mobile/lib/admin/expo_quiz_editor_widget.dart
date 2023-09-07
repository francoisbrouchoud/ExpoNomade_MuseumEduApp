import 'dart:collection';

import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/exposition.dart';
import 'package:expo_nomade_mobile/bo/quiz_question.dart';
import 'package:expo_nomade_mobile/firebase_service.dart';
import 'package:expo_nomade_mobile/util/base_bo_editor_widget.dart';
import 'package:expo_nomade_mobile/util/globals.dart';
import 'package:expo_nomade_mobile/util/latlng_selector_widget.dart';
import 'package:expo_nomade_mobile/util/multilingual_string.dart';
import 'package:expo_nomade_mobile/util/multilingual_string_editor.dart';

import 'package:expo_nomade_mobile/util/simple_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bo/expo_event.dart';

/// Class ExpoQuizEditorWidget is a widget used to edit or create an QuizQuestion object.
class ExpoQuizEditorWidget extends StatefulWidget {
  final QuizQuestion? quizQuestion;

  /// ExpoQuizEditorWidget constructor.
  const ExpoQuizEditorWidget(
      {super.key, this.quizQuestion, required QuizQuestion quiz});

  @override
  _ExpoQuizEditorWidgetState createState() => _ExpoQuizEditorWidgetState();
}

/// State class for the ExpoQuizEditorWidget.
class _ExpoQuizEditorWidgetState extends State<ExpoQuizEditorWidget> {
  @override
  void initState() {
    super.initState();
  }

  /// Navigates back to the list view.
  void backToList() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final dataProvider = Provider.of<ExpositionNotifier>(context);
    final Exposition expo = dataProvider.exposition;
    Map<String, String> newQuestVals =
        widget.quizQuestion?.question.toMap() ?? HashMap();
    List<QuizOption> newQuizOptVals = widget.quizQuestion?.options ?? [];

    return Material(
      child: BaseBOEditorWidget(
        title: widget.quizQuestion != null
            ? translations.getTranslation("question_edit")
            : translations.getTranslation("question_creation"),
        content: [
          MultilingualStringEditorWidget(
            name: translations.getTranslation("title"),
            value: widget.quizQuestion != null
                ? widget.quizQuestion!.question
                : null,
            valueChanged: (newVals) => newQuestVals = newVals,
            mandatory: true,
          ),
          /*
          QuizOptionsEditor(
            name: translations.getTranslation("coordinates_from"),
            values: newQuizOptVals,
            valuesChanged: (newVals) => newQuizOptVals = newVals,
            mandatory: true,
          )
          */
        ],
        object: widget.quizQuestion,
        itemSaveRequested: () async {
          QuizQuestion quizQuestion =
              QuizQuestion(MultilingualString(newQuestVals), new List.empty());
          if (widget.quizQuestion != null) {
            quizQuestion = widget.quizQuestion!;
            quizQuestion.question = MultilingualString(newQuestVals);
            quizQuestion.options = new List.empty();

            await FirebaseService.updateQuizQuestion(quizQuestion);
          } else {
            QuizQuestion? newQuizQuestion =
                await FirebaseService.createQuizQuestion(quizQuestion);
            if (newQuizQuestion != null) {
              expo.quiz.questions.add(newQuizQuestion);
            }
          }
          dataProvider.forceRelaod();
          SimpleSnackBar.showSnackBar(
              context, translations.getTranslation("saved"));
          backToList();
        },
        itemDeleteRequested: () async {
          await FirebaseService.deleteQuizQuestion(widget.quizQuestion!);
          expo.events.remove(widget.quizQuestion!);
          dataProvider.forceRelaod();
          backToList();
        },
      ),
    );
  }
}
import 'dart:collection';

import 'package:expo_nomade_mobile/helper/app_localization.dart';
import 'package:expo_nomade_mobile/bo/exposition.dart';
import 'package:expo_nomade_mobile/bo/quiz_question.dart';
import 'package:expo_nomade_mobile/helper/firebase_service.dart';
import 'package:expo_nomade_mobile/widgets/base_bo_editor_widget.dart';
import '../helper/notifer_helper.dart';
import 'package:expo_nomade_mobile/helper/multilingual_string.dart';
import 'package:expo_nomade_mobile/widgets/multilingual_string_editor_widget.dart';
import 'package:expo_nomade_mobile/widgets/quiz_option_selector_widget.dart';

import 'package:expo_nomade_mobile/widgets/simple_snack_bar.dart';
import 'package:expo_nomade_mobile/helper/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Class ExpoQuizEditorWidget is a widget used to edit or create an QuizQuestion object.
class ExpoQuizEditorWidget extends StatefulWidget {
  final QuizQuestion? quizQuestion;

  /// ExpoQuizEditorWidget constructor.
  const ExpoQuizEditorWidget({super.key, this.quizQuestion});

  @override
  ExpoQuizEditorWidgetState createState() => ExpoQuizEditorWidgetState();
}

/// State class for the ExpoQuizEditorWidget.
class ExpoQuizEditorWidgetState extends State<ExpoQuizEditorWidget> {
  @override
  void initState() {
    super.initState();
  }

  /// Navigates back to the list view.
  void backToList({String? text}) {
    if (text != null) {
      SimpleSnackBar.showSnackBar(context, text);
    }
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
            name: translations.getTranslation("question_title"),
            value: widget.quizQuestion != null
                ? widget.quizQuestion!.question
                : null,
            valueChanged: (newVals) => newQuestVals = newVals,
            mandatory: true,
          ),
          QuizOptionSelectorWidget(
            name: translations.getTranslation("option_edit"),
            values: newQuizOptVals,
            valuesChanged: (newVals) => newQuizOptVals = newVals,
            mandatory: true,
          )
        ],
        object: widget.quizQuestion,
        itemSaveRequested: () async {
          if (!ValidationHelper.isEmptyTranslationMap(newQuestVals) &&
              !ValidationHelper.isIncompleteQuizOptionList(newQuizOptVals)) {
            QuizQuestion quizQuestion = QuizQuestion(
                "", MultilingualString(newQuestVals), newQuizOptVals);
            if (widget.quizQuestion != null) {
              quizQuestion = widget.quizQuestion!;
              quizQuestion.question = MultilingualString(newQuestVals);
              quizQuestion.options = newQuizOptVals;

              await FirebaseService.updateQuizQuestion(quizQuestion);
            } else {
              QuizQuestion? newQuizQuestion =
                  await FirebaseService.createQuizQuestion(quizQuestion);
              if (newQuizQuestion != null) {
                expo.quiz.questions.add(newQuizQuestion);
              }
            }
            dataProvider.forceRelaod();

            backToList(text: translations.getTranslation("saved"));
          } else {
            SimpleSnackBar.showSnackBar(context,
                translations.getTranslation("fill_required_fields_msg"));
          }
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

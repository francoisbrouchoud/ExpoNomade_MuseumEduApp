import 'package:expo_nomade_mobile/helper/app_localization.dart';
import 'package:expo_nomade_mobile/bo/quiz_question.dart';
import 'package:expo_nomade_mobile/util/bo_editor_block_widget.dart';
import 'package:expo_nomade_mobile/helper/globals.dart';
import 'package:expo_nomade_mobile/helper/multilingual_string.dart';
import 'package:expo_nomade_mobile/util/multilingual_string_editor_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Class QuizOptionSelectorWidget is used to display input fields to create or edit options for a quiz question.
class QuizOptionSelectorWidget extends StatefulWidget {
  final String name;
  final List<QuizOption>? values;
  final Function(List<QuizOption>) valuesChanged;
  final bool mandatory;

  /// Creates a new QuizOptionSelectorWidget
  const QuizOptionSelectorWidget(
      {super.key,
      required this.name,
      required this.valuesChanged,
      this.values,
      this.mandatory = false});

  @override
  QuizOptionSelectorWidgetState createState() =>
      QuizOptionSelectorWidgetState();
}

/// State class for the QuizOptionSelectorWidget.
class QuizOptionSelectorWidgetState extends State<QuizOptionSelectorWidget> {
  late List<QuizOption> quizOptions;

  @override
  void initState() {
    super.initState();

    if (widget.values != null && widget.values!.isNotEmpty) {
      quizOptions = widget.values!;
      QuizOption optionCorrect =
          quizOptions.singleWhere((element) => element.isCorrect);
      quizOptions.remove(optionCorrect);
      quizOptions.insert(0, optionCorrect);
    } else {
      quizOptions = [];

      for (var i = 0; i <= GlobalConstants.quizOptionMinNb; i++) {
        quizOptions
            .add(QuizOption(label: MultilingualString({}), isCorrect: i == 0));
      }
    }
  }

  /// Adds new option field
  void _addOption(BuildContext buildContext) {
    setState(() {
      quizOptions.add(QuizOption(label: MultilingualString({})));
    });
  }

  /// Updates the value of the quizOption at the given index
  void _valueChange(int idx, Map<String, String>? newValues) {
    if (newValues != null) {
      setState(() {
        quizOptions.elementAt(idx).label = MultilingualString(newValues);
      });
    } else {
      setState(() {
        quizOptions.removeAt(idx);
      });
    }
    widget.valuesChanged(quizOptions);
  }

  /// Removes an option field
  void _deleteOption(int idx) {
    _valueChange(idx, null);
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final option = translations.getTranslation("option");

    return BOEditorBlockWidget(
      name: widget.name,
      mandatory: widget.mandatory,
      children: [
        ...quizOptions.map(
          (quizOption) => Row(
            children: [
              Expanded(
                  child: MultilingualStringEditorWidget(
                name:
                    "$option ${quizOptions.indexOf(quizOption) + 1}: ${quizOptions.indexOf(quizOption) == 0 ? translations.getTranslation("option_true") : translations.getTranslation("option_false")}",
                value: quizOption.label,
                valueChanged: (newValues) =>
                    _valueChange(quizOptions.indexOf(quizOption), newValues),
                mandatory: true,
              )),
              const SizedBox(
                  width: GlobalConstants.textFormFieldIconRightMargin),
              if (quizOptions.indexOf(quizOption) >=
                  GlobalConstants.eventMinCoordinatesNb)
                IconButton(
                    onPressed: () =>
                        _deleteOption(quizOptions.indexOf(quizOption)),
                    icon: const Icon(CupertinoIcons.delete,
                        size: GlobalConstants.iconsDefaultDimension))
              else
                const SizedBox(
                    width: GlobalConstants.textFormFieldIconRightMargin)
            ],
          ),
        ),
        if (quizOptions.length < GlobalConstants.quizOptionMaxNb)
          Row(
            children: [
              Center(
                child: IconButton(
                  onPressed: () => _addOption(context),
                  icon: const Icon(
                    CupertinoIcons.add,
                    size: GlobalConstants.iconsDefaultDimension,
                  ),
                ),
              )
            ],
          ),
      ],
    );
  }
}

import 'dart:collection';

import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/quiz_question.dart';
import 'package:expo_nomade_mobile/util/bo_editor_block_widget.dart';
import 'package:expo_nomade_mobile/util/globals.dart';
import 'package:expo_nomade_mobile/util/input_formatters.dart';
import 'package:expo_nomade_mobile/util/multilingual_string.dart';
import 'package:expo_nomade_mobile/util/multilingual_string_editor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:latlong2/latlong.dart';

/// Class QuizOptionSelectorWidget is used to display a list of TextFormFields to input at least three latitudes and longitudes.
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
  _QuizOptionSelectorWidgetState createState() =>
      _QuizOptionSelectorWidgetState();
}

/// State class for the QuizOptionSelectorWidget.
class _QuizOptionSelectorWidgetState extends State<QuizOptionSelectorWidget> {
  late List<QuizOption> quizOptions;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.values != null) {
      quizOptions = widget.values!;
      QuizOption optionCorrect =
          quizOptions.singleWhere((element) => element.isCorrect);
      quizOptions.remove(optionCorrect);
      quizOptions.insert(0, optionCorrect);
    } else {
      quizOptions = [];

      for (var i = 0; i < GlobalConstants.quizOptionMinNb; i++) {
        quizOptions
            .add(QuizOption(label: MultilingualString({}), isCorrect: i == 0));
      }
    }
  }

  /// Adds a new coordinate field
  void _addOption(BuildContext buildContext) {
    setState(() {
      widget.values!.add(QuizOption(label: MultilingualString({})));
      /*
      _controllers.add(MultilingualStringEditorWidget(
          name:
              "${AppLocalization.of(buildContext).getTranslation("option")} ${_controllers.length + 1}",
          value: null,
          valueChanged: (newValues) =>
              _valueChange(_controllers.length + 1, newValues)));
              */
    });
  }

  /// si on passe un qui est nul on devra le supprimer
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

  /// Removes a coordinate field
  void _deleteOption(int idx) {
    _valueChange(idx, null);
    // make sure the listener doesn't keep the deleted option
  }
/*
  @override
  void initState() {
    super.initState();
    _controllers = [];
    for (var option in widget.values!) {
      _controllers.add(MultilingualStringEditorWidget(
          name: "Option",
          value: option.label,
          valueChanged: (newValues) =>
              _valueChange(_controllers.length + 1, newValues)));
    }
    if (_controllers.length < GlobalConstants.quizOptionMinNb) {
      for (var i = _controllers.length;
          i < GlobalConstants.quizOptionMinNb;
          i++) {
        _controllers.add(MultilingualStringEditorWidget(
            name: "Option",
            value: null,
            valueChanged: (newValues) =>
                _valueChange(_controllers.length + 1, newValues)));
      }
    }
  }*/

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
                      name: "$option ${quizOptions.indexOf(quizOption)}",
                      value: quizOption.label,
                      valueChanged: (newValues) => _valueChange(
                          quizOptions.indexOf(quizOption), newValues))),
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

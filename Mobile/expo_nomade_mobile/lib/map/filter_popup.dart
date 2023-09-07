import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:flutter/material.dart';

import '../bo/expo_population_type.dart';
import '../util/multilingual_string.dart';

class FilterPopup extends StatefulWidget {
  final Function(double, double, Set<MultilingualString>, Set<ExpoPopulationType>) onFilterChanged;
  final double startYearFilter;
  final double endYearFilter;
  final Set<MultilingualString> selectedReasons;
  final Set<MultilingualString> allReasons;
  final Set<ExpoPopulationType> selectedPopulations;
  final Set<ExpoPopulationType> allPopulations;

  const FilterPopup({
    required this.onFilterChanged,
    required this.startYearFilter,
    required this.endYearFilter,
    required this.selectedReasons,
    required this.allReasons,
    required this.selectedPopulations,
    required this.allPopulations,
    Key? key,
  }) : super(key: key);

  @override
  _FilterPopupState createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  late double start;
  late double end;
  Set<MultilingualString> selectedReasons = {};
  Set<ExpoPopulationType> selectedPopulations = {};

  @override
  void initState() {
    super.initState();
    start = widget.startYearFilter;
    end = widget.endYearFilter;
    selectedReasons = widget.selectedReasons;
    selectedPopulations = widget.selectedPopulations;
  }


  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final langCode = translations.getCurrentLangCode();
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(translations.getTranslation("years").toString()),
          RangeSlider(
            values: RangeValues(start, end),
            min: 1700,
            max: 2020,
            divisions: 32,
            onChanged: (RangeValues values) {
              setState(() {
                start = values.start;
                end = values.end;
              });
              widget.onFilterChanged(values.start, values.end, selectedReasons, selectedPopulations);
            },
            labels: RangeLabels(
              start.round().toString(),
              end.round().toString(),
            ),
          ),

          Text('Raison'),
          ...widget.allReasons.map((reason) {
            return CheckboxListTile(
              title: Text(reason[langCode]),
              value: selectedReasons.contains(reason),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedReasons.add(reason);
                  } else {
                    selectedReasons.remove(reason);
                  }
                });
                // update filtered elements
                widget.onFilterChanged(start, end, selectedReasons, selectedPopulations);
              },
            );
          }).toList(),

          Text('Type de population'),
          ...widget.allPopulations.map((pop) {
            return CheckboxListTile(
              title: Text(pop.title[langCode]),
              value: selectedPopulations.contains(pop),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedPopulations.add(pop);
                  } else {
                    selectedPopulations.remove(pop);
                  }
                });
                // update filtered elements
                widget.onFilterChanged(start, end, selectedReasons, selectedPopulations);
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}

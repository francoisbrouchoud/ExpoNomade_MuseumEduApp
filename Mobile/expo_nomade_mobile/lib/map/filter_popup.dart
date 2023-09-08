import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/expo_axis.dart';
import 'package:flutter/material.dart';

import '../bo/expo_population_type.dart';

class FilterPopup extends StatefulWidget {
  final Function(double, double, Set<ExpoAxis>, Set<ExpoPopulationType>) onFilterChanged;
  final double startYearFilter;
  final double endYearFilter;
  final Set<ExpoAxis> selectedReasons;
  final Set<ExpoAxis> allReasons;
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
  Set<ExpoAxis> selectedReasons = {};
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
    final theme = Theme.of(context);
    final translations = AppLocalization.of(context);
    final langCode = translations.getCurrentLangCode();
    return Container(
      color: theme.colorScheme.onBackground,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              translations.getTranslation("years").toString(),
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          RangeSlider(
            values: RangeValues(start, end),
            min: widget.startYearFilter,
            max: widget.endYearFilter,
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

          if(widget.allReasons.isNotEmpty) 
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                translations.getTranslation("reason").toString(),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),

          if(widget.allReasons.isNotEmpty)
            ...widget.allReasons.map((reason) {
              return CheckboxListTile(
                title: Text(reason.title[langCode]),
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

          if(widget.allPopulations.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                translations.getTranslation("population_types").toString(),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          
          if(widget.allPopulations.isNotEmpty)
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

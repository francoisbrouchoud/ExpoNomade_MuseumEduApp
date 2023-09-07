import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:flutter/material.dart';

import '../bo/expo_event.dart';
import 'filter_logic.dart';

class FilterPopup extends StatefulWidget {
  final Function(double, double) onRangeChanged;
  final double startYearFilter;
  final double endYearFilter;
  final Set<String> selectedReasons;

  const FilterPopup({
    required this.onRangeChanged,
    required this.startYearFilter,
    required this.endYearFilter,
    required this.selectedReasons,
    Key? key,
  }) : super(key: key);

  @override
  _FilterPopupState createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  late double start;
  late double end;
  Set<String> selectedReasons = {};
  Set<String> allReasons = {};
  List<ExpoEvent> filteredEvents = [];

  @override
  void initState() {
    super.initState();
    start = widget.startYearFilter;
    end = widget.endYearFilter;
    selectedReasons = widget.selectedReasons;
    allReasons = widget.selectedReasons;
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
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
              widget.onRangeChanged(values.start, values.end);
            },
            labels: RangeLabels(
              start.round().toString(),
              end.round().toString(),
            ),
          ),
          Text(translations.getTranslation("years").toString()),

          ...selectedReasons.map((reason) {
            return CheckboxListTile(
              title: Text(reason),
              value: selectedReasons.contains(reason),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedReasons.add(reason);
                  } else {
                    selectedReasons.remove(reason);
                  }
                  // Mettre à jour le filtrage
                  //filteredEvents = filterEvents(widget.exposition.events, start, end, selectedReasons);
                });
              },
            );
          }).toList(),
          // Ajoutez d'autres filtres ici
        ],
      ),
    );
  }
}

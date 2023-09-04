import 'package:expo_nomade_mobile/util/underlined_container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Class YearSelectorWidget is used to display a simple widget to input a year
class YearSelectorWidget extends StatefulWidget {
  final String name;
  final Function(int) selectedYearChanged;
  final int selectedYear;

  /// Creates a new YearSelectorWidget
  const YearSelectorWidget(
      {super.key,
      required this.name,
      required this.selectedYearChanged,
      required this.selectedYear});

  @override
  _YearSelectorWidgetState createState() => _YearSelectorWidgetState();
}

/// State class for the YearSelectorWidget.
class _YearSelectorWidgetState extends State<YearSelectorWidget> {
  late int selectedYear = widget.selectedYear;

  /// Shows a dialog to select a year.
  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(selectedYear),
      firstDate: DateTime(-1000), // TODO select a first year
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null && picked.year != selectedYear) {
      setState(() {
        selectedYear = picked.year;
        widget.selectedYearChanged(selectedYear);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const containerMargin = 15.0;
    const iconDim = 24.0;
    return UnderlinedContainerWidget(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: containerMargin),
          Row(
            children: [Text(widget.name)],
          ),
          Row(
            children: [
              Text(selectedYear.toString()),
              IconButton(
                onPressed: () => _selectYear(context),
                icon: const Icon(
                  CupertinoIcons.calendar,
                  size: iconDim,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

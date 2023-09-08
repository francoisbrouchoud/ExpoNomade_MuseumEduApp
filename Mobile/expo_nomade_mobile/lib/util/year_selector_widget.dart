import 'package:expo_nomade_mobile/util/bo_editor_block_widget.dart';
import 'package:expo_nomade_mobile/helper/input_formatters.dart';
import 'package:flutter/material.dart';

/// Class YearSelectorWidget is used to display a simple widget to input a year
class YearSelectorWidget extends StatefulWidget {
  final String name;
  final Function(int) selectedYearChanged;
  final int selectedYear;
  final bool mandatory;

  /// Creates a new YearSelectorWidget
  const YearSelectorWidget({
    Key? key,
    required this.name,
    required this.selectedYearChanged,
    required this.selectedYear,
    this.mandatory = false,
  }) : super(key: key);

  @override
  YearSelectorWidgetState createState() => YearSelectorWidgetState();
}

/// State class for the YearSelectorWidget.
class YearSelectorWidgetState extends State<YearSelectorWidget> {
  late int selectedYear = widget.selectedYear;
  final TextEditingController _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _yearController.text = selectedYear.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BOEditorBlockWidget(
      name: widget.name,
      mandatory: widget.mandatory,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _yearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: widget.name,
                ),
                onChanged: (value) {
                  final year = int.tryParse(value);
                  if (year != null) {
                    selectedYear = year;
                    widget.selectedYearChanged(selectedYear);
                  }
                },
                inputFormatters: [IntegerInputFormatter()],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:expo_nomade_mobile/helper/app_localization.dart';
import 'package:expo_nomade_mobile/util/bo_editor_block_widget.dart';
import 'package:expo_nomade_mobile/helper/globals.dart';
import 'package:expo_nomade_mobile/helper/input_formatters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:latlong2/latlong.dart';

/// Class LatLngYearSelectorWidget is used to display a list of TextFormFields to input at least one latitudes and longitudes linked to a year.
class LatLngYearSelectorWidget extends StatefulWidget {
  final String name;
  final Map<int, LatLng>? values;
  final Function(Map<int, LatLng>) valuesChanged;
  final bool mandatory;

  /// Creates a new LatLngYearSelectorWidget
  const LatLngYearSelectorWidget(
      {super.key,
      required this.name,
      required this.valuesChanged,
      this.values,
      this.mandatory = false});

  @override
  LatLngYearSelectorWidgetState createState() =>
      LatLngYearSelectorWidgetState();
}

/// State class for the LatLngYearSelectorWidget.
class LatLngYearSelectorWidgetState extends State<LatLngYearSelectorWidget> {
  late final List<List<TextEditingController>> _controllers;

  /// Gets the current values from the TextFormFields
  Map<int, LatLng> _getCurrentValues() {
    Map<int, LatLng> vals = {};
    for (var controller in _controllers) {
      if (int.tryParse(controller[0].text) != null &&
          double.tryParse(controller[1].text) != null &&
          double.tryParse(controller[2].text) != null) {
        vals.putIfAbsent(
            int.parse(controller[0].text),
            () => LatLng(double.parse(controller[1].text),
                double.parse(controller[2].text)));
      }
    }
    return vals;
  }

  /// Adds a new coordinate field
  void _addCoordinate() {
    setState(() {
      _controllers.add([
        TextEditingController(),
        TextEditingController(),
        TextEditingController()
      ]);
      _controllers.last[0]
          .addListener(() => widget.valuesChanged(_getCurrentValues()));
      _controllers.last[1]
          .addListener(() => widget.valuesChanged(_getCurrentValues()));
      _controllers.last[2]
          .addListener(() => widget.valuesChanged(_getCurrentValues()));
    });
  }

  /// Removes a coordinate field
  void _deleteCoordinate(int idx) {
    setState(() {
      _controllers.removeAt(idx);
      widget.valuesChanged(
          _getCurrentValues()); // make sure the listener doesn't keep the deleted coordinates
    });
  }

  @override
  void initState() {
    super.initState();
    _controllers = [];
    for (var lnlg in widget.values!.entries) {
      _controllers.add([
        TextEditingController(text: lnlg.key.toString()),
        TextEditingController(text: lnlg.value.latitude.toString()),
        TextEditingController(text: lnlg.value.longitude.toString())
      ]);
    }
    if (_controllers.length < GlobalConstants.objectMinCoordinatesNb) {
      for (var i = _controllers.length;
          i < GlobalConstants.objectMinCoordinatesNb;
          i++) {
        _controllers.add([
          TextEditingController(),
          TextEditingController(),
          TextEditingController()
        ]);
      }
    }
    for (var cp in _controllers) {
      cp[0].addListener(() => widget.valuesChanged(_getCurrentValues()));
      cp[1].addListener(() => widget.valuesChanged(_getCurrentValues()));
      cp[2].addListener(() => widget.valuesChanged(_getCurrentValues()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final yr = translations.getTranslation("year");
    final lat = translations.getTranslation("latitude");
    final lon = translations.getTranslation("longitude");
    return BOEditorBlockWidget(
      name: widget.name,
      mandatory: widget.mandatory,
      children: [
        ..._controllers.map(
          (controller) => Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: GlobalConstants.multiTFFLabelMargin),
                child: Text(yr),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller[0],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: yr,
                  ),
                  inputFormatters: [IntegerInputFormatter()],
                ),
              ),
              const SizedBox(
                  width: GlobalConstants.textFormFieldIconRightMargin),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: GlobalConstants.multiTFFLabelMargin),
                child: Text(lat),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller[1],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: lat),
                  inputFormatters: [DecimalInputFormatter()],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: GlobalConstants.multiTFFLabelMargin),
                child: Text(lon),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller[2],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: lon),
                  inputFormatters: [DecimalInputFormatter()],
                ),
              ),
              if (_controllers.indexOf(controller) >=
                  GlobalConstants.objectMinCoordinatesNb)
                IconButton(
                    onPressed: () =>
                        _deleteCoordinate(_controllers.indexOf(controller)),
                    icon: const Icon(CupertinoIcons.delete,
                        size: GlobalConstants.iconsDefaultDimension))
              else
                const SizedBox(
                    width: GlobalConstants.textFormFieldIconRightMargin)
            ],
          ),
        ),
        Row(
          children: [
            Center(
              child: IconButton(
                onPressed: _addCoordinate,
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

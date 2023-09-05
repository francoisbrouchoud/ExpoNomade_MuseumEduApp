import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/util/bo_editor_block_widget.dart';
import 'package:expo_nomade_mobile/util/input_formatters.dart';
import 'package:expo_nomade_mobile/util/validation_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:latlong2/latlong.dart';

/// Class LatLngSelectorWidget is used to display a list of TextFormFields to input at least three latitudes and longitudes.
class LatLngSelectorWidget extends StatefulWidget {
  final String name;
  final List<LatLng>? values;
  final Function(List<LatLng>) valuesChanged;
  final bool mandatory;

  /// Creates a new LatLngSelectorWidget
  const LatLngSelectorWidget(
      {super.key,
      required this.name,
      required this.valuesChanged,
      this.values,
      this.mandatory = false});

  @override
  _LatLngSelectorWidgetState createState() => _LatLngSelectorWidgetState();
}

/// State class for the LatLngSelectorWidget.
class _LatLngSelectorWidgetState extends State<LatLngSelectorWidget> {
  late final List<List<TextEditingController>> _controllers;

  /// Gets the current values from the TextFormFields
  List<LatLng> _getCurrentValues() {
    List<LatLng> vals = [];
    for (var pair in _controllers) {
      if (double.tryParse(pair[0].text) != null &&
          double.tryParse(pair[1].text) != null) {
        vals.add(
            LatLng(double.parse(pair[0].text), double.parse(pair[1].text)));
      }
    }
    return vals;
  }

  /// Adds a new coordinate field
  void _addCoordinate() {
    setState(() {
      _controllers.add([TextEditingController(), TextEditingController()]);
      _controllers.last[0]
          .addListener(() => widget.valuesChanged(_getCurrentValues()));
      _controllers.last[1]
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
    for (var lnlg in widget.values!) {
      _controllers.add([
        TextEditingController(text: lnlg.latitude.toString()),
        TextEditingController(text: lnlg.longitude.toString())
      ]);
    }
    if (_controllers.length < eventMinCoordinatesNb) {
      for (var i = _controllers.length; i < eventMinCoordinatesNb; i++) {
        _controllers.add([TextEditingController(), TextEditingController()]);
      }
    }
    for (var cp in _controllers) {
      cp[0].addListener(() => widget.valuesChanged(_getCurrentValues()));
      cp[1].addListener(() => widget.valuesChanged(_getCurrentValues()));
    }
  }

  @override
  Widget build(BuildContext context) {
    const textFormFieldMargin = 50.0; // TODO move this into globals
    const labelMargin = 20.0; // TODO move this into globals
    const iconDim = 24.0; // TODO move this into globals
    final translations = AppLocalization.of(context);
    final lat = translations.getTranslation("latitude");
    final lon = translations.getTranslation("longitude");
    return BOEditorBlockWidget(
      name: widget.name,
      mandatory: widget.mandatory,
      children: [
        ..._controllers.map(
          (pair) => Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: labelMargin),
                child: Text(lat),
              ),
              Expanded(
                child: TextFormField(
                  controller: pair[0],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: lat),
                  inputFormatters: [DecimalInputFormatter()],
                ),
              ),
              const SizedBox(width: textFormFieldMargin),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: labelMargin),
                child: Text(lon),
              ),
              Expanded(
                child: TextFormField(
                  controller: pair[1],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: lon),
                  inputFormatters: [DecimalInputFormatter()],
                ),
              ),
              if (_controllers.indexOf(pair) >= eventMinCoordinatesNb)
                IconButton(
                    onPressed: () =>
                        _deleteCoordinate(_controllers.indexOf(pair)),
                    icon: const Icon(CupertinoIcons.delete, size: iconDim))
              else
                const SizedBox(width: textFormFieldMargin)
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
                  size: 24.0,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

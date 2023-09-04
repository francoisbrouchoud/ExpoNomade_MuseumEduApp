import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/util/underlined_container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:latlong2/latlong.dart';

/// Class LatLngSelectorWidget is used to display a list of TextFormFields to input at least three latitudes and longitudes.
class LatLngSelectorWidget extends StatefulWidget {
  final String name;
  final List<LatLng>? values;
  final Function(List<LatLng>) valuesChanged;

  /// Creates a new LatLngSelectorWidget
  const LatLngSelectorWidget(
      {super.key,
      required this.name,
      required this.valuesChanged,
      this.values});

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
    if (_controllers.length < 3) {
      for (var i = _controllers.length; i < 3; i++) {
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
    const textFormFieldMargin = 50.0;
    const labelMargin = 20.0;
    const iconDim = 24.0;
    const containerMargin = 15.0;
    final translations = AppLocalization.of(context);
    final lat = translations.getTranslation("latitude");
    final lon = translations.getTranslation("longitude");
    return UnderlinedContainerWidget(
      content: Column(
        children: [
          const SizedBox(height: containerMargin),
          Row(
            children: [
              Text(widget.name),
            ],
          ),
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
                  ),
                ),
                if (_controllers.indexOf(pair) >= 3)
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
          const SizedBox(height: containerMargin),
        ],
      ),
    );
  }
}

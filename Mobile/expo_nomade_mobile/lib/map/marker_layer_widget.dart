import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// This class is the layer that allows us to manage the markers on the map.
class MarkerLayerWidget extends StatelessWidget {
  final Function(String) onMarkerTap;
  const MarkerLayerWidget({Key? key, required this.onMarkerTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      // TODO loop here to create all necessary markers
      markers: [
        Marker(
          point: LatLng(46.22809, 7.35886),
          width: 80,
          height: 80,

          /// The builder let us choose if we want the marker to be clickable, in this case yes, with the onTap function that triggers any other methods we want.
          /// and what image we want the marker to be, in this case, a marker logo.
          builder: (ctx) => GestureDetector(
            onTap: _onMarkerTap,
            child: Image.asset('assets/images/marker.png'),
          ),
        ),
      ],
    );
  }

  /// Performed action when marke is clicked.
  void _onMarkerTap() {
    onMarkerTap("marker1");
  }
}

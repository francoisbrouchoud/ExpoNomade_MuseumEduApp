import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// This class is the layer that allows us to manage the markers on the map.
class MarkerLayerWidget extends StatelessWidget {
  const MarkerLayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          point: LatLng(46.22809, 7.35886),
          width: 80,
          height: 80,

          /// The builder let us choose if we want the marker to be clickable, in this case yes, with the onTap function that triggers any other methods we want.
          /// and what image we want the marker to be, in this case, the basic flutter logo.
          builder: (ctx) => GestureDetector(
            onTap: _onMarkerTap,
            child: const FlutterLogo(),
          ),
        ),
      ],
    );
  }

  void _onMarkerTap() {
    // Performed action when marke is clicked.
    print('Marqueur cliqué ! (from widget)');
  }
}

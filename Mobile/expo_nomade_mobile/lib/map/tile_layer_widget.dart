import 'package:expo_nomade_mobile/helper/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';

/// This class is the layer that render the tiles into a map on our application,
class TileLayerWidget extends StatelessWidget {
  const TileLayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: GlobalConstants.mapStyleUrl,
      maxZoom: GlobalConstants.mapMaxZoom,
      maxNativeZoom: GlobalConstants.mapMaxZoom.toInt(),
    );
  }
}

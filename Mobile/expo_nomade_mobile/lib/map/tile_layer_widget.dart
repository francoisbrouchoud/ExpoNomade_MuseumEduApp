import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';

/// The styleUrl is the template we use to render the map on our application.
/// In this case, we are using the MapBox providers that allows us to fully custom and use a template.
/// This url already contains the token of the account but others links may require a separate const for the token.
const styleUrl =
    "https://api.mapbox.com/styles/v1/laumey/clk7147pb009801nw2y750jx5/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoibGF1bWV5IiwiYSI6ImNsazcxbWRiZDA1a2kzdHA2OTFzd2JkdmYifQ.8xOnsXZQ7GZprIYer0llfw";

// If the previous styleUrl isn't working any more (because we are using a free subscription plan to MapBox), use the following styleUrl.
// const styleUrl = "https://tile.openstreetmap.org/{z}/{x}/{y}.png";

/// This class is the layer that render the tiles into a map on our application,
class TileLayerWidget extends StatelessWidget {
  const TileLayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: styleUrl,
      maxZoom: 20,
      maxNativeZoom: 20,
    );
  }
}

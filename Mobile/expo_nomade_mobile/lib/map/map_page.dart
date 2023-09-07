import 'package:expo_nomade_mobile/bo/expo_object.dart';
import 'package:expo_nomade_mobile/map/info_panel.dart';
import 'package:expo_nomade_mobile/map/marker_layer_widget.dart';
import 'package:expo_nomade_mobile/map/polygon_layer_widget.dart';
import 'package:expo_nomade_mobile/map/tile_layer_widget.dart';
import 'package:expo_nomade_mobile/map/filter_popup.dart';
import 'package:expo_nomade_mobile/map/filter_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../app_localization.dart';
import '../bo/expo_event.dart';
import '../bo/exposition.dart';

/// Class MapPage is used to display the map and the information related to the exposition.
class MapPage extends StatefulWidget {
  const MapPage({Key? key, required this.exposition}) : super(key: key);

  final Exposition exposition;

  @override
  _MapPageState createState() => _MapPageState();
}

/// Class _MapPageState is the state class for the MapPage class, used to manage the behavior on click of the markers.
class _MapPageState extends State<MapPage> {
  bool isLargeScreen = false;
  ExpoObject? selectedObject;
  bool showFilter = false;
  double startYearFilter = 1700;
  double endYearFilter = 2020;
  List<ExpoEvent> filteredEvents = [];
  Map<ExpoObject, int> filteredObjects = {};
  Set<String> selectedReasons = {};


  @override
  void initState() {
    super.initState();

    // Collecte de toutes les raisons uniques et initialisation de selectedReasons
    for (var event in widget.exposition.events) {
      selectedReasons.add(event.reason['fr']);
    }

    filteredEvents = filterEvents(
        widget.exposition.events, startYearFilter, endYearFilter, selectedReasons);
    filteredObjects = filterObjectsByYear(
        widget.exposition.objects, startYearFilter, endYearFilter);
  }

  void filterRangeChanged(double start, double end) {
    setState(() {
      startYearFilter = start;
      endYearFilter = end;

      // Filter Events and Objects
      filteredEvents = filterEvents(
          widget.exposition.events, startYearFilter, endYearFilter, selectedReasons);
      filteredObjects = filterObjectsByYear(
          widget.exposition.objects, startYearFilter, endYearFilter);
    });
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final langCode = translations.getCurrentLangCode();
    isLargeScreen = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Flex(
              direction: isLargeScreen ? Axis.horizontal : Axis.vertical,
              children: [
                Flexible(
                  flex: 1,
                  child: FlutterMap(
                    /// The map options define the "spawning" coordinates of the map when we load it and the default zoom to show only a specific area of the world map.
                    /// The latitude and the longitude we use here are the coordinates of Sion, capital city of the State Valais.
                    options: MapOptions(
                      center: const LatLng(46.22809, 7.35886),
                      zoom: 10,
                    ),
                    children: [
                      /// Both the tile layer and the marker layer have their own class to prevent messy code.
                      /// They are in charge of rendering the map and adding any markers on it.
                      TileLayerWidget(),
                      PolygonLayerWidget(),
                      MarkerLayerWidget(
                        onMarkerTap: (ExpoObject object) {
                          setState(() {
                            selectedObject = object;
                          });
                        },
                        expoObjects: filteredObjects,
                      ),
                    ],
                  ),
                ),
                if (selectedObject != null)
                  Flexible(
                    flex: 1,
                    child: InfoPanel(
                        object: selectedObject!,
                        onClose: () {
                          setState(() {
                            selectedObject = null;
                          });
                        }),
                  ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  showFilter = !showFilter;
                });
              },
              child: Icon(Icons.filter_list),
            ),
          ),
          if (showFilter)
            Positioned(
              top: 80,
              left: 16,
              child: Container (
                height: 300,
                width: 300,
                child: FilterPopup(
                  onRangeChanged: filterRangeChanged,
                  startYearFilter: startYearFilter,
                  endYearFilter: endYearFilter, 
                  selectedReasons: selectedReasons,
                ),
              )
              
              
            ),
        ],
      ),
    );
  }
}

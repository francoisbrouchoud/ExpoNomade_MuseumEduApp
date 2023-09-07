import 'package:expo_nomade_mobile/bo/expo_axis.dart';
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

import '../bo/expo_event.dart';
import '../bo/expo_population_type.dart';
import '../bo/exposition.dart';

import 'dart:math' as math;

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
  double startYearFilter = 0.0;
  double endYearFilter = 0.0;
  List<ExpoEvent> filteredEvents = [];
  Map<ExpoObject, int> filteredObjects = {};
  Set<ExpoAxis> selectedReasons = {};
  Set<ExpoAxis> allReasons = {};
  Set<ExpoPopulationType> selectedPopulations = {};
  Set<ExpoPopulationType> allPopulations = {};


  @override
  void initState() {
    super.initState();

    // Get all existing reasons and set them to checked by default
    for (var event in widget.exposition.events) {
      selectedReasons.add(event.axis);
    }
    for (var object in widget.exposition.objects) {
      selectedReasons.add(object.axis);
    }
    //Get all existing population types and set them to checked by default
    for (var event in widget.exposition.events) {
      selectedPopulations.add(event.populationType);
    }
    filteredEvents = filterEvents(
        widget.exposition.events, startYearFilter, endYearFilter, selectedReasons, selectedPopulations);
    filteredObjects = filterObjects(
        widget.exposition.objects, startYearFilter, endYearFilter, selectedReasons);
  }

  void filterChanged(double start, double end, Set<ExpoAxis> reasons, Set<ExpoPopulationType> populations) {
    setState(() {
      startYearFilter = start;
      endYearFilter = end;
      selectedReasons = reasons;
      selectedPopulations = populations;

      // Filter Events and Objects
      filteredEvents = filterEvents(
          widget.exposition.events, startYearFilter, endYearFilter, selectedReasons, selectedPopulations);
      filteredObjects = filterObjects(
          widget.exposition.objects, startYearFilter, endYearFilter, selectedReasons);
    });
  }

  @override
  Widget build(BuildContext context) {
    isLargeScreen = MediaQuery.of(context).size.width >= 600;

    // Find the minimal year value in all the objects
    int minObjectYear = widget.exposition.objects
        .expand((obj) => obj.coordinates.keys)
        .reduce(math.min);

    // Find the minimal year value in all the events
    int minEventYear = widget.exposition.events
        .map((event) => event.startYear)
        .reduce(math.min);

    // Set the minimal year value as minimal year for my slider range settings
    startYearFilter = math.min(minObjectYear, minEventYear).toDouble();
    // Set current year as maximal year for my slider range settings
    endYearFilter = DateTime.now().year.toDouble();

    // Get all existing reasons
    for (var event in widget.exposition.events) {
      allReasons.add(event.axis);
    }
    for (var object in widget.exposition.objects) {
      allReasons.add(object.axis);
    }
    //Get all existing population types
    for (var event in widget.exposition.events) {
      allPopulations.add(event.populationType);
    }

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
                      PolygonLayerWidget(expoEvents: filteredEvents),
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
                height: 500,
                width: 300,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 9,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: FilterPopup(
                  onFilterChanged: filterChanged,
                  startYearFilter: startYearFilter,
                  endYearFilter: endYearFilter, 
                  selectedReasons: selectedReasons,
                  allReasons: allReasons,
                  selectedPopulations: selectedPopulations,
                  allPopulations: allPopulations
                ),
              )
              
              
            ),
        ],
      ),
    );
  }
}

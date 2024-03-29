import 'dart:collection';

import 'package:expo_nomade_mobile/bo/expo_axis.dart';
import 'package:expo_nomade_mobile/bo/expo_event.dart';
import 'package:expo_nomade_mobile/bo/expo_object.dart';
import 'package:expo_nomade_mobile/bo/expo_population_type.dart';
import 'package:expo_nomade_mobile/bo/base_business_object.dart';
import 'package:expo_nomade_mobile/helper/multilingual_string.dart';

import 'museum.dart';
import 'quiz_question.dart';

/// Class Exposition is used to store all details related to an exposition.
class Exposition extends BaseBusinessObject {
  MultilingualString name;
  Map<String, ExpoAxis> axes;
  Map<String, ExpoPopulationType> populationTypes;
  List<ExpoEvent> events;
  List<ExpoObject> objects;
  Quiz quiz;

  /// Exposition complete constructor.
  Exposition(super.id, this.name, this.axes, this.events, this.objects,
      this.populationTypes, this.quiz);

  /// Convert json into the business object Exposition.
  factory Exposition.fromJson(
      String id, dynamic json, Map<String, Museum> museums) {
    MultilingualString name =
        MultilingualString(Map<String, String>.from(json['name']));
    Map<String, ExpoAxis> axes = HashMap();
    if (json.containsKey("axes")) {
      for (var axis in Map<String, dynamic>.from(json['axes']).entries) {
        axes[axis.key] = ExpoAxis.fromJson(axis.key, axis.value);
      }
    }
    Map<String, ExpoPopulationType> popTypes = HashMap();
    if (json.containsKey("populationTypes")) {
      for (var popType
          in Map<String, dynamic>.from(json['populationTypes']).entries) {
        popTypes[popType.key] =
            ExpoPopulationType.fromJson(popType.key, popType.value);
      }
    }
    List<ExpoEvent> events = [];
    if (json.containsKey("event")) {
      for (var event in Map<String, dynamic>.from(json['event']).entries) {
        events.add(ExpoEvent.fromJson(event.key, event.value, axes, popTypes));
      }
    }
    List<ExpoObject> objects = [];
    if (json.containsKey("object")) {
      for (var object in Map.from(json['object']).entries) {
        objects
            .add(ExpoObject.fromJson(object.key, object.value, axes, museums));
      }
    }
    Quiz quiz = Quiz(questions: [], participations: []);
    if (json.containsKey("quiz")) {
      quiz = Quiz.fromJson(json['quiz']);
    }

    return Exposition(id, name, axes, events, objects, popTypes, quiz);
  }

  @override
  String toListText(String langCode) {
    return name[langCode];
  }
}

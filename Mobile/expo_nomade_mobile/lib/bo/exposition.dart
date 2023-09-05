import 'dart:collection';

import 'package:expo_nomade_mobile/bo/expo_axis.dart';
import 'package:expo_nomade_mobile/bo/expo_event.dart';
import 'package:expo_nomade_mobile/bo/expo_object.dart';
import 'package:expo_nomade_mobile/bo/expo_population_type.dart';
import 'package:expo_nomade_mobile/bo/paticipation.dart';
import 'package:expo_nomade_mobile/util/base_business_object.dart';
import 'package:expo_nomade_mobile/util/multilingual_string.dart';

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
  List<Participation> participations;

  /// Exposition complete constructor.
  Exposition(this.name, this.axes, this.events, this.objects,
      this.populationTypes, this.quiz, this.participations);

  /// Convert json into the business object Exposition.
  factory Exposition.fromJson(dynamic json, Map<String, Museum> museums) {
    MultilingualString name =
        MultilingualString(Map<String, String>.from(json['name']));
    Map<String, ExpoAxis> axes = HashMap();
    for (var axis in Map<String, dynamic>.from(json['axes']).entries) {
      axes[axis.key] = ExpoAxis.fromJson(axis.key, axis.value);
    }
    Map<String, ExpoPopulationType> popTypes = HashMap();
    for (var popType
        in Map<String, dynamic>.from(json['populationTypes']).entries) {
      popTypes[popType.key] =
          ExpoPopulationType.fromJson(popType.key, popType.value);
    }
    List<ExpoEvent> events = [];
    for (var event in Map<String, dynamic>.from(json['event']).entries) {
      events.add(ExpoEvent.fromJson(event.key, event.value, axes, popTypes));
    }
    List<ExpoObject> objects = List<dynamic>.from(json['object'])
        .map((o) => ExpoObject.fromJson(o, axes, museums))
        .toList();
    Quiz quiz = Quiz.fromJson(json['quiz']);

    List<Participation> participations = [];

    for (var participation
        in Map<String, dynamic>.from(json['quizParticipations']).entries) {
      participations
          .add(Participation.fromJson(participation.key, participation.value));
    }

    return Exposition(
        name, axes, events, objects, popTypes, quiz, participations);
  }

  @override
  String toListText(String langCode) {
    return name[langCode];
  }
}

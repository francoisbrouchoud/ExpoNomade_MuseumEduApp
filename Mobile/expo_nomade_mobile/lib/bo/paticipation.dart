import 'dart:convert';
import 'dart:ui';
import 'package:expo_nomade_mobile/util/base_business_object.dart';
import 'package:expo_nomade_mobile/util/multilingual_string.dart';

/// Class contain all questions
class Participation extends BaseBusinessObject {
  String id;
  String email;
  int score;

  Participation({required this.id, required this.email, required this.score});

  /// Convert a json into the buisness object quiz class
  factory Participation.fromJson(String id, dynamic json) {
    return Participation(
      id: id,
      email: json['email'],
      score: json['score'],
    );
  }

  @override
  String toListText(String langCode) {
    return "Email " + email + " " + score.toString() + " points";
  }
}

import 'package:expo_nomade_mobile/util/base_business_object.dart';

/// Class contain all questions
class Participation extends BaseBusinessObject {
  String id;
  String email;
  int score;

  Participation(this.id, this.email, this.score);

  /// Convert a json into the buisness object quiz class
  factory Participation.fromJson(id, participation) {
    return Participation(
      id,
      participation['email'],
      participation['score'],
    );
  }

  @override
  String toListText(String langCode) {
    return "$email $score";
  }
}

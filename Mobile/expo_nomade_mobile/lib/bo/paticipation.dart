import 'package:expo_nomade_mobile/bo/base_business_object.dart';

/// Class contain all questions
class Participation extends BaseBusinessObject {
  String email;
  int score;

  Participation(super.id, this.email, this.score);

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

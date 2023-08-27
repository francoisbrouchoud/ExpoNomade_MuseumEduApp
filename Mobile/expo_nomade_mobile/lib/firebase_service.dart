import 'package:expo_nomade_mobile/bo/exposition.dart';
import 'package:expo_nomade_mobile/bo/museum.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

// documentation : https://firebase.flutter.dev/docs/database/read-and-write
class FirebaseService {
  static final firebaseApp = Firebase.app();
  static FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL:
          'https://exponomade-42671-default-rtdb.europe-west1.firebasedatabase.app');

  /// Gets the list of all museums.
  static Future<Map<String, Museum>?> getMuseums() async {
    DatabaseReference ref = database.ref();
    final mus = await ref.child("museum").get();
    if (mus.exists) {
      return Map.from(mus.value as Map)
          .map((key, value) => MapEntry(key, Museum.fromJson(value)));
    }
    return null;
  }

  /// Gets the current complete exposition.
  static Future<Exposition?> getCurrentExposition() async {
    DatabaseReference ref = database.ref();
    final currentExpo = await ref.child("currentExposition").get();
    if (currentExpo.exists) {
      Map<String, Museum>? museums = await getMuseums();
      final expo = await ref.child("expositions/${currentExpo.value}").get();
      if (expo.exists && museums != null) {
        return Exposition.fromJson(expo.value, museums);
      }
    }
    return null;
  }
}

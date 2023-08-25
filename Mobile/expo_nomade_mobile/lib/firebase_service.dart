import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

// documentation : https://firebase.flutter.dev/docs/database/read-and-write
class FirebaseService {
  static final firebaseApp = Firebase.app();
  static FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL:
          'https://exponomade-42671-default-rtdb.europe-west1.firebasedatabase.app');

  static Future<String> getExpositionName(String lang) async {
    DatabaseReference ref = database.ref();
    final snapshot = await ref.child("expositions/0/name/$lang").get();
    if (snapshot.exists) {
      return snapshot.value.toString();
    } else {
      return "";
    }
  }
}

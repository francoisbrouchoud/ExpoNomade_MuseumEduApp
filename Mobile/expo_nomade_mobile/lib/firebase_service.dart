import 'package:firebase_database/firebase_database.dart';

// documentation : https://firebase.flutter.dev/docs/database/read-and-write
class FirebaseService {
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static getExpositionName(action) {
    DatabaseReference ref = database.ref();
    ref.child("expositions/0/name").get().then((snapshot) => {
          if (snapshot.exists)
            {action(snapshot.value)}
          else
            {print('No data available.')}
        });
  }
}

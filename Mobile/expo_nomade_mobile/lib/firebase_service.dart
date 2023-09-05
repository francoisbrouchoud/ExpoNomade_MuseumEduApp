import 'dart:typed_data';

import 'package:expo_nomade_mobile/bo/expo_axis.dart';
import 'package:expo_nomade_mobile/bo/expo_event.dart';
import 'package:expo_nomade_mobile/bo/expo_population_type.dart';
import 'package:expo_nomade_mobile/bo/exposition.dart';
import 'package:expo_nomade_mobile/bo/museum.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  /// Uploads an image to firebase storage. Returns the download URL.
  static Future<String> uploadImage(
      Uint8List imageBytes, String imageName) async {
    final DateTime now = DateTime.now();
    final String formattedDate =
        "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}${now.millisecond.toString().padLeft(3, '0')}";
    final String type = imageName.split('.').last;
    final String filename = "$formattedDate.$type";
    final Reference imageRef =
        FirebaseStorage.instance.ref().child("images").child(filename);
    UploadTask task = imageRef.putData(
        imageBytes, SettableMetadata(contentType: 'image/$type'));
    await task.whenComplete(() => null);
    return await imageRef.getDownloadURL();
  }

  static Future<void> submitScore(String email, double score) async {
    DatabaseReference ref = database.ref();
    final currentExpo = await ref.child("currentExposition").get();
    if (currentExpo.exists) {
      // get timestamp
      DateTime now = DateTime.now();

      // format timestamp
      String formattedDate =
          "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}${now.millisecond.toString().padLeft(3, '0')}";

      await ref
          .child(
              'expositions/${currentExpo.value}/quizParticipations/$formattedDate')
          .set({'email': email, 'score': score});
    }
  }

  /// Creates an ExpoAxis business object.
  static Future<ExpoAxis?> createAxis(ExpoAxis axis) async {
    DatabaseReference ref = database.ref();
    final currentExpo = await ref.child("currentExposition").get();
    if (currentExpo.exists) {
      DatabaseReference newAxisRef =
          ref.child("expositions/${currentExpo.value}/axes").push();
      if (newAxisRef.key != null) {
        await newAxisRef.set({
          "description": axis.description.toMap(),
          "title": axis.title.toMap()
        });
        return ExpoAxis(newAxisRef.key!, axis.description, axis.title);
      }
    }
    return null;
  }

  /// Creates an ExpoPopulationType business object.
  static Future<ExpoPopulationType?> createPopulationType(
      ExpoPopulationType populationType) async {
    DatabaseReference ref = database.ref();
    final currentExpo = await ref.child("currentExposition").get();
    if (currentExpo.exists) {
      DatabaseReference newPopTypeRef =
          ref.child("expositions/${currentExpo.value}/populationTypes").push();
      if (newPopTypeRef.key != null) {
        await newPopTypeRef.set({"title": populationType.title.toMap()});
        return ExpoPopulationType(newPopTypeRef.key!, populationType.title);
      }
    }
    return null;
  }

  /// Creates an ExpoEvent business object.
  static Future<ExpoEvent?> createEvent(ExpoEvent event) async {
    DatabaseReference ref = database.ref();
    final currentExpo = await ref.child("currentExposition").get();
    if (currentExpo.exists) {
      DatabaseReference newEventRef =
          ref.child("expositions/${currentExpo.value}/event").push();
      if (newEventRef.key != null) {
        await newEventRef.set({
          "title": event.title.toMap(),
          "description": event.description.toMap(),
          "reason": event.reason.toMap(),
          "axe": event.axis.id,
          "populationType": event.populationType.id,
          "startYear": event.startYear,
          "endYear": event.endYear,
          "from": event.from.map((latlng) {
            return {
              "lat": latlng.latitude,
              "lon": latlng.longitude,
            };
          }).toList(),
          "to": event.to.map((latlng) {
            return {
              "lat": latlng.latitude,
              "lon": latlng.longitude,
            };
          }).toList(),
          "picture": event.pictureURL,
        });
        return ExpoEvent(
            newEventRef.key!,
            event.axis,
            event.description,
            event.endYear,
            event.from,
            event.pictureURL,
            event.populationType,
            event.reason,
            event.startYear,
            event.title,
            event.to);
      }
    }
    return null;
  }

  /// Updates an ExpoAxis business object.
  static Future<void> updateAxis(ExpoAxis axis) async {
    DatabaseReference ref = database.ref();
    final currentExpo = await ref.child("currentExposition").get();
    if (currentExpo.exists) {
      await ref.child("expositions/${currentExpo.value}/axes/${axis.id}").set({
        "description": axis.description.toMap(),
        "title": axis.title.toMap()
      });
    }
  }

  /// Updates an ExpoPopulationType business object.
  static Future<void> updatePopulationType(
      ExpoPopulationType populationType) async {
    DatabaseReference ref = database.ref();
    final currentExpo = await ref.child("currentExposition").get();
    if (currentExpo.exists) {
      await ref
          .child(
              "expositions/${currentExpo.value}/populationTypes/${populationType.id}")
          .set({"title": populationType.title.toMap()});
    }
  }

  /// Updates an ExpoEvent business object.
  static Future<void> updateEvent(ExpoEvent event) async {
    DatabaseReference ref = database.ref();
    final currentExpo = await ref.child("currentExposition").get();
    if (currentExpo.exists) {
      await ref
          .child("expositions/${currentExpo.value}/event/${event.id}")
          .set({
        "title": event.title.toMap(),
        "description": event.description.toMap(),
        "reason": event.reason.toMap(),
        "axe": event.axis.id,
        "populationType": event.populationType.id,
        "startYear": event.startYear,
        "endYear": event.endYear,
        "from": event.from.map((latlng) {
          return {
            "lat": latlng.latitude,
            "lon": latlng.longitude,
          };
        }).toList(),
        "to": event.to.map((latlng) {
          return {
            "lat": latlng.latitude,
            "lon": latlng.longitude,
          };
        }).toList(),
        "picture": event.pictureURL,
      });
    }
  }

  /// Deletes an ExpoAxis business object.
  static Future<void> deleteAxis(ExpoAxis axis) async {
    DatabaseReference ref = database.ref();
    final currentExpo = await ref.child("currentExposition").get();
    if (currentExpo.exists) {
      await ref
          .child("expositions/${currentExpo.value}/axes/${axis.id}")
          .remove();
    }
  }

  /// Deletes an ExpoPopulationType business object.
  static Future<void> deletePopulationType(
      ExpoPopulationType populationType) async {
    DatabaseReference ref = database.ref();
    final currentExpo = await ref.child("currentExposition").get();
    if (currentExpo.exists) {
      await ref
          .child(
              "expositions/${currentExpo.value}/populationTypes/${populationType.id}")
          .remove();
    }
  }

  /// Deletes an ExpoEvent business object.
  static Future<void> deleteEvent(ExpoEvent event) async {
    DatabaseReference ref = database.ref();
    final currentExpo = await ref.child("currentExposition").get();
    if (currentExpo.exists) {
      await ref
          .child("expositions/${currentExpo.value}/event/${event.id}")
          .remove();
    }
  }
}

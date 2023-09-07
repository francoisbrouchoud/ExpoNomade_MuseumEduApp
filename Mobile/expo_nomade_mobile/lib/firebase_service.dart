import 'dart:io';
import 'dart:typed_data';

import 'package:expo_nomade_mobile/bo/expo_axis.dart';
import 'package:expo_nomade_mobile/bo/expo_event.dart';
import 'package:expo_nomade_mobile/bo/expo_name.dart';
import 'package:expo_nomade_mobile/bo/expo_object.dart';
import 'package:expo_nomade_mobile/bo/expo_population_type.dart';
import 'package:expo_nomade_mobile/bo/exposition.dart';
import 'package:expo_nomade_mobile/bo/museum.dart';
import 'package:expo_nomade_mobile/bo/paticipation.dart';
import 'package:expo_nomade_mobile/bo/quiz_question.dart';
import 'package:expo_nomade_mobile/util/globals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

// TODO are we going to keep this here??
// -> documentation : https://firebase.flutter.dev/docs/database/read-and-write
/// Class FirebaseService provides every method needed by the application to communicate with Firebase.
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

  /// Gets the list of all museums.
  static Future<Map<String, ExpoName>?> getAllExpoNames() async {
    DatabaseReference ref = database.ref();
    final expo = await ref.child("expositions").get();
    if (expo.exists) {
      return Map.from(expo.value as Map)
          .map((key, value) => MapEntry(key, ExpoName.fromJson(key, value)));
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
        return Exposition.fromJson(
            currentExpo.value.toString(), expo.value, museums);
      }
    }
    return null;
  }

// set the news current exposition
  static setCurrentExposition(String id) async {
    DatabaseReference ref = database.ref();
    await ref.update({'currentExposition': id});
  }

  /// Uploads an image to firebase storage. Returns the download URL.
  static Future<String> uploadImage(
      Uint8List imageBytes, String imageExtension) async {
    final String filename =
        "${GlobalConstants.getNowFormattedForDB()}.$imageExtension";
    final Reference imageRef =
        FirebaseStorage.instance.ref().child("images").child(filename);
    UploadTask task = imageRef.putData(
        imageBytes, SettableMetadata(contentType: 'image/$imageExtension'));
    await task.whenComplete(() => null);
    return await imageRef.getDownloadURL();
  }

  static Future<String> uploadImageFile(
      File file, String imageExtension) async {
    final String filename =
        "${GlobalConstants.getNowFormattedForDB()}.$imageExtension";
    final Reference imageRef =
        FirebaseStorage.instance.ref().child("images").child(filename);
    UploadTask task = imageRef.putFile(
        file, SettableMetadata(contentType: 'image/$imageExtension'));
    await task.whenComplete(() => null);
    return await imageRef.getDownloadURL();
  }

  /// Adds a new score entry in the database.
  static Future<Participation?> submitScore(String email, int score) async {
    DatabaseReference ref = database.ref();
    final currentExpo = await ref.child("currentExposition").get();
    if (currentExpo.exists) {
      String dateTimeNow = GlobalConstants.getNowFormattedForDB();

      await ref
          .child(
              'expositions/${currentExpo.value}/quiz/participation/$dateTimeNow')
          .set({'email': email, 'score': score});

      return Participation(dateTimeNow, email, score);
    }

    return null;
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

  /// Creates a QuizQuestion business object.
  static Future<QuizQuestion?> createQuizQuestion(
      QuizQuestion quizQuestion) async {
    DatabaseReference ref = database.ref();
    final currentExpo = await ref.child("currentExposition").get();
    if (currentExpo.exists) {
      DatabaseReference newQuestionRef =
          ref.child("expositions/${currentExpo.value}/quiz/questions").push();
      if (newQuestionRef.key != null) {
        await newQuestionRef.set({
          "question": quizQuestion.question.toMap(),
          "options": quizQuestion.options.map((quizOption) {
            return {
              "isCorrect": quizOption.isCorrect ? 1 : 0,
              "optionText": quizOption.label.toMap(),
            };
          }).toList()
        });
        return QuizQuestion(
            quizQuestion.id, quizQuestion.question, quizQuestion.options);
      }
    }
    return null;
  }

  /// Creates a ExpoObject business object.
  static Future<ExpoObject?> createObject(ExpoObject object) async {
    // TODO complete method
  }

  /// Updates a QuizQuestion business object.
  static Future<void> updateQuizQuestion(QuizQuestion quizQuestion) async {
    DatabaseReference ref = database.ref();
    final currentExpo = await ref.child("currentExposition").get();
    if (currentExpo.exists) {
      await ref
          .child(
              "expositions/${currentExpo.value}/quiz/questions/${quizQuestion.id}")
          .set({
        "question": quizQuestion.question.toMap(),
        "options": quizQuestion.options.map((quizOption) {
          return {
            "isCorrect": quizOption.isCorrect ? 1 : 0,
            "optionText": quizOption.label.toMap(),
          };
        }).toList(),
      });
    }
  }

  /// Updates an ExpoObject business object.
  static Future<void> updateObject(ExpoObject object) async {
    // TODO complete method
  }

  /// Delete a QuizQuestion business object.
  static Future<void> deleteQuizQuestion(QuizQuestion quizQuestion) async {
    DatabaseReference ref = database.ref();
    final currentExpo = await ref.child("currentExposition").get();
    if (currentExpo.exists) {
      await ref
          .child(
              "expositions/${currentExpo.value}/quiz/questions/${quizQuestion.id}")
          .remove();
    }
  }

  /// Deletes an ExpoObject business object.
  static Future<void> deleteObject(ExpoObject object) async {
    // TODO complete method
  }

  /// Creates an ExpoEvent business object.
  static Future<ExpoName?> createExposition(ExpoName expo) async {
    DatabaseReference ref = database.ref();
    DatabaseReference newEventRef = ref.child("expositions").push();
    if (newEventRef.key != null) {
      await newEventRef.set({
        "name": expo.name.toMap(),
      });
      return ExpoName(newEventRef.key!, expo.name);
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

  /// Updates an ExpoEvent business object.
  static Future<void> updateExposition(ExpoName expo) async {
    DatabaseReference ref = database.ref();
    await ref.child("expositions/${expo.id}").set({"name": expo.name.toMap()});
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

  /// Deletes an Exposition business object.
  static Future<void> deleteExposition(ExpoName expo) async {
    DatabaseReference ref = database.ref();
    await ref.child("expositions/${expo.id}").remove();
  }
}

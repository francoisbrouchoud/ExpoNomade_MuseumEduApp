import 'package:expo_nomade_mobile/bo/base_business_object.dart';
import 'package:expo_nomade_mobile/helper/multilingual_string.dart';

/// Class Museum is used to store all details related to a museum.
class Museum extends BaseBusinessObject {
  String id;
  String address;
  MultilingualString name;

  /// Museum complete constructor.
  Museum(this.id, this.address, this.name);

  /// Convert json into the business object Museum.
  factory Museum.fromJson(String id, dynamic json) {
    return Museum(id, json['address'],
        MultilingualString(Map<String, String>.from(json['name'])));
  }

  @override
  String toListText(String langCode) {
    return name[langCode];
  }
}

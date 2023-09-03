import 'package:expo_nomade_mobile/util/base_business_object.dart';
import 'package:expo_nomade_mobile/util/multilingual_string.dart';

/// Class Museum is used to store all details related to a museum.
class Museum extends BaseBusinessObject {
  String address;
  MultilingualString name;

  /// Museum complete constructor.
  Museum(this.address, this.name);

  /// Convert json into the business object Museum.
  factory Museum.fromJson(dynamic json) {
    return Museum(json['address'],
        MultilingualString(Map<String, String>.from(json['name'])));
  }

  @override
  String toListText(String langCode) {
    return name[langCode];
  }
}

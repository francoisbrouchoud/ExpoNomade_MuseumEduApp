/// Class Museum is used to store all details related to a museum.
class Museum {
  String address;
  Map<String, String> name;

  /// Museum complete constructor.
  Museum(this.address, this.name);

  /// Convert json into the business object Museum.
  factory Museum.fromJson(dynamic json) {
    return Museum(json['address'], Map<String, String>.from(json['name']));
  }
}

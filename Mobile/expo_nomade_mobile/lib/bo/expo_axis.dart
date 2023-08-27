/// Class ExpoAxis is used to store all details related to one axis of an exposition.
class ExpoAxis {
  Map<String, String> description;
  Map<String, String> title;

  /// ExpoAxis complete constructor.
  ExpoAxis(this.description, this.title);

  /// Convert json into the business object ExpoAxis.
  factory ExpoAxis.fromJson(dynamic json) {
    Map<String, String> description =
        Map<String, String>.from(json['description']);
    Map<String, String> title = Map<String, String>.from(json['title']);
    return ExpoAxis(description, title);
  }
}

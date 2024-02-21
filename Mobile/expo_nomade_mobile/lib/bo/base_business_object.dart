/// Abstract class BaseBusinessObject must be implemented in each object that can be listed with the help of BaseBOListWidget and modified with the help of BaseBOEditorWidget.
abstract class BaseBusinessObject {
  /// Force any business object to have an id.
  String id;

  /// Gets the object name in the provided langCode.
  String toListText(String langCode);

  BaseBusinessObject(this.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseBusinessObject &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

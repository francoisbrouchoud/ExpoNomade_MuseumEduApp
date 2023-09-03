/// Abstract class BaseBusinessObject must be implemented in each object that can be listed with the help of BaseBOListWidget and modified with the help of BaseBOEditorWidget.
abstract class BaseBusinessObject {
  /// Gets the object name in the provided langCode.
  String toListText(String langCode);
}

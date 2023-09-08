import 'package:expo_nomade_mobile/helper/app_localization.dart';
import 'package:expo_nomade_mobile/helper/globals.dart';
import 'package:expo_nomade_mobile/util/underlined_container_widget.dart';
import 'package:flutter/material.dart';

/// Class BOEditorBlockWidget is used to contain a block of widget(s) to be displayed in a business object editor.
class BOEditorBlockWidget extends StatelessWidget {
  final String name;
  final List<Row> children;
  final bool mandatory;

  /// Creates a new BOEditorBlockWidget
  const BOEditorBlockWidget(
      {super.key,
      required this.name,
      required this.children,
      this.mandatory = false});

  @override
  Widget build(BuildContext context) {
    const blockMargin =
        SizedBox(height: GlobalConstants.blockTopBottomMarginHeight);
    return UnderlinedContainerWidget(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          blockMargin,
          Row(
            children: [
              Text(mandatory
                  ? "$name (${AppLocalization.of(context).getTranslation("required")})"
                  : name),
            ],
          ),
          ...children,
          blockMargin,
        ],
      ),
    );
  }
}

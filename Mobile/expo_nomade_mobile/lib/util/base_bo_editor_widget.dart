import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/util/base_business_object.dart';
import 'package:expo_nomade_mobile/util/container_admin_widget.dart';
import 'package:expo_nomade_mobile/util/simple_snack_bar.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';

/// Class BaseBOEditorWidget is used as base for any business object editor widget.
class BaseBOEditorWidget extends StatelessWidget {
  final String title;
  final List<Widget> content;
  final VoidCallback itemSaveRequested;
  final VoidCallback itemDeleteRequested;
  final BaseBusinessObject? object;
  final bool hasDependencies;

  /// Creates a new BaseBOEditorWidget, must be used within a business object editor.
  const BaseBOEditorWidget(
      {super.key,
      required this.title,
      required this.content,
      required this.itemSaveRequested,
      required this.itemDeleteRequested,
      this.object,
      this.hasDependencies = false});

  /// Handles the click on the delete button: shows a confirmation dialog.
  void itemDeleteClicked(BuildContext context, AppLocalization translations) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translations.getTranslation("warning")),
          content: Text(translations.getTranslation("delete_confirm_msg")),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(translations.getTranslation("cancel")),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                SimpleSnackBar.showSnackBar(
                    context, translations.getTranslation("deleted"));
                itemDeleteRequested();
              },
              child: Text(translations.getTranslation("confirm")),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const btnMargin = 10.0;
    final translations = AppLocalization.of(context);
    return ContainerAdminWidget(
      fixedContainerHeight: true,
      title: title,
      body: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: content,
              ),
            ),
            ButtonWidget(
              action: () {
                SimpleSnackBar.showSnackBar(
                    context, translations.getTranslation("saved"));
                itemSaveRequested();
              },
              text: translations.getTranslation("save"),
              type: ButtonWidgetType.standard,
            ),
            if (object != null && !hasDependencies)
              const SizedBox(height: btnMargin),
            if (object != null && !hasDependencies)
              ButtonWidget(
                action: () => itemDeleteClicked(context, translations),
                text: translations.getTranslation("delete"),
                type: ButtonWidgetType.delete,
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:expo_nomade_mobile/helper/app_localization.dart';
import 'package:expo_nomade_mobile/bo/base_business_object.dart';
import 'package:expo_nomade_mobile/helper/globals.dart';
import 'package:expo_nomade_mobile/widgets/underlined_container_widget.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';
import 'container_admin_widget.dart';

/// Abstract class BaseBOListWidget is a widget used to list a collection of business objects.
abstract class BaseBOListWidget extends StatelessWidget {
  final String title;
  final List<BaseBusinessObject> listableItems;
  final Function(BaseBusinessObject) itemTap;
  final VoidCallback itemAddRequested;
  final String addButtonText;

  /// Creates a new BaseBOListWidget, must be called from a class inheriting from this one.
  const BaseBOListWidget(
      {super.key,
      required this.title,
      required this.listableItems,
      required this.itemTap,
      required this.itemAddRequested,
      required this.addButtonText});

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    return ContainerAdminWidget(
      fixedContainerHeight: true,
      title: title,
      body: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: listableItems.length,
                itemBuilder: (context, index) {
                  final item = listableItems[index];
                  return UnderlinedContainerWidget(
                    content: ListTile(
                      title: Text(
                        item.toListText(translations.getCurrentLangCode()),
                      ),
                      onTap: () => itemTap(item),
                      trailing: SizedBox(
                        width: GlobalConstants.iconsDefaultDimension,
                        height: GlobalConstants.iconsDefaultDimension,
                        child: Image.asset('assets/images/edit.png'),
                      ),
                    ),
                  );
                },
              ),
            ),
            ButtonWidget(
              action: itemAddRequested,
              text: addButtonText,
              type: ButtonWidgetType.standard,
            ),
          ],
        ),
      ),
    );
  }
}

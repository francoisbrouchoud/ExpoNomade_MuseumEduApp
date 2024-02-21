import 'package:expo_nomade_mobile/bo/museum.dart';
import 'package:expo_nomade_mobile/helper/app_localization.dart';
import 'package:expo_nomade_mobile/helper/firebase_service.dart';
import 'package:expo_nomade_mobile/helper/multilingual_string.dart';
import 'package:expo_nomade_mobile/helper/notifer_helper.dart';
import 'package:expo_nomade_mobile/helper/validation_helper.dart';
import 'package:expo_nomade_mobile/widgets/base_bo_editor_widget.dart';
import 'package:expo_nomade_mobile/widgets/multilingual_string_editor_widget.dart';
import 'package:expo_nomade_mobile/widgets/simple_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Class MuseumEditorWidget is a widget used to edit or create a Museum object.
class MuseumEditorWidget extends StatefulWidget {
  final Museum? museum;

  /// MuseumEditorWidget constructor.
  const MuseumEditorWidget({super.key, this.museum});

  @override
  MuseumEditorWidgetState createState() => MuseumEditorWidgetState();
}

/// State class for the MuseumEditorWidget
class MuseumEditorWidgetState extends State<MuseumEditorWidget> {
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _addressController =
        TextEditingController(text: widget.museum?.address ?? "");
  }

  /// Navigates back to the list view.
  void backToList({String? text}) {
    if (text != null) {
      SimpleSnackBar.showSnackBar(context, text);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final dataProvider = Provider.of<MuseumNotifier>(context);
    Map<String, String> newNameVals = widget.museum?.name.toMap() ?? {};
    String newAddressVal = widget.museum?.address ?? "";
    _addressController.addListener(() {
      newAddressVal = _addressController.text;
    });
    return Material(
      child: BaseBOEditorWidget(
        title: widget.museum != null
            ? translations.getTranslation("museum_edit")
            : translations.getTranslation("museum_creation"),
        content: [
          MultilingualStringEditorWidget(
            name: translations.getTranslation("name"),
            value: widget.museum?.name,
            valueChanged: (newVals) => newNameVals = newVals,
            mandatory: true,
          ),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
              labelText:
                  '${translations.getTranslation("address")} (${translations.getTranslation("required")})',
            ),
          ),
        ],
        object: widget.museum,
        itemSaveRequested: () async {
          if (!ValidationHelper.isEmptyTranslationMap(newNameVals)) {
            Museum museum = Museum(
              "",
              newAddressVal,
              MultilingualString(newNameVals),
              0,
            );
            if (widget.museum != null) {
              museum = widget.museum!;
              museum.address = newAddressVal;
              museum.name = MultilingualString(newNameVals);
              await FirebaseService.updateMuseum(museum);
            } else {
              Museum? newMuseum = await FirebaseService.createMuseum(museum);
              if (newMuseum != null) {
                dataProvider.museums.putIfAbsent(newMuseum.id, () => newMuseum);
              }
            }
            dataProvider.forceReload();

            backToList(text: translations.getTranslation("saved"));
          } else {
            SimpleSnackBar.showSnackBar(context,
                translations.getTranslation("fill_required_fields_msg"));
          }
        },
        itemDeleteRequested: () async {
          await FirebaseService.deleteMuseum(widget.museum!);
          dataProvider.museums.remove(widget.museum!.id);
          dataProvider.forceReload();
          backToList();
        },
        hasDependencies:
            widget.museum == null ? false : widget.museum!.references > 0,
      ),
    );
  }
}

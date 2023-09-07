import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/museum.dart';
import 'package:expo_nomade_mobile/firebase_service.dart';
import 'package:expo_nomade_mobile/util/base_bo_editor_widget.dart';
import 'package:expo_nomade_mobile/util/bo_editor_block_widget.dart';
import 'package:expo_nomade_mobile/util/bo_selector_widget.dart';
import 'package:expo_nomade_mobile/util/globals.dart';
import 'package:expo_nomade_mobile/util/image_selector_widget.dart';
import 'package:expo_nomade_mobile/util/multilingual_string.dart';
import 'package:expo_nomade_mobile/util/multilingual_string_editor.dart';
import 'package:expo_nomade_mobile/util/simple_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bo/expo_axis.dart';
import '../bo/expo_object.dart';
import 'package:latlong2/latlong.dart';

import '../bo/exposition.dart';
import '../util/validation_helper.dart';

/// Class ExpoObjectEditorWidget est un widget utilisé pour éditer ou créer un objet ExpoObject.
class ExpoObjectEditorWidget extends StatefulWidget {
  final ExpoObject? object;

  /// Constructeur ExpoObjectEditorWidget.
  const ExpoObjectEditorWidget({Key? key, this.object}) : super(key: key);

  @override
  _ExpoObjectEditorWidgetState createState() => _ExpoObjectEditorWidgetState();
}

/// State class pour ExpoObjectEditorWidget.
class _ExpoObjectEditorWidgetState extends State<ExpoObjectEditorWidget> {
  late final TextEditingController _dimController;
  late String newDimensions;

  @override
  void initState() {
    super.initState();
    newDimensions = widget.object?.dimension ?? '';
    _dimController =
        TextEditingController(text: widget.object?.dimension ?? '');
    _dimController.addListener(() {
      newDimensions = _dimController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final dataProvider = Provider.of<ExpositionNotifier>(context);
    final Exposition expo = dataProvider.exposition;
    Map<String, String> newTitleVals = widget.object?.title.toMap() ?? {};
    Map<String, String> newDescVals = widget.object?.description.toMap() ?? {};
    Map<String, String> newMaterialVals = widget.object?.material.toMap() ?? {};
    Map<String, String> newPosVals = widget.object?.position.toMap() ?? {};
    Map<String, String> newOtherVals = widget.object?.others.toMap() ?? {};
    String newPicURLVal = widget.object?.pictureURL ?? "";
    ExpoAxis newAxis = widget.object?.axis ?? expo.axes.values.first;
    Museum newMuseum = widget.object?.museum ?? expo.museums.first;
    Map<int, LatLng> newCoordinatesVals = widget.object?.coordinates ?? {};
    return Material(
      child: BaseBOEditorWidget(
        title: widget.object != null
            ? translations.getTranslation("object_edit")
            : translations.getTranslation("object_creation"),
        content: [
          MultilingualStringEditorWidget(
            name: translations.getTranslation("title"),
            value: widget.object != null ? widget.object!.title : null,
            valueChanged: (newVals) => newTitleVals = newVals,
            mandatory: true,
          ),
          MultilingualStringEditorWidget(
            name: translations.getTranslation("description"),
            value: widget.object != null ? widget.object!.description : null,
            valueChanged: (newVals) => newDescVals = newVals,
          ),
          MultilingualStringEditorWidget(
            name: translations.getTranslation("material"),
            value: widget.object?.material,
            valueChanged: (newVals) => newMaterialVals = newVals,
          ),
          MultilingualStringEditorWidget(
            name: translations.getTranslation("position"),
            value: widget.object?.position,
            valueChanged: (newVals) => newPosVals = newVals,
          ),
          MultilingualStringEditorWidget(
            name: translations.getTranslation("other"),
            value: widget.object?.others,
            valueChanged: (newVals) => newOtherVals = newVals,
          ),
          ImageSelectorWidget(
            name: translations.getTranslation("picture"),
            urlChanged: (newVal) => newPicURLVal = newVal,
            url: newPicURLVal,
          ),
          BOSelectorWidget(
            name: translations.getTranslation("axe"),
            objects: expo.axes.values.toList(),
            preSel: newAxis,
            selectedItemChanged: (newVal) => newAxis = (newVal as ExpoAxis),
            mandatory: true,
          ),
          BOSelectorWidget(
            name: translations.getTranslation("museum"),
            objects: expo.museums,
            preSel: newMuseum,
            selectedItemChanged: (newVal) => newMuseum = (newVal as Museum),
            mandatory: true,
          ),
          BOEditorBlockWidget(
            name: translations.getTranslation("dimensions"),
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dimController,
                      decoration: InputDecoration(
                        labelText:
                            '${translations.getTranslation("dimensions")} (${translations.getTranslation('lang_${translations.getCurrentLangCode()}}')})',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // TODO coordinates widget
          // LatLngSelectorWidget(
          //   name: translations.getTranslation("coordinates"),
          //   values: newCoordinatesVals,
          //   valuesChanged: (newVals) => newCoordinatesVals = newVals,
          //   mandatory: true,
          // ),
        ],
        object: widget.object,
        itemSaveRequested: () async {
          if (!ValidationHelper.isEmptyTranslationMap(newTitleVals)) {
            // TODO validation for other mandatory fields
            ExpoObject object = ExpoObject(
              "",
              newAxis,
              newCoordinatesVals,
              MultilingualString(newDescVals),
              newDimensions,
              MultilingualString(newMaterialVals),
              newMuseum,
              MultilingualString(newOtherVals),
              newPicURLVal,
              MultilingualString(newPosVals),
              MultilingualString(newTitleVals),
            );
            if (widget.object != null) {
              object = widget.object!;
              object.axis = newAxis;
              object.coordinates = newCoordinatesVals;
              object.dimension = newDimensions;
              object.material = MultilingualString(newMaterialVals);
              object.museum = newMuseum;
              object.others = MultilingualString(newOtherVals);
              object.title = MultilingualString(newTitleVals);
              object.description = MultilingualString(newDescVals);
              object.pictureURL = newPicURLVal;
              object.position = MultilingualString(newPosVals);
              await FirebaseService.updateObject(object);
            } else {
              ExpoObject? newObject =
                  await FirebaseService.createObject(object);
              if (newObject != null) {
                expo.objects.add(newObject);
              }
            }
            dataProvider.forceRelaod();
            SimpleSnackBar.showSnackBar(
                context, translations.getTranslation("saved"));
            backToList();
          } else {
            SimpleSnackBar.showSnackBar(context,
                translations.getTranslation("fill_required_fields_msg"));
          }
        },
        itemDeleteRequested: () async {
          await FirebaseService.deleteObject(widget.object!);
          expo.objects.remove(widget.object!);
          dataProvider.forceRelaod();
          backToList();
        },
      ),
    );
  }

  /// Retourne à la vue de liste.
  void backToList() {
    Navigator.of(context).pop();
  }
}

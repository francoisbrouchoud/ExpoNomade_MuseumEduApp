import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/util/base_business_object.dart';
import 'package:expo_nomade_mobile/util/bo_editor_block_widget.dart';
import 'package:flutter/material.dart';

/// Class BOSelectorWidget is used to display a DropDownButton of business objects and select a single one of them.
class BOSelectorWidget extends StatefulWidget {
  final List<BaseBusinessObject> objects;
  final BaseBusinessObject? preSel;
  final Function(BaseBusinessObject) selectedItemChanged;
  final String? name;
  final bool mandatory;

  /// Creates a new BOSelectorWidget: the items will be listed and the preselected item will be selected if provided.
  const BOSelectorWidget(
      {super.key,
      required this.objects,
      required this.selectedItemChanged,
      this.preSel,
      this.name,
      this.mandatory = false});

  @override
  BOSelectorWidgetState createState() => BOSelectorWidgetState();
}

/// State class for the BOSelectorWidget.
class BOSelectorWidgetState extends State<BOSelectorWidget> {
  late BaseBusinessObject? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = null;
    if (widget.preSel != null) {
      _selectedItem = widget.preSel!;
    } else if (widget.objects.isNotEmpty) {
      _selectedItem = widget.objects.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.name != null) {
      return BOEditorBlockWidget(
        name: widget.name!,
        mandatory: widget.mandatory,
        children: [
          Row(
            children: [
              _buildCoreDropDown(context),
            ],
          )
        ],
      );
    } else {
      return _buildCoreDropDown(context);
    }
  }

  /// Builds the drop down button without any decoration
  Widget _buildCoreDropDown(BuildContext context) {
    return DropdownButton<BaseBusinessObject>(
      value: _selectedItem,
      onChanged: (BaseBusinessObject? newValue) {
        setState(() {
          _selectedItem = newValue ?? _selectedItem;
        });
        if (_selectedItem != null) {
          widget.selectedItemChanged(_selectedItem!);
        }
      },
      items: widget.objects.map((BaseBusinessObject object) {
        return DropdownMenuItem<BaseBusinessObject>(
          value: object,
          child: Text(object
              .toListText(AppLocalization.of(context).getCurrentLangCode())),
        );
      }).toList(),
    );
  }
}

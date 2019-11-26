import 'package:flutter/material.dart';
import '../utils.dart';
import './builder.dart';
import './page.dart';
import './sheet.dart';
import './popup.dart';

class SmartMultiSelect extends StatefulWidget {
  final String title;
  final String placeholder;
  final List<dynamic> value;
  final List<Map<String, dynamic>> options;
  final bool searchable;
  final SmartSelectTarget target;
  final SmartSelectChange onChange;
  final SmartMultiSelectBuilder builder;

  SmartMultiSelect({
    Key key,
    this.title,
    this.placeholder = 'Select one',
    this.value,
    this.options,
    this.searchable,
    this.target = SmartSelectTarget.page,
    this.onChange,
    this.builder,
  }) : super(key: key);

  SmartMultiSelect.popup({
    Key key,
    this.title,
    this.placeholder = 'Select one or more',
    this.value,
    this.options,
    this.onChange,
    this.builder,
  })  : this.target = SmartSelectTarget.popup,
        this.searchable = false,
        super(key: key);

  SmartMultiSelect.sheet({
    Key key,
    this.title,
    this.placeholder = 'Select one',
    this.value,
    this.options,
    this.onChange,
    this.builder,
  })  : this.target = SmartSelectTarget.sheet,
        this.searchable = false,
        super(key: key);

  @override
  _SmartMultiSelectState createState() => _SmartMultiSelectState();
}

class _SmartMultiSelectState extends State<SmartMultiSelect> {
  GlobalKey<SmartSelectSheetState> _sheetController =
      GlobalKey<SmartSelectSheetState>();
  GlobalKey<SmartSelectPopupState> _popupController =
      GlobalKey<SmartSelectPopupState>();

  @override
  Widget build(BuildContext context) {
    var selected =
        widget.options.where((x) => widget.value.contains(x['value']));
    final SmartMultiSelectBuilderInfo info = SmartMultiSelectBuilderInfo(
      title: widget.title,
      placeholder: widget.placeholder,
      selected: selected,
      showOptions: this._showOptions,
      target: widget.target,
    );
    return widget.builder != null
        ? widget.builder(context, info)
        : SmartMultiSelectBuilderDefault(info: info);
  }

  void _showOptions(BuildContext context) async {
    var result;
    switch (widget.target) {
      case SmartSelectTarget.page:
        result = await Navigator.push(context, MaterialPageRoute(builder: (_) {
          return SmartSelectPage(
            title: widget.title,
            value: widget.value,
            options: widget.options,
            searchable: widget.searchable,
          );
        }));
        break;
      case SmartSelectTarget.sheet:
        result = await showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => SmartSelectSheet(
            key: _sheetController,
            title: widget.title,
            value: widget.value,
            options: widget.options,
          ),
        );
        result = _sheetController
            .currentState.checkboxesController.currentState.selectedList;
        break;
      case SmartSelectTarget.popup:
        result = await showDialog(
          context: context,
          builder: (BuildContext context) => SmartSelectPopup(
            key: _popupController,
            title: widget.title,
            value: widget.value,
            options: widget.options,
          ),
        );
        result = _popupController
            .currentState.checkboxesController.currentState.selectedList;
        break;
    }

    // return value
    if (widget.onChange != null && result != null) widget.onChange(result);
  }
}

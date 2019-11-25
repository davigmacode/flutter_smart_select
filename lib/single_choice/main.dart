import 'package:flutter/material.dart';
import '../utils.dart';
import './builder.dart';
import './page.dart';
import './sheet.dart';
import './popup.dart';

class SmartSelect extends StatelessWidget {

  final String title;
  final String placeholder;
  final dynamic value;
  final List<Map<String,dynamic>> options;
  final bool searchable;
  final bool closeOnSelect;
  final SmartSelectTarget target;
  final SmartSelectChange onChange;
  final SmartSelectBuilder builder;

  SmartSelect({
    Key key,
    this.title,
    this.placeholder = 'Select one',
    this.value,
    this.options,
    this.searchable,
    this.closeOnSelect = true,
    this.target = SmartSelectTarget.page,
    this.onChange,
    this.builder,
  }) : super(key: key);

  SmartSelect.popup({
    Key key,
    this.title,
    this.placeholder = 'Select one',
    this.value,
    this.options,
    this.onChange,
    this.builder,
  }) : this.target = SmartSelectTarget.popup,
    this.searchable = false,
    this.closeOnSelect = true,
    super(key: key);

  SmartSelect.sheet({
    Key key,
    this.title,
    this.placeholder = 'Select one',
    this.value,
    this.options,
    this.onChange,
    this.builder,
  }) : this.target = SmartSelectTarget.sheet,
    this.searchable = false,
    this.closeOnSelect = true,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    var selected = options.firstWhere((x) => x['value'] == value, orElse: () => null);
    final SmartSelectBuilderInfo info = SmartSelectBuilderInfo(
      title: title,
      placeholder: placeholder,
      selected: selected,
      showOptions: this._showOptions,
      target: target,
    );
    return builder != null
      ? builder(context, info)
      : SmartSelectBuilderDefault(info: info);
  }

  void _showOptions (BuildContext context) async {
    var result;
    switch (target) {
      case SmartSelectTarget.page:
        result = await Navigator.push(context, MaterialPageRoute(builder: (_) {
          return SmartSelectPage(
            title: title,
            value: value,
            options: options,
            closeOnSelect: closeOnSelect,
          );
        }));
        break;
      case SmartSelectTarget.sheet:
        result = await showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => SmartSelectSheet(
            title: title,
            value: value,
            options: options,
          ),
        );
        break;
      case SmartSelectTarget.popup:
        result = await showDialog(
          context: context,
          builder: (BuildContext context) => SmartSelectPopup(
            title: title,
            value: value,
            options: options,
          ),
        );
        break;
    }

    // return value
    if (onChange != null && result != null) {
      onChange(result);
    }
  }
}
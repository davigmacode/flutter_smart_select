import 'package:flutter/material.dart';
import '../utils.dart';
import './builder.dart';
import './page.dart';
import './sheet.dart';
import './popup.dart';

class SmartMultiSelect extends StatelessWidget {

  final String title;
  final String placeholder;
  final List<dynamic> value;
  final List<Map<String,dynamic>> options;
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
    this.placeholder = 'Select one',
    this.value,
    this.options,
    this.onChange,
    this.builder,
  }) : this.target = SmartSelectTarget.popup,
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
  }) : this.target = SmartSelectTarget.sheet,
    this.searchable = false,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    var selected = options.where((x) => value.contains(x['value']));
    final SmartMultiSelectBuilderInfo info = SmartMultiSelectBuilderInfo(
      title: title,
      placeholder: placeholder,
      selected: selected,
      showOptions: this._showOptions,
      target: target,
    );
    return builder != null
      ? builder(context, info)
      : SmartMultiSelectBuilderDefault(info: info);
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
            searchable: searchable,
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
    if (onChange != null && result != null) onChange(result);
  }
}
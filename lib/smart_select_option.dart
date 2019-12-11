import 'package:flutter/material.dart';

typedef Widget SmartSelectOptionConfirmationBuilder(
    BuildContext context, Function onConfirm);
typedef Widget SmartSelectOptionGroupHeaderBuilder(String _group, int _count);
typedef Widget SmartSelectOptionDividerBuilder(BuildContext context, int index);
typedef Widget SmartSelectOptionItemBuilder(
    Map item, bool checked, SmartSelectOptionItemOnChange onChange);
typedef void SmartSelectOptionItemOnChange(dynamic value, bool checked);

class SmartSelectOption {
  final List items;
  final String label;
  final String value;
  final String groupBy;
  final bool isMultiChoice;
  final bool useHeader;
  final bool useFilter;
  final bool useDivider;
  final bool useConfirmation;
  final ShapeBorder shape;
  final double elevation;
  final Color backgroundColor;
  final Color glowingOverscrollIndicatorColor;
  final SmartSelectOptionHeaderTheme headerTheme;
  final SmartSelectOptionItemTheme itemTheme;
  final SmartSelectOptionGroupHeaderTheme groupHeaderTheme;
  final SmartSelectOptionItemBuilder itemBuilder;
  final SmartSelectOptionDividerBuilder dividerBuilder;
  final SmartSelectOptionConfirmationBuilder confirmationBuilder;
  final SmartSelectOptionGroupHeaderBuilder groupHeaderBuilder;

  SmartSelectOption(
    this.items, {
    this.label = 'label',
    this.value = 'value',
    this.groupBy,
    this.isMultiChoice = false,
    this.useHeader = true,
    this.useFilter = false,
    this.useDivider = false,
    this.useConfirmation = false,
    this.shape,
    this.elevation,
    this.backgroundColor,
    this.glowingOverscrollIndicatorColor = Colors.blueGrey,
    this.headerTheme = const SmartSelectOptionHeaderTheme(),
    this.itemTheme = const SmartSelectOptionItemTheme(),
    this.groupHeaderTheme = const SmartSelectOptionGroupHeaderTheme(),
    this.itemBuilder,
    this.dividerBuilder,
    this.confirmationBuilder,
    this.groupHeaderBuilder,
  });

  List filteredList(String _query) {
    return _query != null
        ? items.where((_item) => _filterTest(_item, _query)).toList()
        : items;
  }

  bool _filterTest(Map _item, String _query) {
    return _filterTestByLabel(_item, _query) ||
        _filterTestByGroup(_item, _query);
  }

  bool _filterTestByLabel(Map _item, String _query) {
    return _item[label].toLowerCase().contains(_query.toLowerCase());
  }

  bool _filterTestByGroup(Map _item, String _query) {
    return groupBy != null
        ? _item[groupBy].toLowerCase().contains(_query.toLowerCase())
        : false;
  }

  List groupKeys(List _items) {
    Set _groups = Set();
    _items.forEach((_item) => _groups.add(_item[groupBy]));
    return _groups.toList();
  }

  List groupItems(List _items, String key) {
    return _items.where((_item) => _item[groupBy] == key).toList();
  }
}

class SmartSelectOptionHeaderTheme {
  final ShapeBorder shape;
  final double elevation;
  final Color backgroundColor;
  final Brightness brightness;
  final bool centerTitle;
  final TextStyle textStyle;
  final IconThemeData iconTheme;
  final IconThemeData actionsIconTheme;

  const SmartSelectOptionHeaderTheme({
    this.shape,
    this.elevation = 0.5,
    this.centerTitle = false,
    this.textStyle = const TextStyle(color: Colors.black54),
    this.iconTheme = const IconThemeData(color: Colors.black54),
    this.actionsIconTheme = const IconThemeData(color: Colors.black54),
    this.backgroundColor = Colors.white,
    this.brightness,
  });
}

class SmartSelectOptionItemTheme {
  final Color checkColor;
  final Color activeColor;
  final Color unselectedColor;
  final TextStyle titleStyle;

  const SmartSelectOptionItemTheme({
    this.checkColor = Colors.white,
    this.activeColor = Colors.black54,
    this.unselectedColor = Colors.black54,
    this.titleStyle = const TextStyle(color: Color(0xFF616161)),
  });
}

class SmartSelectOptionGroupHeaderTheme {
  final Color backgroundColor;
  final TextStyle titleStyle;
  final EdgeInsetsGeometry padding;
  final double height;

  const SmartSelectOptionGroupHeaderTheme({
    this.backgroundColor = const Color(0xFFECEFF1),
    this.titleStyle = const TextStyle(color: Colors.black54),
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.height = 45.0,
  });
}

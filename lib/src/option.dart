import 'package:flutter/material.dart';

/// A builder for custom confirmation widget
typedef Widget SmartSelectOptionConfirmationBuilder(
    BuildContext context, Function onConfirm);

/// A builder for custom option group header widget
typedef Widget SmartSelectOptionGroupHeaderBuilder(String _group, int _count);

/// A builder for custom divider widget between option item
typedef Widget SmartSelectOptionDividerBuilder(BuildContext context, int index);

/// A builder for custom each option item widget
typedef Widget SmartSelectOptionItemBuilder(
    Map item, bool checked, SmartSelectOptionItemOnChange onChange);

/// Callback to handle change of each custom option item
typedef void SmartSelectOptionItemOnChange(dynamic value, bool checked);

/// List of option along with its configuration
class SmartSelectOption {

  /// The list of object option items
  final List items;

  /// Custom property from each option item
  /// that represent the label
  final String label;

  /// Custom property from each option item
  /// that represent the value
  final String value;

  /// Custom property from each option item
  /// that used to grouped option items
  final String groupBy;

  /// Whether show the options list
  /// as single choice or multiple choice
  final bool isMultiChoice;

  /// Whether the options list modal use header or not
  final bool useHeader;

  /// Whether the option list is filterable or not
  final bool useFilter;

  /// Whether the option list need to confirm
  /// to return the changed value
  final bool useConfirmation;

  /// Whether the option item use divider or not
  final bool useDivider;

  /// Modal border shape
  /// used in popup dialog and bottom sheet
  final ShapeBorder shape;

  /// Modal elevation
  /// used in popup dialog and bottom sheet
  final double elevation;

  /// Modal background color
  final Color backgroundColor;

  /// Custom color of the glowing indicator
  /// when overscroll the option list
  final Color glowingOverscrollIndicatorColor;

  /// Configure option header theme
  final SmartSelectOptionHeaderTheme headerTheme;

  /// Configure option item theme
  final SmartSelectOptionItemTheme itemTheme;

  /// Configure option group header theme
  final SmartSelectOptionGroupHeaderTheme groupHeaderTheme;

  /// Builder for each custom option item
  final SmartSelectOptionItemBuilder itemBuilder;

  /// Builder for custom divider widget between option item
  final SmartSelectOptionDividerBuilder dividerBuilder;

  /// Builder for custom confirmation widget
  final SmartSelectOptionConfirmationBuilder confirmationBuilder;

  /// Builder for custom option group header widget
  final SmartSelectOptionGroupHeaderBuilder groupHeaderBuilder;

  /// Create list of option along with its configuration
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

  /// return a filtered list of options
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

  /// return a list of group keys
  List groupKeys(List _items) {
    Set _groups = Set();
    _items.forEach((_item) => _groups.add(_item[groupBy]));
    return _groups.toList();
  }

  /// return a list of group items
  List groupItems(List _items, String key) {
    return _items.where((_item) => _item[groupBy] == key).toList();
  }
}

/// Configure modal option header theme
class SmartSelectOptionHeaderTheme {

  /// Header border shape
  final ShapeBorder shape;

  /// Header elevation
  final double elevation;

  /// Header background color
  final Color backgroundColor;

  /// Header brightness
  final Brightness brightness;

  /// Whether the header title is centered
  final bool centerTitle;

  /// Header text style
  /// used by title and search field
  final TextStyle textStyle;

  /// Header icon theme
  final IconThemeData iconTheme;

  /// Header actions icon theme
  final IconThemeData actionsIconTheme;

  /// Create a configuration of modal option header theme
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

/// Configure option item theme
class SmartSelectOptionItemTheme {

  /// Checked icon color
  final Color checkColor;

  /// Checkbox or radio active color
  final Color activeColor;

  /// Unselected checkbox or radio color
  final Color unselectedColor;

  /// Option item text style
  final TextStyle titleStyle;

  /// Create a configuration of option item theme
  const SmartSelectOptionItemTheme({
    this.checkColor = Colors.white,
    this.activeColor = Colors.black54,
    this.unselectedColor = Colors.black54,
    this.titleStyle = const TextStyle(color: Color(0xFF616161)),
  });
}

/// Configure option group header theme
class SmartSelectOptionGroupHeaderTheme {

  /// Group header background color
  final Color backgroundColor;

  /// Group header text style
  final TextStyle textStyle;

  /// Group header padding
  final EdgeInsetsGeometry padding;

  /// Group header height
  final double height;

  /// Create a configuration of option group header theme
  const SmartSelectOptionGroupHeaderTheme({
    this.backgroundColor = const Color(0xFFECEFF1),
    this.textStyle = const TextStyle(color: Colors.black54),
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.height = 45.0,
  });
}

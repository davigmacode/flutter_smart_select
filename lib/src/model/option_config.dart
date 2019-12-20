import './option_item.dart';

/// List of option along with its configuration
class SmartSelectOptionConfig {

  /// The list of object option items
  final List _items;

  /// Custom property from each option item
  /// that represent the label
  final dynamic title;

  /// Custom property from each option item
  /// that represent the subtitle
  final dynamic subtitle;

  /// Custom property from each option item
  /// that represent the value
  final dynamic value;

  /// Custom property from each option item
  /// that used to grouped option items
  final dynamic groupBy;

  /// Create list of option along with its configuration
  SmartSelectOptionConfig(
    this._items, {
    this.value,
    this.title,
    this.subtitle,
    this.groupBy,
  });

  List<SmartSelectOptionItem> get items {
    List<SmartSelectOptionItem> result = [];
    if (_items is List<Map>) {
      result = _items.map((item) => SmartSelectOptionItem.fromMap(
        map: item,
        valueProp: value,
        titleProp: title,
        subtitleProp: subtitle,
        groupByProp: groupBy,
      )).toList().cast<SmartSelectOptionItem>();
    } else if (_items is List<List<dynamic>>) {
      result = _items.map((item) => SmartSelectOptionItem.fromList(
        list: item,
        valueProp: value,
        titleProp: title,
        subtitleProp: subtitle,
        groupByProp: groupBy,
      )).toList().cast<SmartSelectOptionItem>();
    } else if (_items is List<dynamic>) {
      _items.asMap().forEach((index, item) {
        result.add(SmartSelectOptionItem(
          value: index,
          title: item.toString(),
        ));
      });
    } else {
      throw new Exception('Unsupported option format. use List<Map> or List<List<dynamic>>, List<dynamic>');
    }
    return result;
  }

  /// return a filtered list of options
  List<SmartSelectOptionItem> filteredItems(String query) {
    return query != null
        ? items.where((item) => item.contains(query)).toList()
        : items;
  }
}


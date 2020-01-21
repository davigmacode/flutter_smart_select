import 'package:flutter/foundation.dart';

class SmartSelectOption<T> {
  final T value;
  final String title;
  final String subtitle;
  final String group;
  final bool disabled;
  final bool hidden;
  final meta;

  SmartSelectOption({
    @required this.value,
    @required this.title,
    this.subtitle,
    this.group,
    this.disabled = false,
    this.hidden = false,
    this.meta,
  });

  static List<SmartSelectOption<R>> listFrom<T, R>({
    @required List<T> source,
    @required SmartSelectOptionProp<T, R> value,
    @required SmartSelectOptionProp<T, String> title,
    SmartSelectOptionProp<T, String> subtitle,
    SmartSelectOptionProp<T, String> group,
    SmartSelectOptionProp<T, bool> disabled,
    SmartSelectOptionProp<T, bool> hidden,
    SmartSelectOptionProp<T, dynamic> meta,
  }) => source
      .asMap()
      .map((index, item) => MapEntry(index, SmartSelectOption<R>(
        value: value?.call(index, item),
        title: title?.call(index, item),
        subtitle: subtitle?.call(index, item),
        group: group?.call(index, item),
        disabled: disabled?.call(index, item),
        hidden: hidden?.call(index, item),
        meta: meta?.call(index, item),
      )))
      .values
      .toList()
      .cast<SmartSelectOption<R>>();

  bool contains(String query) {
    return _testPropBy(title, query)
      || _testPropBy(subtitle, query)
      || _testPropBy(group, query);
  }
}

typedef R SmartSelectOptionProp<T, R>(int index, T item);

bool _testPropBy(String prop, String query) {
  return prop != null
    ? prop.toLowerCase().contains(query.toLowerCase())
    : false;
}
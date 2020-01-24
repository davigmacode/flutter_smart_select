import 'package:flutter/foundation.dart';

/// Choice option configuration
class SmartSelectOption<T> {

  /// Value to return
  final T value;

  /// Represent as primary text
  final String title;

  /// Represent as secondary text
  final String subtitle;

  /// The option will grouped by this property value
  final String group;

  /// Whether the option is disabled or enabled
  final bool disabled;

  /// Whether the option is displayed or not
  final bool hidden;

  /// This prop is useful for choice builder
  final dynamic meta;

  /// Default constructor
  SmartSelectOption({
    @required this.value,
    @required this.title,
    this.subtitle,
    this.group,
    this.disabled = false,
    this.hidden = false,
    this.meta,
  });

  /// Helper to create option list from any list
  static List<SmartSelectOption<R>> listFrom<R, E>({
    @required List<E> source,
    @required _SmartSelectOptionProp<E, R> value,
    @required _SmartSelectOptionProp<E, String> title,
    _SmartSelectOptionProp<E, String> subtitle,
    _SmartSelectOptionProp<E, String> group,
    _SmartSelectOptionProp<E, bool> disabled,
    _SmartSelectOptionProp<E, bool> hidden,
    _SmartSelectOptionProp<E, dynamic> meta,
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

  bool _testPropBy(String prop, String query) {
    return prop != null
      ? prop.toLowerCase().contains(query.toLowerCase())
      : false;
  }
}

typedef R _SmartSelectOptionProp<E, R>(int index, E item);
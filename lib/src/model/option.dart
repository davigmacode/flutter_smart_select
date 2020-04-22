import 'dart:convert';
import 'package:flutter/foundation.dart';

/// Choice option configuration
class S2Option<T> {
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
  S2Option({
    @required this.value,
    @required this.title,
    this.subtitle,
    this.group,
    this.disabled = false,
    this.hidden = false,
    this.meta,
  })  : assert(disabled != null),
        assert(hidden != null);

  /// Helper to create option list from any list
  static List<S2Option<R>> listFrom<R, E>({
    @required List<E> source,
    @required _S2OptionProp<E, R> value,
    @required _S2OptionProp<E, String> title,
    _S2OptionProp<E, String> subtitle,
    _S2OptionProp<E, String> group,
    _S2OptionProp<E, bool> disabled,
    _S2OptionProp<E, bool> hidden,
    _S2OptionProp<E, dynamic> meta,
  }) =>
      source
          .asMap()
          .map((index, item) => MapEntry(
              index,
              S2Option<R>(
                value: value?.call(index, item),
                title: title?.call(index, item),
                subtitle: subtitle?.call(index, item),
                group: group?.call(index, item),
                disabled: disabled?.call(index, item) ?? false,
                hidden: hidden?.call(index, item) ?? false,
                meta: meta?.call(index, item),
              )))
          .values
          .toList();

  bool contains(String query) {
    return _testPropBy(title, query) ||
        _testPropBy(subtitle, query) ||
        _testPropBy(group, query);
  }

  bool _testPropBy(String prop, String query) {
    return prop != null
        ? Base64Codec()
            .normalize(prop)
            .toLowerCase()
            .contains(Base64Codec().normalize(query).toLowerCase())
        : false;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is S2Option &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

typedef R _S2OptionProp<E, R>(int index, E item);

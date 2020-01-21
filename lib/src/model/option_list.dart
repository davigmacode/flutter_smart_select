import 'package:flutter/foundation.dart';
import 'option.dart';

typedef SmartSelectOption SmartSelectOptionBuilder<T>(int index, T item);
typedef R SmartSelectOptionProp<T, R>(int index, T item);

abstract class SmartSelectOptionList {

  static List<SmartSelectOption<R>> generate<T, R>(
    List<T> items, {
    @required SmartSelectOptionProp<T, R> value,
    @required SmartSelectOptionProp<T, String> title,
    SmartSelectOptionProp<T, String> subtitle,
    SmartSelectOptionProp<T, String> group,
    SmartSelectOptionProp<T, bool> disabled,
    SmartSelectOptionProp<T, bool> hidden,
    SmartSelectOptionProp<T, dynamic> meta,
  }) => items
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

  static List<SmartSelectOption<T>> builder<T>(
    List<T> items,
    SmartSelectOptionBuilder<T> builder
  ) => items
      .asMap()
      .map((index, value) => MapEntry(index, builder(index, value)))
      .values
      .toList()
      .cast<SmartSelectOption<T>>();

}
import 'package:flutter/material.dart';
import './option.dart';

enum SmartSelectTarget { page, popup, sheet }
typedef void SmartSelectOnChange(dynamic value);
typedef Widget SmartSelectBuilder(
    BuildContext context, SmartSelectState state, Function showOptions);

class SmartSelectState {
  final String title;
  final dynamic value;
  final SmartSelectOption option;
  final String placeholder;

  SmartSelectState({this.title, this.value, this.option, this.placeholder});

  dynamic get valueObject {
    return option.isMultiChoice
        ? option.items.where((x) => value.contains(x[option.value]))
        : option.items
            .firstWhere((x) => x[option.value] == value, orElse: () => null);
  }

  dynamic get valueLabel {
    return option.isMultiChoice
        ? valueObject != null && valueObject.length > 0
            ? valueObject.map((x) => x[option.label]).toList()
            : null
        : valueObject != null ? valueObject[option.label] : null;
  }

  String get valueDisplay {
    return valueLabel != null
        ? option.isMultiChoice ? valueLabel.join(', ') : valueLabel
        : placeholder ?? placeholderDefault;
  }

  String get placeholderDefault {
    return option.isMultiChoice ? 'Select one or more' : 'Select one';
  }
}

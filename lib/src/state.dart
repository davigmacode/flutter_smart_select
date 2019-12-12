import 'package:flutter/material.dart';
import './option.dart';

/// Target to open option list
enum SmartSelectTarget { page, popup, sheet }

/// A function that called when the widget value changed
typedef void SmartSelectOnChange(dynamic value);

/// Builder for custom trigger widget
typedef Widget SmartSelectBuilder(
    BuildContext context, SmartSelectState state, Function showOptions);

/// Provide an actual state of the SmartSelect
class SmartSelectState {

  /// The primary content of the widget.
  /// Used in trigger widget and header option
  final String title;

  /// The current value of the widget.
  final dynamic value;

  /// List of option along with its configuration
  final SmartSelectOption option;

  /// The text displayed when the value is null
  final String placeholder;

  /// Create an actual state
  SmartSelectState({this.title, this.value, this.option, this.placeholder});

  /// return an object or array of object
  /// that represent the value
  dynamic get valueObject {
    return option.isMultiChoice
        ? option.items.where((x) => value.contains(x[option.value]))
        : option.items
            .firstWhere((x) => x[option.value] == value, orElse: () => null);
  }

  /// return a string or array of string
  /// that represent the value
  dynamic get valueLabel {
    return option.isMultiChoice
        ? valueObject != null && valueObject.length > 0
            ? valueObject.map((x) => x[option.label]).toList()
            : null
        : valueObject != null ? valueObject[option.label] : null;
  }

  /// return a string that can be used as display
  /// when value is null it will display placeholder
  String get valueDisplay {
    return valueLabel != null
        ? option.isMultiChoice ? valueLabel.join(', ') : valueLabel
        : placeholder ?? placeholderDefault;
  }

  /// return a string that used as default placeholder
  String get placeholderDefault {
    return option.isMultiChoice ? 'Select one or more' : 'Select one';
  }
}

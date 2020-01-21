import './option.dart';

/// Expose current of the [SmartSelect] widget
class SmartSelectState<T> {

  /// The primary content of the widget.
  /// Used in trigger widget and header option
  final String title;

  /// The current value of the widget.
  final T value;

  /// The current value of the widget.
  final List<T> values;

  /// List of option along with its configuration
  final List<SmartSelectOption<T>> options;

  /// The text displayed when the value is null
  final String placeholder;

  /// Whether show the options list
  /// as single choice or multiple choice
  final bool isMultiChoice;

  /// Create an actual state
  SmartSelectState.single(
    this.value, {
    this.title,
    this.options,
    this.placeholder,
  }) : isMultiChoice = false, values = null;

  /// Create an actual state
  SmartSelectState.multiple(
    this.values, {
    this.title,
    this.options,
    this.placeholder,
  }) : isMultiChoice = true, value = null;

  /// return an object or array of object
  /// that represent the value
  SmartSelectOption<T> get valueObject {
    return options.firstWhere((SmartSelectOption<T> item) => item.value == value, orElse: () => null);
  }

  /// return an object or array of object
  /// that represent the value
  List<SmartSelectOption<T>> get valuesObject {
    return options.where((SmartSelectOption<T> item) => values?.contains(item.value) ?? false).toList().cast<SmartSelectOption<T>>();
  }

  /// return a string or array of string
  /// that represent the value
  String get valueTitle {
    return valueObject != null ? valueObject.title : null;
  }

  /// return a string or array of string
  /// that represent the value
  List<String> get valuesTitle {
    return valuesObject != null && valuesObject.length > 0
      ? valuesObject.map((SmartSelectOption<T> item) => item.title).toList()
      : null;
  }

  /// return a string that can be used as display
  /// when value is null it will display placeholder
  String get valueDisplay {
    return isMultiChoice == true
      ? valuesTitle != null
        ? valuesTitle.join(', ') : placeholder
      : valueTitle != null
        ? valueTitle : placeholder;
  }
}
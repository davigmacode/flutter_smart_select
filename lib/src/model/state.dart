import './option_item.dart';

/// Expose current of the [SmartSelect] widget
class SmartSelectState {

  /// The primary content of the widget.
  /// Used in trigger widget and header option
  final String title;

  /// The current value of the widget.
  final dynamic value;

  /// List of option along with its configuration
  final List<SmartSelectOptionItem> option;

  /// The text displayed when the value is null
  final String placeholder;

  /// Whether show the options list
  /// as single choice or multiple choice
  final bool isMultiChoice;

  /// Create an actual state
  SmartSelectState({
    this.title,
    this.value,
    this.option,
    this.placeholder,
    this.isMultiChoice,
  });

  /// return an object or array of object
  /// that represent the value
  dynamic get valueObject {
    return isMultiChoice == true
      ? option.where((SmartSelectOptionItem item) => value.contains(item.value))
      : option.firstWhere((SmartSelectOptionItem item) => item.value == value, orElse: () => null);
  }

  /// return a string or array of string
  /// that represent the value
  dynamic get valueTitle {
    return isMultiChoice == true
      ? valueObject != null && valueObject.length > 0
        ? valueObject.map((SmartSelectOptionItem item) => item.title).toList()
        : null
      : valueObject != null ? valueObject.title : null;
  }

  /// return a string that can be used as display
  /// when value is null it will display placeholder
  String get valueDisplay {
    return valueTitle != null
      ? isMultiChoice == true ? valueTitle.join(', ') : valueTitle
      : placeholder ?? placeholderDefault;
  }

  /// return a string that used as default placeholder
  String get placeholderDefault {
    return isMultiChoice == true ? 'Select one or more' : 'Select one';
  }
}
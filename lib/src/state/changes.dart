import 'package:flutter/foundation.dart';

/// Validation callback
typedef String ValidationCallback<T>(T value);

/// State of value changes
abstract class S2Changes<T> extends ChangeNotifier {

  /// check whether the current value has the requested value
  bool contains(T val);

  /// select or unselect a value
  void commit(T val, { bool selected = true });

  /// validate value by validation function
  void validate();

  /// Validation error message
  String error;

  /// whether the changes value is valid or not
  bool get valid => error == null || error?.length == 0;

  /// get length of selected value
  int get length;

}

/// State of value changes of single choice widget
class S2SingleChanges<T> extends S2Changes<T> {

  /// current selected value
  T _value;

  /// validation function used to validate value changes
  final ValidationCallback<T> validation;

  /// default constructor
  S2SingleChanges(this._value, { this.validation });

  /// get current selected value
  T get value => _value;

  /// override current value to new value
  set value(T val) {
    _value = val;
    validate();
  }

  /// get length of selected value
  @override
  int get length => _value != null ? 1 : 0;

  /// select or unselect a value
  @override
  void commit(T val, { bool selected = true }) {
    _value = val;
    validate();
  }

  /// validate value by validation function
  @override
  void validate() {
    error = validation?.call(value);
    notifyListeners();
  }

  /// check whether the current value has the requested value
  @override
  bool contains(T val) {
    return _value == val;
  }

}

/// State of value changes of multiple choice widget
class S2MultiChanges<T> extends S2Changes<T> {

  /// current selected value
  List<T> _value;

  /// callback to override the current value with all available values
  final VoidCallback _selectAll;

  /// validation function used to validate value changes
  final ValidationCallback<List<T>> validation;

  /// default constructor
  S2MultiChanges(List<T> val, {
    this.validation,
    VoidCallback selectAll,
  }) :
    _value = val ?? [],
    _selectAll = selectAll;

  /// get current selected value
  List<T> get value => _value;

  /// override current value to new value
  set value(List<T> val) {
    _value = List<T>.from(val ?? []);
    validate();
  }

  /// get length of selected value
  @override
  int get length => _value?.length ?? 0;

  /// unselect all values
  void selectNone() {
    value = null;
  }

  /// select all available values
  void selectAll() {
    _selectAll?.call();
  }

  /// toggle select all/none
  void selectToggle() {
    if (length == 0) {
      selectAll();
    } else {
      selectNone();
    }
  }

  /// select or unselect a value
  @override
  void commit(T val, { bool selected = true }) {
    if (selected) {
      _value.add(val);
    } else {
      _value.remove(val);
    }
    validate();
  }

  /// validate value by validation function
  @override
  void validate() {
    error = validation?.call(value);
    notifyListeners();
  }

  /// check whether the current value has the requested value
  @override
  bool contains(T val) {
    return _value?.contains(val) ?? false;
  }

}
import 'package:flutter/foundation.dart';

/// Validation callback
typedef bool ValidationCallback<T>(T value);

abstract class S2Changes<T> extends ChangeNotifier {

  /// check whether the current value has the requested value
  bool contains(T val);

  /// select value
  void commit(T val, { bool selected = true });

  void validate();

  /// whether the changes value is valid or not
  bool valid;

  /// get length of selected value
  int get length;

}

class S2SingleChanges<T> extends S2Changes<T> {

  final ValidationCallback<T> validation;

  T _value;

  T get value => _value;

  S2SingleChanges(this._value, { this.validation });

  int get length => _value != null ? 1 : 0;

  set value(T val) {
    _value = val;
    validate();
  }

  void commit(T val, { bool selected = true }) {
    _value = val;
    validate();
  }

  void validate() {
    valid = validation?.call(value);
    notifyListeners();
  }

  bool contains(T val) {
    return _value == val;
  }

}

class S2MultiChanges<T> extends S2Changes<T> {

  final ValidationCallback<List<T>> validation;

  List<T> _value;

  List<T> get value => _value;

  S2MultiChanges(List<T> val, { this.validation }) : _value = val ?? [];

  int get length => _value?.length ?? 0;

  set value(List<T> val) {
    _value = List<T>.from(val ?? []);
    validate();
  }

  void commit(T val, { bool selected = true }) {
    if (selected) {
      _value.add(val);
    } else {
      _value.remove(val);
    }
    validate();
  }

  void validate() {
    valid = validation?.call(value);
    notifyListeners();
  }

  bool contains(T val) {
    return _value?.contains(val) ?? false;
  }

}
import 'package:flutter/foundation.dart';

abstract class S2Changes<T> extends ChangeNotifier {

  /// check whether the current value has the requested value
  bool contains(T val);

  /// select value
  void commit(T val, { bool selected = true });

  /// get length of selected value
  int get length;
}

class S2SingleChanges<T> extends S2Changes<T> {

  T _value;

  T get value => _value;

  S2SingleChanges(this._value);

  int get length => 1;

  set value(T val) {
    _value = val;
    notifyListeners();
  }

  void commit(T val, { bool selected = true }) {
    _value = val;
    notifyListeners();
  }

  bool contains(T val) {
    return _value == val;
  }

}

class S2MultiChanges<T> extends S2Changes<T> {

  List<T> _value;

  List<T> get value => _value;

  S2MultiChanges(this._value);

  int get length => _value.length;

  set value(List<T> val) {
    _value = List<T>.from(val);
    notifyListeners();
  }

  void commit(T val, { bool selected = true }) {
    if (selected) {
      _value.add(val);
    } else {
      _value.remove(val);
    }
    notifyListeners();
  }

  bool contains(T val) {
    return _value?.contains(val) ?? false;
  }

}
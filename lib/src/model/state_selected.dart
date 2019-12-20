import 'package:flutter/foundation.dart';

class SmartSelectStateSelected extends ChangeNotifier {

  final bool _isMultiChoice;

  dynamic _value;

  SmartSelectStateSelected(this._isMultiChoice, this._value);

  dynamic get value => _value;

  bool contains(dynamic val, [isMultiChoice = false]) {
    return _isMultiChoice == true
      ? _value.contains(val)
      : _value == val;
  }

  void select(dynamic val, [bool isSelected = true, Function callback]) {
    if (_isMultiChoice == true) {
      selectMultiple(val, isSelected);
    } else {
      selectSingle(val);
    }

    callback?.call();
  }

  void selectSingle(dynamic val) {
    _value = val;
    notifyListeners();
  }

  void selectMultiple(dynamic val, [bool isSelected = true]) {
    if (isSelected) {
      _value.add(val);
    } else {
      _value.remove(val);
    }
    notifyListeners();
  }
}
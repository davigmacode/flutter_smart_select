import 'package:flutter/foundation.dart';

class SmartSelectStateSelected<T> extends ChangeNotifier {

  final bool isMultiChoice;

  final bool useConfirmation;

  T _value;

  List<T> _values;

  // SmartSelectStateSelected(
  //   this._value, {
  //   this.isMultiChoice,
  //   this.useConfirmation,
  // });

  SmartSelectStateSelected.single(
    this._value, {
      this.useConfirmation = false
    }
  ) : this.isMultiChoice = false;

  SmartSelectStateSelected.multiple(
    this._values, {
      this.useConfirmation
    }
  ) : this.isMultiChoice = true;

  T get value => _value;
  List<T> get values => _values;

  bool contains(T val) {
    return isMultiChoice == true
      ? _values?.contains(val) ?? false
      : _value == val;
  }

  void select(T val, [bool isSelected = true, Function callback]) {
    if (isMultiChoice == true) {
      selectMultiple(val, isSelected);
    } else {
      selectSingle(val);
    }

    callback?.call();
  }

  void selectSingle(T val) {
    _value = val;
    notifyListeners();
  }

  void selectMultiple(T val, [bool isSelected = true]) {
    if (isSelected) {
      _values.add(val);
    } else {
      _values.remove(val);
    }
    notifyListeners();
  }
}
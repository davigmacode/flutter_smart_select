import 'package:flutter/foundation.dart';
import '../model/choice_item.dart';

abstract class S2Changes<T> extends ChangeNotifier {

  /// check whether the current value has the requested value
  bool contains(S2Choice<T> val);

  /// select value
  void commit(S2Choice<T> val, { bool selected = true });

  /// get length of selected value
  int get length;

}

class S2SingleChanges<T> extends S2Changes<T> {

  S2Choice<T> _value;

  S2Choice<T> get value => _value;

  S2SingleChanges(this._value);

  int get length => _value != null ? 1 : 0;

  set value(S2Choice<T> val) {
    _value = val;
    notifyListeners();
  }

  void commit(S2Choice<T> val, { bool selected = true }) {
    _value = val;
    notifyListeners();
  }

  bool contains(S2Choice<T> val) {
    return _value == val;
  }

}

class S2MultiChanges<T> extends S2Changes<T> {

  List<S2Choice<T>> _value;

  List<S2Choice<T>> get value => _value;

  S2MultiChanges(List<S2Choice<T>> val) : _value = val ?? [];

  int get length => _value?.length ?? 0;

  set value(List<S2Choice<T>> val) {
    _value = List<S2Choice<T>>.from(val);
    notifyListeners();
  }

  void commit(S2Choice<T> val, { bool selected = true }) {
    if (selected) {
      _value.add(val);
    } else {
      _value.remove(val);
    }
    notifyListeners();
  }

  bool contains(S2Choice<T> val) {
    return _value?.contains(val) ?? false;
  }

}
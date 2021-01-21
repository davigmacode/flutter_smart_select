import 'package:flutter/foundation.dart';

/// Validation callback
typedef String ValidationCallback<T>(T value);

/// State of value changes
abstract class S2Selection<T> extends ChangeNotifier {
  /// initial selection value
  covariant var initial;

  /// validation function used to validate value changes
  covariant var validation;

  /// reset the current selection to the initial value
  void reset();

  /// check whether the current value has the requested value
  bool has(T val);

  /// select or unselect a value
  void select(T val, {bool selected = true});

  /// removes all values from the selection
  void clear();

  /// validate value by validation function
  void validate();

  /// Validation error message
  String error = '';

  /// whether the changes value is valid or not
  bool get valid => error == null || error?.length == 0;

  /// get length of selected value
  int get length;

  /// returns true if there are no values in the selection
  bool get isEmpty;

  /// returns true if there is at least one value in the selection
  bool get isNotEmpty;
}

/// State of value changes of single choice widget
class S2SingleSelection<T> extends S2Selection<T> {
  /// initial selection value
  @override
  final T initial;

  /// validation function used to validate value changes
  @override
  final ValidationCallback<T> validation;

  /// default constructor
  S2SingleSelection({
    @required this.initial,
    this.validation,
  }) : _value = initial;

  /// current selected value
  T _value;

  /// get current selected value
  T get value => _value;

  /// override current value to new value
  set value(T val) {
    _value = val;
    validate();
  }

  /// reset the current selection to the initial value
  @override
  void reset() {
    value = initial;
  }

  /// get length of selected value
  @override
  int get length => _value != null ? 1 : 0;

  /// returns true if there are no values in the selection
  @override
  bool get isEmpty => _value == null;

  /// returns true if there is at least one value in the selection
  @override
  bool get isNotEmpty => _value != null;

  /// select or unselect a value
  @override
  void select(T val, {bool selected = true}) {
    _value = val;
    validate();
  }

  /// removes all values from the selection
  @override
  void clear() {
    value = null;
  }

  /// validate value by validation function
  @override
  void validate() {
    error = validation?.call(value) ?? '';
    notifyListeners();
  }

  /// check whether the current value has the requested value
  @override
  bool has(T val) {
    return _value == val;
  }
}

/// State of value changes of multiple choice widget
class S2MultiSelection<T> extends S2Selection<T> {
  /// initial selection value
  @override
  final List<T> initial;

  /// validation function used to validate value changes
  final ValidationCallback<List<T>> validation;

  /// default constructor
  S2MultiSelection({
    @required this.initial,
    this.validation,
  }) : _value = List.from(initial);

  /// current selected value
  List<T> _value;

  /// get current selected value
  List<T> get value => _value;

  /// override current value to new value
  set value(List<T> val) {
    _value = List<T>.from(val ?? []);
    validate();
  }

  /// reset the current selection to the initial value
  @override
  void reset() {
    value = List.from(initial);
  }

  /// get length of selected value
  @override
  int get length => _value?.length ?? 0;

  /// returns true if there are no values in the selection
  @override
  bool get isEmpty => _value?.isEmpty;

  /// returns true if there is at least one value in the selection
  @override
  bool get isNotEmpty => _value?.isNotEmpty;

  /// add every value in supplied values into the selection
  void merge(List<T> values) {
    value = List.from(value)
      ..addAll(values)
      ..toSet()
      ..toList();
  }

  /// removes every value in supplied values from the selection
  void omit(List<T> values) {
    value = List.from(value)..removeWhere((e) => values.contains(e));
  }

  /// toggle put/pull the supplied values from the selection
  void toggle(List<T> values, {bool pull}) {
    if (pull == true) {
      omit(values);
    } else if (pull == false) {
      merge(values);
    } else {
      if (hasAny(values))
        omit(values);
      else
        merge(values);
    }
  }

  /// select or unselect a value
  @override
  void select(T val, {bool selected = true}) {
    if (selected) {
      _value.add(val);
    } else {
      _value.remove(val);
    }
    validate();
  }

  /// removes all values from the selection
  @override
  void clear() {
    value = null;
  }

  /// validate value by validation function
  @override
  void validate() {
    error = validation?.call(value) ?? '';
    notifyListeners();
  }

  /// check whether the selection values has the supplied value
  @override
  bool has(T val) {
    return _value?.contains(val) ?? false;
  }

  /// check whether the selection values has any of the supplied values
  bool hasAny(List<T> values) {
    return values.any((e) => has(e));
  }

  /// check whether the selection values has every of the supplied values
  bool hasAll(List<T> values) {
    return values.every((e) => has(e));
  }
}

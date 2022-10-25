import 'package:flutter/foundation.dart';
import '../model/choice_item.dart';

/// State of choice(s) selection
abstract class S2Selection<T> extends ChangeNotifier {
  /// The initial selection
  covariant var initial;

  /// A Function used to validate the selection(s)
  covariant var validation;

  /// Reset the current selection to the initial selection
  void reset();

  /// Returns `true` if the selection contains the supplied choice(s)
  bool has(S2Choice<T> choice);

  /// Select or unselect a choice
  void select(S2Choice<T> choice, {bool selected = true});

  /// Removes all choice(s) from the selection
  void clear();

  /// Validate the selection
  void validate() {
    error = validation?.call(choice) ?? '';
    notifyListeners();
  }

  /// Validation error message
  String error = '';

  /// Returns true when the selection is valid
  bool get isValid => error.isEmpty;

  /// Returns true when the selection is not valid
  bool get isNotValid => isValid != true;

  /// Returns length of the selection
  int get length;

  /// Returns true if there are no values in the selection
  bool get isEmpty;

  /// Returns true if there is at least one value in the selection
  bool get isNotEmpty;

  /// Returns choice(s) in the current selection
  get choice;

  /// Override choice(s) in the current selection with a new value(s), and validate it
  set choice(covariant var choice);

  get value;

  get title;

  get subtitle;

  get group;

  /// Returns a string that can be used as display,
  /// returns error message if is not valid,
  /// returns title if is valid and is not empty.
  @override
  String toString();
}

/// State of single choice selection
class S2SingleSelection<T> extends S2Selection<T> {
  /// The initial selection
  @override
  final S2Choice<T>? initial;

  /// A function used to validate the selection
  @override
  final S2Validation<S2Choice<T>>? validation;

  /// Default constructor
  S2SingleSelection({
    required this.initial,
    this.validation,
  }) : _choice = initial;

  /// The choice of the current selection
  S2Choice<T>? _choice;

  @override
  S2Choice<T>? get choice => _choice;

  @override
  set choice(S2Choice<T>? val) {
    _choice = val;
    validate();
  }

  /// return [choice.value]
  @override
  T? get value {
    return choice?.value;
  }

  /// return [choice.title]
  @override
  String? get title {
    return choice?.title;
  }

  /// return [choice.subtitle]
  @override
  String? get subtitle {
    return choice?.subtitle;
  }

  /// return [choice.group]
  @override
  String? get group {
    return choice?.group;
  }

  @override
  void reset() {
    choice = initial;
  }

  @override
  int get length => _choice != null ? 1 : 0;

  @override
  bool get isEmpty => _choice == null;

  @override
  bool get isNotEmpty => _choice != null;

  @override
  void select(S2Choice<T> choice, {bool selected = true}) {
    _choice = choice;
    validate();
  }

  @override
  void clear() {
    choice = null;
  }

  @override
  bool has(S2Choice<T> choice) {
    return _choice == choice;
  }

  @override
  String toString() {
    return isValid == true ? (title ?? '') : error;
  }
}

/// State of multiple choice selection
class S2MultiSelection<T> extends S2Selection<T> {
  /// The Initial selection
  @override
  final List<S2Choice<T>> initial;

  /// A function used to validate the selection
  @override
  final S2Validation<List<S2Choice<T>>>? validation;

  /// Default constructor
  S2MultiSelection({
    required List<S2Choice<T>>? initial,
    this.validation,
  })  : initial = List.from(initial ?? []),
        _choice = List.from(initial ?? []);

  /// The choice(s) of the current selection
  List<S2Choice<T>> _choice;

  @override
  List<S2Choice<T>> get choice => _choice;

  @override
  set choice(List<S2Choice<T>>? choice) {
    _choice = List<S2Choice<T>>.from(choice ?? []);
    validate();
  }

  /// return an array of `value` of the current [choice] selection
  @override
  List<T> get value {
    return choice.isNotEmpty
        ? choice.map((S2Choice<T> item) => item.value).toList()
        : [];
  }

  /// return an array of `title` of the selected [choice]
  @override
  List<String?>? get title {
    return isNotEmpty
        ? choice.map((S2Choice<T> item) => item.title).toList()
        : null;
  }

  /// return an array of `subtitle` of the selected [choice]
  @override
  List<String?>? get subtitle {
    return isNotEmpty
        ? choice.map((S2Choice<T> item) => item.subtitle).toList()
        : null;
  }

  /// return an array of `group` of the selected [choice]
  @override
  List<String?>? get group {
    return isNotEmpty
        ? choice.map((S2Choice<T> item) => item.group).toList()
        : null;
  }

  @override
  void reset() {
    choice = List.from(initial);
  }

  @override
  int get length => _choice.length;

  @override
  bool get isEmpty => _choice.isEmpty;

  @override
  bool get isNotEmpty => _choice.isNotEmpty;

  /// Add every value in supplied values into the selection
  void merge(List<S2Choice<T>> choices) {
    choice = List.from(choice)
      ..addAll(choices)
      ..toSet()
      ..toList();
  }

  /// Removes every value in supplied values from the selection
  void omit(List<S2Choice<T>> choices) {
    choice = List.from(choice)..removeWhere((e) => choices.contains(e));
  }

  /// Toggle put/pull the supplied values from the selection
  void toggle(List<S2Choice<T>> choices, {bool? pull}) {
    if (pull == true) {
      omit(choices);
    } else if (pull == false) {
      merge(choices);
    } else {
      if (hasAny(choices)) {
        omit(choices);
      } else {
        merge(choices);
      }
    }
  }

  @override
  void select(S2Choice<T> choice, {bool selected = true}) {
    if (selected) {
      _choice.add(choice);
    } else {
      _choice.remove(choice);
    }
    validate();
  }

  @override
  void clear() {
    choice = null;
  }

  @override
  bool has(S2Choice<T> choice) {
    return _choice.contains(choice);
  }

  /// Returns `true` if the selection has any of the supplied values
  bool hasAny(List<S2Choice<T>> choices) {
    return choices.any((e) => has(e));
  }

  /// Returns `true if the selection has every of the supplied values
  bool hasAll(List<S2Choice<T>> choices) {
    return choices.every((e) => has(e));
  }

  @override
  String toString() {
    return isValid == true ? (title?.join(', ') ?? '') : error;
  }
}

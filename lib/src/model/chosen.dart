import 'package:flutter/widgets.dart';
import 'choice_item.dart';

/// Function to return a single [S2Choice] from a single `value`
typedef Future<S2Choice<T>?> S2SingleSelectedResolver<T>(T value);

/// Function to return a `List` of [S2Choice] from a `List` of `value`
typedef Future<List<S2Choice<T>>?> S2MultiSelectedResolver<T>(List<T>? value);

/// Chosen data class
abstract class S2ChosenData<T> {
  /// Returns the choice item(s)
  get choice;

  /// Returns the value(s) data
  get value;

  /// Returns the title(s) data
  get title;

  /// Returns the subtitle(s) data
  get subtitle;

  /// Returns the group(s) data
  get group;

  /// Returns the length of the [choice]
  int get length;

  /// Returns `true` if there are no values in the chosen data
  bool get isEmpty;

  /// Returns `true` if there is at least one value in the chosen data
  bool get isNotEmpty;

  /// Returns `true` if the chosen contains the supplied choice item
  bool has(S2Choice<T> choice);

  /// Returns `true` if the chosen has any of the supplied choice items
  bool hasAny(List<S2Choice<T>> choices);

  /// Returns `true if the chosen has every of the supplied choice items
  bool hasAll(List<S2Choice<T>> choices);

  /// Returns a string that can be used as display,
  /// returns title if is valid and is not empty,
  /// returns placeholder if is valid and is empty.
  String toString();

  /// Return a [Text] widget from [toString]
  Widget toWidget() => Text(toString());
}

/// Chosen data for single choice widget
mixin S2SingleChosenData<T> on S2ChosenData<T> {
  /// Returns [choice.value]
  @override
  T? get value {
    return choice?.value;
  }

  /// Returns [choice.title]
  @override
  String? get title {
    return choice?.title;
  }

  /// Returns [choice.subtitle]
  @override
  String? get subtitle {
    return choice?.subtitle;
  }

  /// Returns [choice.group]
  @override
  String? get group {
    return choice?.group;
  }

  @override
  String toString() {
    return title!;
  }

  @override
  int get length => choice != null ? 1 : 0;

  @override
  bool get isEmpty => choice == null;

  @override
  bool get isNotEmpty => choice != null;

  @override
  bool has(S2Choice<T> choice) {
    return this.choice == choice;
  }

  @override
  bool hasAny(List<S2Choice<T>> choices) {
    throw UnsupportedError('S2SingleChosen is not supported "hasAny" method');
  }

  @override
  bool hasAll(List<S2Choice<T>> choices) {
    throw UnsupportedError('S2SingleChosen is not supported "hasAll" method');
  }
}

/// Chosen data for single choice widget
mixin S2MultiChosenData<T> on S2ChosenData<T> {
  /// Returns an array of `value` of the current [choice]
  @override
  List<T>? get value {
    return choice != null && choice.length > 0
        ? choice.map((S2Choice<T> item) => item.value).toList().cast<T>()
        : [];
  }

  /// Returns an array of `title` of the [choice]
  @override
  List<String>? get title {
    return isNotEmpty
        ? choice.map((S2Choice<T> item) => item.title).toList().cast<String>()
        : null;
  }

  /// Returns an array of `subtitle` of the [choice]
  @override
  List<String>? get subtitle {
    return isNotEmpty
        ? choice
            .map((S2Choice<T> item) => item.subtitle)
            .toList()
            .cast<String>()
        : null;
  }

  /// Returns an array of `group` of the [choice]
  @override
  List<String>? get group {
    return isNotEmpty
        ? choice.map((S2Choice<T> item) => item.group).toList().cast<String>()
        : null;
  }

  @override
  String toString() {
    if (title == null) {
      return '';
    }
    return title!.join(', ');
  }

  @override
  int get length => choice?.length ?? 0;

  @override
  bool get isEmpty => length == 0;

  @override
  bool get isNotEmpty => length > 0;

  @override
  bool has(S2Choice<T> choice) {
    return this.choice?.contains(choice) ?? false;
  }

  /// Returns `true` if the selection has any of the supplied values
  bool hasAny(List<S2Choice<T>> choices) {
    return choices.any((e) => has(e));
  }

  /// Returns `true if the selection has every of the supplied values
  bool hasAll(List<S2Choice<T>> choices) {
    return choices.every((e) => has(e));
  }
}

class S2SingleChosen<T> extends S2ChosenData<T> with S2SingleChosenData<T> {
  /// Default constructor
  S2SingleChosen(S2Choice<T>? choice) : _choice = choice;

  /// The choice item
  final S2Choice<T>? _choice;

  @override
  S2Choice<T>? get choice {
    return _choice;
  }
}

class S2MultiChosen<T> extends S2ChosenData<T> with S2MultiChosenData<T> {
  /// Default constructor
  S2MultiChosen(List<S2Choice<T>>? choice) : _choice = choice;

  /// The choice item
  final List<S2Choice<T>>? _choice;

  @override
  List<S2Choice<T>>? get choice {
    return _choice;
  }
}

abstract class S2ChosenNotifier<T> extends ChangeNotifier with S2ChosenData<T> {
  /// A Function used to validate the selection(s)
  covariant var validation;

  /// Validation error message
  String error = '';

  /// Returns true when the selection is valid
  bool get isValid => error.isEmpty;

  /// Returns true when the selection is not valid
  bool get isNotValid => isValid != true;

  /// Validate the selection
  void validate();

  /// Validate the selection
  // void validate() {
  //   error = validation?.call(choice) ?? '';
  //   notifyListeners();
  // }
}

mixin S2SingleChosenNotifier<T> on S2ChosenNotifier<T> {
  /// A function used to validate the selection
  @override
  S2Validation<S2SingleChosen<T>>? validation;

  /// Validate the selection
  @override
  void validate() {
    error = validation?.call(S2SingleChosen(choice)) ?? '';
    notifyListeners();
  }
}

mixin S2MultiChosenNotifier<T> on S2ChosenNotifier<T> {
  /// A function used to validate the selection
  @override
  S2Validation<S2MultiChosen<T>>? validation;

  /// Validate the selection
  @override
  void validate() {
    error = validation?.call(S2MultiChosen(choice)) ?? '';
    notifyListeners();
  }
}

/// State of the selected choice
abstract class S2Selected<T> extends S2ChosenNotifier<T> {
  /// A `String` to return in `toString` if the `title` is empty
  String? placeholder;

  /// Function to resolve [choice] from [value]
  covariant var resolver;

  /// Returns `true` if [choice] is not `null`
  bool get isResolved => choice != null;

  /// Returns `true` if one of [choice] or [value] is `null`
  bool get isNotResolved => isResolved != true;

  /// Returns `true` when [choice] is resolving in the background
  bool isResolving = false;

  /// Resolve [choice] from [value] using user defined [resolver],
  /// or fallback to [defaultResolver] if [resolver] is not defined
  resolve();

  /// Override the selected choice with a new one, and validate it
  set choice(covariant var choice);

  /// Override the selected value with a new one, and validate it
  set value(covariant var value);
}

class S2SingleSelected<T> extends S2Selected<T> with S2SingleChosenData<T> {
  /// Default constructor
  S2SingleSelected({
    T? value,
    S2Choice<T>? choice,
    this.resolver,
    this.validation,
    this.placeholder,
  })  : _value = value,
        _choice = choice;

  T? _value;

  S2Choice<T?>? _choice;

  /// a `String` to return in `toString` if the `title` is empty
  @override
  final String? placeholder;

  /// A function used to validate the selection
  @override
  final S2Validation<S2SingleChosen<T?>>? validation;

  @override
  void validate() {
    error = validation?.call(S2SingleChosen(choice)) ?? '';
    notifyListeners();
  }

  /// Function to resolve [choice] from [value]
  @override
  S2SingleSelectedResolver<T?>? resolver;

  @override
  void resolve({
    S2SingleSelectedResolver<T?>? defaultResolver,
  }) async {
    if (isResolved) return null;

    isResolving = true;
    resolver = resolver ?? defaultResolver;
    notifyListeners();

    try {
      _choice = await resolver?.call(_value);
    } catch (e) {
      throw e;
    } finally {
      isResolving = false;
      validate();
    }
  }

  @override
  set choice(S2Choice<T?>? val) {
    _choice = val;
    _value = null;
    validate();
  }

  @override
  set value(T? val) {
    _value = val;
    _choice = null;
    resolve();
  }

  /// Returns a single selected [S2Choice]
  @override
  S2Choice<T?>? get choice {
    return _choice;
  }

  /// Returns [choice.value]
  @override
  T? get value {
    return choice?.value ?? _value;
  }

  @override
  String toString() {
    return isResolving == true
        ? 'Resolving'
        : isValid == true
            ? title ?? placeholder ?? 'Select one'
            : error;
  }
}

class S2MultiSelected<T> extends S2Selected<T> with S2MultiChosenData<T> {
  /// Default Constructor
  S2MultiSelected({
    List<T>? value,
    List<S2Choice<T>>? choice,
    this.resolver,
    this.validation,
    this.placeholder,
  })  : _value = List<T>.from(value ?? []),
        _choice = choice != null ? List<S2Choice<T>>.from(choice) : null;

  List<T>? _value;

  List<S2Choice<T>>? _choice;

  /// A `String` to return in `toString` if the `title` is empty
  @override
  final String? placeholder;

  /// A function used to validate the selection
  final S2Validation<S2MultiChosen<T>>? validation;

  @override
  void validate() {
    error = validation?.call(S2MultiChosen(choice)) ?? '';
    notifyListeners();
  }

  /// Function to resolve [choice] from [value]
  @override
  S2MultiSelectedResolver<T>? resolver;

  @override
  void resolve({
    S2MultiSelectedResolver<T>? defaultResolver,
  }) async {
    if (isResolved) return null;

    isResolving = true;
    resolver = resolver ?? defaultResolver;
    notifyListeners();

    try {
      _choice = await resolver?.call(_value);
    } catch (e) {
      throw e;
    } finally {
      isResolving = false;
      validate();
    }
  }

  @override
  set choice(List<S2Choice<T>>? choices) {
    _choice = List<S2Choice<T>>.from(choices ?? []);
    _value = null;
    validate();
  }

  @override
  set value(List<T>? val) {
    _value = List<T>.from(val ?? []);
    _choice = null;
    resolve();
  }

  /// return an array of the selected [S2Choice]
  @override
  List<S2Choice<T>>? get choice {
    return _choice;
  }

  /// return an array of `value` of the selected [choice]
  @override
  List<T>? get value {
    return isNotEmpty
        ? choice!.map((S2Choice<T> item) => item.value).toList()
        : _value;
  }

  @override
  String toString() {
    return isResolving == true
        ? 'Resolving'
        : isValid == true
            ? title?.join(', ') ?? placeholder ?? 'Select one or more'
            : error;
  }
}

abstract class S2Selection<T> extends S2ChosenNotifier<T> {
  /// The initial selection
  covariant var initial;

  /// Override choice(s) in the current selection with a new value(s), and validate it
  set choice(covariant var choice);

  /// Select or unselect a choice
  void select(S2Choice<T> choice, {bool selected = true});

  /// Reset the current selection to the initial selection
  void reset();

  /// Removes all choice(s) from the selection
  void clear();
}

class S2SingleSelection<T> extends S2Selection<T> with S2SingleChosenData<T> {
  /// The initial selection
  @override
  final S2Choice<T>? initial;

  /// A function used to validate the selection
  @override
  final S2Validation<S2SingleChosen<T>>? validation;

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
  void validate() {
    error = validation?.call(S2SingleChosen(choice)) ?? '';
    notifyListeners();
  }

  @override
  set choice(S2Choice<T>? val) {
    _choice = val;
    validate();
  }

  @override
  String toString() {
    return isValid == true ? (title ?? '') : error;
  }

  @override
  void select(S2Choice<T> choice, {bool selected = true}) {
    _choice = choice;
    validate();
  }

  @override
  void reset() {
    choice = initial;
  }

  @override
  void clear() {
    choice = null;
  }
}

class S2MultiSelection<T> extends S2Selection<T> with S2MultiChosenData<T> {
  /// The Initial selection
  @override
  final List<S2Choice<T>> initial;

  /// A function used to validate the selection
  final S2Validation<S2MultiChosen<T>>? validation;

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
  void validate() {
    error = validation?.call(S2MultiChosen(choice)) ?? '';
    notifyListeners();
  }

  @override
  set choice(List<S2Choice<T>>? choice) {
    _choice = List<S2Choice<T>>.from(choice ?? []);
    validate();
  }

  @override
  String toString() {
    return isValid == true ? (title?.join(', ') ?? '') : error;
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
  void reset() {
    choice = List.from(initial);
  }

  @override
  void clear() {
    choice = null;
  }

  /// Add every value in supplied values into the selection
  void merge(List<S2Choice<T>> choices) {
    choice = List.from(choice)
      ..addAll(choices)
      ..toSet()
      ..toList();
  }

  /// Removes every value in supplied values from the selection
  void omit(List<S2Choice<T>>? choices) {
    choice = List.from(choice)..removeWhere((e) => choices!.contains(e));
  }

  /// Toggle put/pull the supplied values from the selection
  void toggle(List<S2Choice<T>> choices, {bool? pull}) {
    if (pull == true) {
      omit(choices);
    } else if (pull == false) {
      merge(choices);
    } else {
      if (hasAny(choices))
        omit(choices);
      else
        merge(choices);
    }
  }
}

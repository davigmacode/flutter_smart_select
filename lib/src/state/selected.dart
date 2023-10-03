import 'package:flutter/widgets.dart';
import '../model/choice_item.dart';

/// Function to return a single [S2Choice] from a single `value`
typedef Future<S2Choice<T>> S2SingleSelectedResolver<T>(T value);

/// Function to return a `List` of [S2Choice] from a `List` of `value`
typedef Future<List<S2Choice<T>>> S2MultiSelectedResolver<T>(List<T>? value);

/// State of the selected choice
abstract class S2Selected<T> extends ChangeNotifier {
  /// A `String` to return in `toString` if the `title` is empty
  String? placeholder;

  /// Function to resolve [choice] from [value]
  covariant var resolver;

  /// A Function used to validate the selection(s)
  covariant var validation;

  /// Returns the length of the [choice]
  int get length;

  /// Returns `true` if there are no values in the selection
  bool get isEmpty;

  /// Returns `true` if there is at least one value in the selection
  bool get isNotEmpty;

  /// Override the selected choice with a new one, and validate it
  set choice(covariant var choice);

  /// Override the selected value with a new one, and validate it
  set value(covariant var value);

  get choice;

  get value;

  get title;

  get subtitle;

  get group;

  /// validate the selected
  void validate() {
    error = validation?.call(choice) ?? '';
    notifyListeners();
  }

  /// Validation error message
  String error = '';

  /// Returns `true` when the selected is valid
  bool get isValid => error == null || error?.length == 0;

  /// Returns `true` when the selected is not valid
  bool get isNotValid => isValid != true;

  /// Returns `true` if [choice] is not `null`
  bool get isResolved => choice != null;

  /// Returns `true` if one of [choice] or [value] is `null`
  bool get isNotResolved => isResolved != true;

  /// Returns `true` when [choice] is resolving in the background
  bool isResolving = false;

  /// Resolve [choice] from [value] using user defined [resolver],
  /// or fallback to [defaultResolver] if [resolver] is not defined
  resolve();

  // /// Creates a copy of this [S2Selected] but with
  // /// the given fields replaced with the new values.
  // copyWith();

  // /// Returns a new [S2Selected] that is
  // /// a combination of this object and the given [other] style.
  // merge(covariant S2Selected<T> other);

  /// Returns a string that can be used as display,
  /// returns error message if is not valid,
  /// returns title if is valid and is not empty,
  /// returns placeholder if is valid and is empty.
  String toString();

  /// Return a [Text] widget from [toString]
  Widget toWidget() => Text(toString());
}

/// State of single selected choice
class S2SingleSelected<T> extends S2Selected<T> {
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

  /// Function to resolve [choice] from [value]
  @override
  S2SingleSelectedResolver<T?>? resolver;

  /// A function used to validate the selection
  @override
  final S2Validation<S2Choice<T>>? validation;

  /// a `String` to return in `toString` if the `title` is empty
  @override
  final String? placeholder;

  @override
  int get length => choice != null ? 1 : 0;

  @override
  bool get isEmpty => choice == null;

  @override
  bool get isNotEmpty => choice != null;

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

  /// return a single selected [S2Choice]
  @override
  S2Choice<T?>? get choice {
    return _choice;
  }

  /// return [choice.value]
  @override
  T? get value {
    return choice?.value ?? _value;
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
  String toString() {
    return isResolving == true
        ? 'Resolving'
        : isValid == true
            ? title ?? placeholder ?? 'Select one'
            : error;
  }
}

/// State of multiple selected choice
class S2MultiSelected<T> extends S2Selected<T> {
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

  /// Function to resolve [choice] from [value]
  @override
  S2MultiSelectedResolver<T>? resolver;

  /// A function used to validate the selection
  final S2Validation<List<S2Choice<T>>>? validation;

  /// a `String` to return in `toString` if the `title` is empty
  @override
  final String? placeholder;

  @override
  int get length => choice?.length ?? 0;

  @override
  bool get isEmpty => choice == null || choice?.isEmpty == true;

  @override
  bool get isNotEmpty => choice != null && choice?.isNotEmpty == true;

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

  /// return an array of `title` of the selected [choice]
  @override
  List<String>? get title {
    return isNotEmpty
        ? choice!.map((S2Choice<T> item) => item.title).toList()
        : null;
  }

  /// return an array of `subtitle` of the selected [choice]
  @override
  List<String?>? get subtitle {
    return isNotEmpty
        ? choice!.map((S2Choice<T> item) => item.subtitle).toList()
        : null;
  }

  /// return an array of `group` of the selected [choice]
  @override
  List<String?>? get group {
    return isNotEmpty
        ? choice!.map((S2Choice<T> item) => item.group).toList()
        : null;
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

import 'package:flutter/foundation.dart';
import '../model/choice_item.dart';
import '../model/choice_loader.dart';
import '../model/group_data.dart';
import '../model/group_config.dart';

enum S2ChoicesTask {
  /// indicates the choices try to loading items at the first time
  init,
  /// indicates the choices try to refreshing items
  reload,
  /// indicates the choices try to appending items
  append,
}

/// State of the choices data
class S2Choices<T> extends ChangeNotifier {

  /// A function used to load choice items
  final S2ChoiceLoader<T> loader;

  /// The initial choice items
  final List<S2Choice<T>> preload;

  /// Delay
  final Duration delay;

  /// The choice items limit per page
  final int limit;

  /// Current page number
  int page = 1;

  /// Current choice items
  List<S2Choice<T>> items;

  /// Current status of this
  S2ChoicesTask task;

  /// Error message occurs while loading the choice items
  Error error;

  /// Default constructor
  S2Choices({
    List<S2Choice<T>> items,
    this.loader,
    this.delay,
    this.limit,
  }) :
    this.preload = items;

  List<T> get values => items?.map((S2Choice<T> choice) => choice.value)?.toList();

  int get length => items?.length ?? 0;

  bool get isIdle => task == null;

  bool get isBusy => task != null;

  bool get isInitializing => task == S2ChoicesTask.init;

  bool get isReloading => task == S2ChoicesTask.reload;

  bool get isAppending => task == S2ChoicesTask.append;

  bool get isEmpty => items == null || items?.isEmpty == true;

  bool get isNotEmpty => items != null && items?.isNotEmpty == true;

  bool get isPreloaded => preload != null;

  bool get isSync => loader == null;

  bool get isAsync => loader != null;

  void initialize() => load(S2ChoicesTask.init);

  void reload({ String query }) => load(S2ChoicesTask.reload, query: query);

  void append({ String query }) => load(S2ChoicesTask.append, query: query);

  void load(S2ChoicesTask _task, { String query }) async {
    assert(_task != null);

    // skip the loader if the status busy
    if (isBusy) return null;

    final bool isInitializing = _task == S2ChoicesTask.init;
    final bool isAppending = _task == S2ChoicesTask.append;

    // skip the loader if the items already filled
    if (isInitializing && isNotEmpty) return null;

    task = _task;
    page = isAppending ? page + 1 : 1;
    notifyListeners();

    try {
      final List<S2Choice<T>> choices = await find(S2ChoiceLoaderInfo<T>(
        page: page,
        limit: limit,
        query: query,
      ));
      if (isAppending) {
        items.addAll(choices);
      } else {
        items = List.from(choices);
      }
    } catch (e) {
      if (isAppending) page--;
      error = e;
    } finally {
      await Future.delayed(delay ?? const Duration(milliseconds: 300), () {
        task = null;
        notifyListeners();
      });
    }
  }

  /// Return a list of options
  Future<List<S2Choice<T>>> find(S2ChoiceLoaderInfo<T> info) async {
    return isAsync
      ? hide(await loader(info))
      : filter(hide(preload), info.query);
  }

  /// Filter choice items by search text
  List<S2Choice<T>> filter(List<S2Choice<T>> choices, String query) {
    return query != null
      ? choices
        .where((S2Choice<T> choice) => choice.contains(query))
        .toList().cast<S2Choice<T>>()
      : choices;
  }

  /// Removes hidden choice items
  List<S2Choice<T>> hide(List<S2Choice<T>> choices) {
    return choices..removeWhere((S2Choice<T> choice) => choice.hidden == true);
  }

  /// Returns a list of group
  List<S2Group<T>> groupItems(S2GroupConfig config) {
    if (groupKeys?.isEmpty == true) return null;

    final List<S2Group<T>> groups = groupKeys
      .map((String groupKey) => S2Group<T>(
        name: groupKey,
        choices: groupChoices(groupKey),
        headerStyle: config.headerStyle,
      ))
      .toList()
      .cast<S2Group<T>>();

    // sort the list when the comparator is provided
    if (config.sortBy != null)
      return groups..sort(config.sortBy.compare);

    return groups;
  }

  /// Returns a unique list of group keys
  List<String> get groupKeys {
    return items
      .map((S2Choice<T> choice) => choice.group)
      .toSet()
      .toList()
      .cast<String>();
  }

  /// Returns a list of group choice items
  List<S2Choice<T>> groupChoices(String key) {
    return items.where((S2Choice<T> choice) => choice.group == key).toList();
  }
}
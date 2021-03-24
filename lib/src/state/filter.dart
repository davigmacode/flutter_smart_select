import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// State of filter data
class S2Filter extends ChangeNotifier {
  bool _activated = false;

  String? _value;

  /// Text controller
  final TextEditingController ctrl = TextEditingController();

  /// Returns `true` if the filter is displayed
  bool get activated => _activated;

  /// Returns the current filter value
  String? get value => _value;

  @override
  void dispose() {
    // Clean up the filter controller when the widget is disposed.
    ctrl.dispose();
    super.dispose();
  }

  /// Show the filter and add history to route
  void show(BuildContext context) {
    // add history to route, so back button will appear
    // and when physical back button pressed
    // will close the searchbar instead of close the modal
    LocalHistoryEntry entry = LocalHistoryEntry(onRemove: stop);
    ModalRoute.of(context)!.addLocalHistoryEntry(entry);

    _activated = true;
    notifyListeners();
  }

  /// Hide the filter and remove history from route
  void hide(BuildContext context) {
    // close the filter
    stop();
    // remove filter from route history
    Navigator.pop(context);
  }

  /// Clear and close filter
  void stop() {
    _activated = false;
    clear();
  }

  /// Just clear the filter text
  void clear() {
    ctrl.clear();
    apply(null);
  }

  /// Apply new value to filter query
  void apply(String? val) {
    _value = val;
    notifyListeners();
  }
}

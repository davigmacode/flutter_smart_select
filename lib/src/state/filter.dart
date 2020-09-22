import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// state of filter data
class S2Filter extends ChangeNotifier {

  bool _activated = false;

  String _query;

  /// text controller
  final TextEditingController ctrl = TextEditingController();

  /// whether the filter is displayed or not
  bool get activated => _activated;

  /// current filter text value
  String get query => _query;

  @override
  void dispose() {
    // Clean up the filter controller when the widget is disposed.
    ctrl.dispose();
    super.dispose();
  }

  /// show the filter
  /// will add history to route
  void show(BuildContext context) {
    // add history to route, so back button will appear
    // and when physical back button pressed
    // will close the searchbar instead of close the modal
    LocalHistoryEntry entry = LocalHistoryEntry(onRemove: stop);
    ModalRoute.of(context).addLocalHistoryEntry(entry);

    _activated = true;
    notifyListeners();
  }

  /// hide the filter
  /// will remove history to route
  void hide(BuildContext context) {
    // close the filter
    stop();
    // remove filter from route history
    Navigator.pop(context);
  }

  /// clear and close filter
  void stop() {
    _activated = false;
    clear();
  }

  /// just clear the filter text
  void clear() {
    ctrl.clear();
    apply(null);
  }

  /// apply new value to filter query
  void apply(String val) {
    _query = val;
    notifyListeners();
  }

}
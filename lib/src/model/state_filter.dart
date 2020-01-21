import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class SmartSelectStateFilter extends ChangeNotifier {

  final TextEditingController ctrl = TextEditingController();

  bool _activated = false;

  String _query;

  bool get activated => _activated;

  String get query => _query;

  @override
  void dispose() {
    // Clean up the filter controller when the widget is disposed.
    ctrl.dispose();
    super.dispose();
  }

  void start() {
    _activated = true;
    notifyListeners();
  }

  void stop() {
    _activated = false;
    clear();
  }

  void clear() {
    ctrl.clear();
    setQuery(null);
  }

  void setQuery(String val) {
    _query = val;
    notifyListeners();
  }

}
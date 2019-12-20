import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './model/state_selected.dart';
import './model/state_filter.dart';

SmartSelectStateSelected getStateSelected(BuildContext context, [bool listen = false]) {
  return Provider.of<SmartSelectStateSelected>(context, listen: listen);
}

SmartSelectStateFilter getStateFilter(BuildContext context, [bool listen = false]) {
  return Provider.of<SmartSelectStateFilter>(context, listen: listen);
}
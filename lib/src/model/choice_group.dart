import 'package:flutter/foundation.dart';
import './choice_item.dart';
import './choice_theme.dart';

/// choice group data
@immutable
class S2ChoiceGroup with Diagnosticable {

  /// Group name
  final String name;

  /// Group choice items
  final List<S2Choice> items;

  /// Group choice items length
  final int count;

  /// Group style
  final S2ChoiceHeaderStyle style;

  /// default constructor
  S2ChoiceGroup({
    this.name,
    this.items,
    this.count,
    this.style,
  });

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is S2ChoiceGroup &&
      runtimeType == other.runtimeType &&
      name == other.name;

  @override
  int get hashCode => name.hashCode;
}
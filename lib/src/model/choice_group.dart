import './choice_theme.dart';

/// choice group data
class S2ChoiceGroup {

  /// Group name
  final String name;

  /// Group item length
  final int count;

  /// Group style
  final S2ChoiceHeaderStyle style;

  /// default constructor
  S2ChoiceGroup({
    this.name,
    this.count,
    this.style,
  });
}
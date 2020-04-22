import './option.dart';
import './choice_theme.dart';

class S2Choice<T> {

  /// Choice option data
  S2Option<T> data;

  /// Callback to select choice
  Function(bool selected) select;

  /// Whether the choice is selected or not
  bool selected;

  S2Choice({
    this.data,
    this.select,
    this.selected,
  });
}

class S2ChoiceGroup {

  /// Group name
  final String name;

  /// Group item length
  final int count;

  /// Group style
  final S2ChoiceHeaderStyle style;

  S2ChoiceGroup({
    this.name,
    this.count,
    this.style,
  });
}
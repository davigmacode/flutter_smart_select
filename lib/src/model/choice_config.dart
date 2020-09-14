import 'package:flutter/widgets.dart';
import './choice_theme.dart';

/// Type of choice input
enum S2ChoiceType {
  /// use radio widget
  /// for single choice
  radios,
  /// use checkbox widget
  /// for multiple choice
  checkboxes,
  /// use switch widget
  /// for multiple choice
  switches,
  /// use chip widget
  /// for single and multiple choice
  chips
}

/// Layout of choice item
enum S2ChoiceLayout {
  /// use list view widget
  list,
  /// use wrap view widget
  wrap,
  /// use grid view widget
  grid
}

/// Choices configuration
class S2ChoiceConfig {

  /// When [isMultiChoice] is true
  /// [choiceType] can use [S2ChoiceType.checkboxes]
  /// or [S2ChoiceType.switches] or [S2ChoiceType.chips]
  /// and when [isMultiChoice] is false
  /// [choiceType] can use [S2ChoiceType.radios]
  /// or [S2ChoiceType.chips]
  final S2ChoiceType type;

  /// choice list scroll direction
  /// currently only support when
  /// [layout] is [S2ChoiceLayout.wrap]
  final Axis direction;

  /// Choice list layout
  final S2ChoiceLayout layout;

  // Used if [layout] = [SmartSelectChoiceLayout.grid]
  final SliverGridDelegate gridDelegate;

  /// Whether the choices list is grouped
  final bool isGrouped;

  /// Whether the choices item use divider or not
  final bool useDivider;

  /// Custom color of the glowing indicator
  /// when overscroll the choices list
  final Color overscrollColor;

  /// Configure choices item style
  final S2ChoiceStyle style;

  /// Configure choices group header theme
  final S2ChoiceHeaderStyle headerStyle;

  /// Create choices configuration
  const S2ChoiceConfig({
    this.type,
    this.layout = S2ChoiceLayout.list,
    this.direction = Axis.vertical,
    this.gridDelegate,
    this.isGrouped = false,
    this.useDivider = false,
    this.overscrollColor,
    this.headerStyle = const S2ChoiceHeaderStyle(),
    this.style = const S2ChoiceStyle(),
  }) :
    // assert(type != null),
    // assert(layout != null),
    assert(isGrouped != null),
    assert(useDivider != null);

  /// Creates a copy of this [S2ChoiceConfig] but with
  /// the given fields replaced with the new values.
  S2ChoiceConfig copyWith({
    S2ChoiceType type,
    S2ChoiceLayout layout,
    SliverGridDelegate gridDelegate,
    Axis direction,
    bool isGrouped,
    bool useDivider,
    Color overscrollColor,
    S2ChoiceStyle style,
    S2ChoiceHeaderStyle headerStyle,
  }) {
    return S2ChoiceConfig(
      type: type ?? this.type,
      layout: layout ?? this.layout,
      gridDelegate: gridDelegate ?? this.gridDelegate,
      direction: direction ?? this.direction,
      isGrouped: isGrouped ?? this.isGrouped,
      useDivider: useDivider ?? this.useDivider,
      overscrollColor: overscrollColor ?? this.overscrollColor,
      style: style ?? this.style,
      headerStyle: headerStyle ?? this.headerStyle,
    );
  }

  /// Creates a copy of this [S2ChoiceConfig] but with
  /// the given fields replaced with the new values.
  S2ChoiceConfig merge(S2ChoiceConfig other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      type: other.type,
      layout: other.layout,
      gridDelegate: other.gridDelegate,
      direction: other.direction,
      isGrouped: other.isGrouped,
      useDivider: other.useDivider,
      overscrollColor: other.overscrollColor,
      style: other.style,
      headerStyle: other.headerStyle,
    );
  }
}
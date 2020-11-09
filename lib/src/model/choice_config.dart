import 'package:flutter/foundation.dart';
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
@immutable
class S2ChoiceConfig with Diagnosticable {

  /// Choice item widget type
  ///
  /// Single choice can't use [S2ChoiceType.checkboxes] and Multiple choice can't use [S2ChoiceType.radios]
  final S2ChoiceType type;

  /// Choice list layout
  final S2ChoiceLayout layout;

  /// Choice list scroll direction
  ///
  /// currently only support when [layout] is [S2ChoiceLayout.wrap]
  final Axis direction;

  /// How much space to place between children in a run in the main axis.
  ///
  /// When [type] is [S2ChoiceType.chips] or [layout] is [S2ChoiceLayout.wrap]
  final double spacing;

  /// How much space to place between the runs themselves in the cross axis.
  ///
  /// When [type] is [S2ChoiceType.chips] or [layout] is [S2ChoiceLayout.wrap]
  final double runSpacing;

  /// Choices wrapper padding
  final EdgeInsetsGeometry padding;

  /// Controls the layout of tiles in a grid.
  ///
  /// Used if [layout] is [S2ChoiceLayout.grid]
  final SliverGridDelegate gridDelegate;

  /// The number of children in the cross axis.
  ///
  /// Used if [layout] is [S2ChoiceLayout.grid]
  /// Ignored if [gridDelegate] is defined
  final int gridCount;

  /// Fill the [crossAxisSpacing] and [crossAxisSpacing] with single configuration
  ///
  /// Used if [layout] is [S2ChoiceLayout.grid]
  /// Ignored if [gridDelegate] is defined
  final double gridSpacing;

  /// Whether the choices list is grouped or not, based on [S2Choice.group]
  final bool isGrouped;

  /// Whether the choices item use divider or not
  final bool useDivider;

  /// The divider color
  final Color dividerColor;

  /// Spacing between divider widget and choice widget
  final double dividerSpacing;

  /// The divider thickness
  final double dividerThickness;

  /// Custom color of the glowing indicator when overscroll the choices list
  final Color overscrollColor;

  /// Configure unselected choices item style
  final S2ChoiceStyle style;

  /// Configure selected choices item style
  final S2ChoiceStyle activeStyle;

  /// Configure choices group header theme
  final S2ChoiceHeaderStyle headerStyle;

  /// Determines the physics of choices list widget
  final ScrollPhysics physics;

  /// Create choices configuration
  const S2ChoiceConfig({
    this.type,
    this.layout = S2ChoiceLayout.list,
    this.direction = Axis.vertical,
    this.spacing,
    this.runSpacing,
    this.padding,
    this.gridDelegate,
    this.gridCount = 2,
    this.gridSpacing = 0,
    this.isGrouped = false,
    this.useDivider = false,
    this.dividerColor,
    this.dividerSpacing,
    this.dividerThickness,
    this.overscrollColor,
    this.style,
    this.activeStyle,
    this.headerStyle = const S2ChoiceHeaderStyle(),
    this.physics = const ScrollPhysics(),
  }) :
    assert(isGrouped != null),
    assert(physics != null),
    assert(useDivider != null);

  /// Whether the [layout] is [S2ChoiceLayout.wrap] or [type] is [S2ChoiceType.chips]
  bool get isWrapLayout => layout == S2ChoiceLayout.wrap || type == S2ChoiceType.chips;

  /// Whether the [layout] is [S2ChoiceLayout.grid]
  bool get isGridLayout => layout == S2ChoiceLayout.grid;

  /// Whether the [layout] is [S2ChoiceLayout.list]
  bool get isListLayout => layout == S2ChoiceLayout.list;

  /// Creates a copy of this [S2ChoiceConfig] but with
  /// the given fields replaced with the new values.
  S2ChoiceConfig copyWith({
    S2ChoiceType type,
    S2ChoiceLayout layout,
    Axis direction,
    double spacing,
    double runSpacing,
    EdgeInsetsGeometry padding,
    SliverGridDelegate gridDelegate,
    int gridCount,
    double gridSpacing,
    bool isGrouped,
    bool useDivider,
    Color dividerColor,
    double dividerSpacing,
    double dividerThickness,
    Color overscrollColor,
    S2ChoiceStyle style,
    S2ChoiceStyle activeStyle,
    S2ChoiceHeaderStyle headerStyle,
    ScrollPhysics physics,
  }) {
    return S2ChoiceConfig(
      type: type ?? this.type,
      layout: layout ?? this.layout,
      direction: direction ?? this.direction,
      spacing: spacing ?? this.spacing,
      runSpacing: runSpacing ?? this.runSpacing,
      padding: padding ?? this.padding,
      gridDelegate: gridDelegate ?? this.gridDelegate,
      gridCount: gridCount ?? this.gridCount,
      gridSpacing: gridSpacing ?? this.gridSpacing,
      isGrouped: isGrouped ?? this.isGrouped,
      useDivider: useDivider ?? this.useDivider,
      dividerColor: dividerColor ?? this.dividerColor,
      dividerSpacing: dividerSpacing ?? this.dividerSpacing,
      dividerThickness: dividerThickness ?? this.dividerThickness,
      overscrollColor: overscrollColor ?? this.overscrollColor,
      style: this.style?.merge(style) ?? style,
      activeStyle: this.activeStyle?.merge(activeStyle) ?? activeStyle,
      headerStyle: this.headerStyle?.merge(headerStyle) ?? headerStyle,
      physics: physics ?? this.physics,
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
      direction: other.direction,
      spacing: other.spacing,
      runSpacing: other.runSpacing,
      padding: other.padding,
      gridDelegate: other.gridDelegate,
      gridCount: other.gridCount,
      gridSpacing: other.gridSpacing,
      isGrouped: other.isGrouped,
      useDivider: other.useDivider,
      dividerColor: other.dividerColor,
      dividerSpacing: other.dividerSpacing,
      dividerThickness: other.dividerThickness,
      overscrollColor: other.overscrollColor,
      style: other.style,
      activeStyle: other.activeStyle,
      headerStyle: other.headerStyle,
      physics: other.physics,
    );
  }
}
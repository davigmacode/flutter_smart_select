import 'package:flutter/widgets.dart';
import './option.dart';
import './choice_theme.dart';

/// Target to open choices list
enum SmartSelectChoiceType { radios, checkboxes, switches, chips }

/// A builder for custom display when choices is empty
typedef Widget SmartSelectChoiceEmptyBuilder(String query);

/// A builder for custom choices group header widget
typedef Widget SmartSelectChoiceGroupHeaderBuilder(
  String group,
  int count
);

// /// A builder for custom divider widget between choices item
// typedef Widget SmartSelectChoiceDividerBuilder(
//   BuildContext context,
//   int index
// );

/// A builder for custom choices item title
typedef Widget SmartSelectChoiceWidgetBuilder<T>(
  BuildContext context,
  SmartSelectOption<T> item
);

// /// A builder for custom choices item title
// typedef Widget SmartSelectChoiceTitleBuilder<T>(
//   BuildContext context,
//   SmartSelectOption<T> item
// );

// /// A builder for custom choices item subtitle
// typedef Widget SmartSelectChoiceSubtitleBuilder<T>(
//   BuildContext context,
//   SmartSelectOption<T> item
// );

// /// A builder for custom choices item secondary
// typedef Widget SmartSelectChoiceSecondaryBuilder<T>(
//   BuildContext context,
//   SmartSelectOption<T> item
// );

/// A builder for custom each choices item widget
typedef Widget SmartSelectChoiceBuilder<T>(
  SmartSelectOption<T> item,
  bool checked,
  SmartSelectChoiceOnSelect<T> onChange
);

/// Callback to handle change of each custom choices item
typedef void SmartSelectChoiceOnSelect<T>(
  T value,
  bool checked
);

/// Choices configuration
class SmartSelectChoiceConfig<T> {

  /// Whether the choices list is grouped
  final bool isGrouped;

  /// Whether the choices list use [Wrap] instead of [ListView]
  final bool useWrap;

  /// Whether the choices item use divider or not
  final bool useDivider;

  /// Custom color of the glowing indicator
  /// when overscroll the choices list
  final Color glowingOverscrollIndicatorColor;

  /// Configure choices item style
  final SmartSelectChoiceStyle style;

  /// Configure choices group header theme
  final SmartSelectChoiceGroupHeaderStyle groupHeaderStyle;

  /// Builder for each custom choices item
  final SmartSelectChoiceBuilder<T> builder;

  /// Builder for each custom choices item subtitle
  final SmartSelectChoiceWidgetBuilder<T> titleBuilder;

  /// Builder for each custom choices item subtitle
  final SmartSelectChoiceWidgetBuilder<T> subtitleBuilder;

  /// Builder for each custom choices item secondary
  final SmartSelectChoiceWidgetBuilder<T> secondaryBuilder;

  /// Builder for custom divider widget between choices item
  final IndexedWidgetBuilder dividerBuilder;

  /// Builder for custom choices group header widget
  final SmartSelectChoiceGroupHeaderBuilder groupHeaderBuilder;

  /// Builder for custom empty display
  final SmartSelectChoiceEmptyBuilder emptyBuilder;

  /// Create choices configuration
  const SmartSelectChoiceConfig({
    this.isGrouped = false,
    this.useDivider = false,
    this.useWrap = false,
    this.glowingOverscrollIndicatorColor = const Color(0xFF607D8B),
    this.groupHeaderStyle = const SmartSelectChoiceGroupHeaderStyle(),
    this.style = const SmartSelectChoiceStyle(),
    this.builder,
    this.titleBuilder,
    this.subtitleBuilder,
    this.secondaryBuilder,
    this.dividerBuilder,
    this.groupHeaderBuilder,
    this.emptyBuilder,
  });
}
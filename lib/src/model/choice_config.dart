import 'package:flutter/material.dart';
import './option_item.dart';
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

/// A builder for custom divider widget between choices item
typedef Widget SmartSelectChoiceDividerBuilder(
  BuildContext context,
  int index
);

/// A builder for custom choices item title
typedef Widget SmartSelectChoiceTitleBuilder(
  BuildContext context,
  SmartSelectOptionItem item
);

/// A builder for custom choices item subtitle
typedef Widget SmartSelectChoiceSubtitleBuilder(
  BuildContext context,
  SmartSelectOptionItem item
);

/// A builder for custom choices item secondary
typedef Widget SmartSelectChoiceSecondaryBuilder(
  BuildContext context,
  SmartSelectOptionItem item
);

/// A builder for custom each choices item widget
typedef Widget SmartSelectChoiceBuilder(
  SmartSelectOptionItem item,
  bool checked,
  SmartSelectChoiceOnSelect onChange
);

/// Callback to handle change of each custom choices item
typedef void SmartSelectChoiceOnSelect(
  dynamic value,
  bool checked
);

/// Choices configuration
class SmartSelectChoiceConfig {

  /// When [SmartSelect.isMultiChoice] is true
  /// [choice] can use [SmartSelectChoiceConfig.checkboxes]
  /// or [SmartSelectChoiceConfig.switches] or [SmartSelectChoiceConfig.chips]
  /// and when [SmartSelect.isMultiChoice] is false
  /// [choice] can use [SmartSelectChoiceConfig.radios]
  /// or [SmartSelectChoiceConfig.chips]
  final SmartSelectChoiceType type;

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
  final SmartSelectChoiceBuilder builder;

  /// Builder for each custom choices item subtitle
  final SmartSelectChoiceTitleBuilder titleBuilder;

  /// Builder for each custom choices item subtitle
  final SmartSelectChoiceSubtitleBuilder subtitleBuilder;

  /// Builder for each custom choices item secondary
  final SmartSelectChoiceSecondaryBuilder secondaryBuilder;

  /// Builder for custom divider widget between choices item
  final SmartSelectChoiceDividerBuilder dividerBuilder;

  /// Builder for custom choices group header widget
  final SmartSelectChoiceGroupHeaderBuilder groupHeaderBuilder;

  /// Builder for custom empty display
  final SmartSelectChoiceEmptyBuilder emptyBuilder;

  /// Create choices configuration
  const SmartSelectChoiceConfig({
    this.type,
    this.useDivider = false,
    this.useWrap = false,
    this.glowingOverscrollIndicatorColor = Colors.blueGrey,
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
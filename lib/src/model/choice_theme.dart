import 'package:flutter/painting.dart';
import 'dart:ui';

/// Where to place the control in widgets that use [ListTile] to position a
/// control next to a label.
///
/// See also:
///
///  * [CheckboxListTile], which combines a [ListTile] with a [Checkbox].
///  * [RadioListTile], which combines a [ListTile] with a [Radio] button.
enum S2ChoiceControl {
  /// Position the control on the leading edge, and the secondary widget, if
  /// any, on the trailing edge.
  leading,

  /// Position the control on the trailing edge, and the secondary widget, if
  /// any, on the leading edge.
  trailing,

  /// Position the control relative to the text in the fashion that is typical
  /// for the current platform, and place the secondary widget on the opposite
  /// side.
  platform,
}

/// Configure choices group header style
class S2ChoiceHeaderStyle {

  /// Group header background color
  final Color backgroundColor;

  /// Highlight color
  final Color highlightColor;

  /// Group header text style
  final TextStyle textStyle;

  /// Group header padding
  final EdgeInsetsGeometry padding;

  /// Group header height
  final double height;

  /// Create a configuration of choices group header style
  const S2ChoiceHeaderStyle({
    this.highlightColor,
    this.backgroundColor = const Color(0xFFECEFF1),
    this.textStyle = const TextStyle(color: Color(0x8A000000)),
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.height = 45.0,
  });

  /// Creates a copy of this [S2ChoiceHeaderStyle] but with
  /// the given fields replaced with the new values.
  S2ChoiceHeaderStyle copyWith({
    Color backgroundColor,
    Color highlightColor,
    TextStyle textStyle,
    EdgeInsetsGeometry padding,
    double height,
  }) {
    return S2ChoiceHeaderStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      highlightColor: highlightColor ?? this.highlightColor,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      height: height ?? this.height,
    );
  }

  /// Returns a new [S2ChoiceHeaderStyle] that is
  /// a combination of this object and the given [other] style.
  S2ChoiceHeaderStyle merge(S2ChoiceHeaderStyle other) {
    // if null return current object
    if (other == null) return this;

    return S2ChoiceHeaderStyle(
      backgroundColor: other.backgroundColor,
      highlightColor: other.highlightColor,
      textStyle: other.textStyle,
      padding: other.padding,
      height: other.height,
    );
  }
}

/// Configure choices item style
class S2ChoiceStyle {

  /// How much space to place between children in a run in the main axis.
  /// When use [SmartSelectChoiceType.chips] or [useWrap] is [true]
  final double spacing;

  /// How much space to place between the runs themselves in the cross axis.
  /// When use [SmartSelectChoiceType.chips] or [useWrap] is [true]
  final double runSpacing;

  /// choices wrapper padding
  final EdgeInsetsGeometry wrapperPadding;

  /// Choices item padding
  final EdgeInsetsGeometry padding;

  /// choices item title style
  final TextStyle titleStyle;

  /// choices item subtitle style
  final TextStyle subtitleStyle;

  /// whether the chips use checkmark or not
  final bool showCheckmark;

  /// Where to place the control in widgets that use
  /// [ListTile] to position a control next to a label.
  final S2ChoiceControl control;

  /// Highlight color
  final Color highlightColor;

  /// Primary color of selected choice item
  final Color activeColor;

  /// Primary color of unselected choice item
  final Color color;

  /// Secondary color of selected choice item
  final Color activeAccentColor;

  /// Secondary color of unselected choice item
  final Color accentColor;

  /// Brightness for selected Chip
  final Brightness activeBrightness;

  /// Brightness for unselected Chip
  final Brightness brightness;

  /// Opacity for selected Chip border, only effect when
  /// [activeBrightness] is [Brightness.light]
  final double activeBorderOpacity;

  /// Opacity for unselected chip border, only effect when
  /// [brightness] is [Brightness.light]
  final double borderOpacity;

  /// Shape clip behavior
  final Clip clipBehavior;

  /// Create a configuration of choices item style
  const S2ChoiceStyle({
    this.titleStyle = const TextStyle(),
    this.subtitleStyle = const TextStyle(),
    this.spacing,
    this.runSpacing,
    this.wrapperPadding,
    this.padding,
    this.showCheckmark,
    this.control = S2ChoiceControl.platform,
    this.highlightColor,
    this.activeColor,
    this.color,
    this.activeAccentColor,
    this.accentColor,
    this.activeBrightness = Brightness.light,
    this.brightness = Brightness.light,
    this.activeBorderOpacity,
    this.borderOpacity,
    this.clipBehavior,
  });

  /// Creates a copy of this [S2ChoiceStyle] but with
  /// the given fields replaced with the new values.
  S2ChoiceStyle copyWith({
    TextStyle titleStyle,
    TextStyle subtitleStyle,
    double spacing,
    double runSpacing,
    EdgeInsetsGeometry wrapperPadding,
    EdgeInsetsGeometry padding,
    bool showCheckmark,
    S2ChoiceControl control,
    Color highlightColor,
    Color activeColor,
    Color color,
    Color activeAccentColor,
    Color accentColor,
    Brightness activeBrightness,
    Brightness brightness,
    double activeBorderOpacity,
    double borderOpacity,
    Clip clipBehavior,
  }) {
    return S2ChoiceStyle(
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      spacing: spacing ?? this.spacing,
      runSpacing: runSpacing ?? this.runSpacing,
      wrapperPadding: wrapperPadding ?? this.wrapperPadding,
      padding: padding ?? this.padding,
      showCheckmark: showCheckmark ?? this.showCheckmark,
      control: control ?? this.control,
      highlightColor: highlightColor ?? this.highlightColor,
      activeColor: activeColor ?? this.activeColor,
      color: color ?? this.color,
      activeAccentColor: activeAccentColor ?? this.activeAccentColor,
      accentColor: accentColor ?? this.accentColor,
      activeBrightness: activeBrightness ?? this.activeBrightness,
      brightness: brightness ?? this.brightness,
      activeBorderOpacity: activeBorderOpacity ?? this.activeBorderOpacity,
      borderOpacity: borderOpacity ?? this.borderOpacity,
      clipBehavior: clipBehavior ?? this.clipBehavior,
    );
  }

  /// Returns a new [S2ChoiceStyle] that is
  /// a combination of this object and the given [other] style.
  S2ChoiceStyle merge(S2ChoiceStyle other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      titleStyle: other.titleStyle,
      subtitleStyle: other.subtitleStyle,
      spacing: other.spacing,
      runSpacing: other.runSpacing,
      wrapperPadding: other.wrapperPadding,
      padding: other.padding,
      showCheckmark: other.showCheckmark,
      control: other.control,
      highlightColor: other.highlightColor,
      activeColor: other.activeColor,
      color: other.color,
      activeAccentColor: other.activeAccentColor,
      accentColor: other.accentColor,
      activeBrightness: other.activeBrightness,
      brightness: other.brightness,
      activeBorderOpacity: other.activeBorderOpacity,
      borderOpacity: other.borderOpacity,
      clipBehavior: other.clipBehavior,
    );
  }
}
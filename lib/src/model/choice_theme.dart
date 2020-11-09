import 'package:flutter/painting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
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
@immutable
class S2ChoiceHeaderStyle with Diagnosticable {

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

  /// Group header cross axis alignment
  final CrossAxisAlignment crossAxisAlignment;

  /// Group header main axis alignment
  final MainAxisAlignment mainAxisAlignment;

  /// Create a configuration of choices group header style
  const S2ChoiceHeaderStyle({
    this.highlightColor,
    this.backgroundColor,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.height = 45.0,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
  });

  /// Creates a copy of this [S2ChoiceHeaderStyle] but with
  /// the given fields replaced with the new values.
  S2ChoiceHeaderStyle copyWith({
    Color backgroundColor,
    Color highlightColor,
    TextStyle textStyle,
    EdgeInsetsGeometry padding,
    double height,
    CrossAxisAlignment crossAxisAlignment,
    MainAxisAlignment mainAxisAlignment,
  }) {
    return S2ChoiceHeaderStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      highlightColor: highlightColor ?? this.highlightColor,
      textStyle: this.textStyle?.merge(textStyle) ?? textStyle,
      padding: padding ?? this.padding,
      height: height ?? this.height,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
    );
  }

  /// Returns a new [S2ChoiceHeaderStyle] that is
  /// a combination of this object and the given [other] style.
  S2ChoiceHeaderStyle merge(S2ChoiceHeaderStyle other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      backgroundColor: other.backgroundColor,
      highlightColor: other.highlightColor,
      textStyle: other.textStyle,
      padding: other.padding,
      height: other.height,
      crossAxisAlignment: other.crossAxisAlignment,
      mainAxisAlignment: other.mainAxisAlignment,
    );
  }
}

/// Configure choices item style
@immutable
class S2ChoiceStyle with Diagnosticable {

  /// Choices item margin
  final EdgeInsetsGeometry margin;

  /// Choices item padding
  final EdgeInsetsGeometry padding;

  /// choices item title style
  final TextStyle titleStyle;

  /// choices item subtitle style
  final TextStyle subtitleStyle;

  /// Whether the chips use checkmark or not
  final bool showCheckmark;

  /// Primary color of unselected choice item
  final Color color;

  /// Secondary color of unselected choice item
  final Color accentColor;

  /// Highlighted text color
  final Color highlightColor;

  /// Brightness for unselected Chip
  final Brightness brightness;

  /// Where to place the control in widgets that use
  /// [ListTile] to position a control next to a label.
  final S2ChoiceControl control;

  /// Opacity for unselected chip border, only effect when
  /// [brightness] is [Brightness.light]
  final double borderOpacity;

  /// Shape clip behavior
  final Clip clipBehavior;

  /// Create a configuration of choices item style
  const S2ChoiceStyle({
    this.titleStyle,
    this.subtitleStyle,
    this.margin,
    this.padding,
    this.showCheckmark,
    this.color,
    this.accentColor,
    this.highlightColor,
    this.brightness,
    this.control,
    this.borderOpacity,
    this.clipBehavior,
  });

  /// Whether the brightness is dark or not
  bool get isDark => brightness == Brightness.dark;

  /// Whether the brightness is light or not
  bool get isLight => brightness == Brightness.light;

  /// Creates a copy of this [S2ChoiceStyle] but with
  /// the given fields replaced with the new values.
  S2ChoiceStyle copyWith({
    TextStyle titleStyle,
    TextStyle subtitleStyle,
    EdgeInsetsGeometry margin,
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
      titleStyle: this.titleStyle?.merge(titleStyle) ?? titleStyle,
      subtitleStyle: this.subtitleStyle?.merge(subtitleStyle) ?? subtitleStyle,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      showCheckmark: showCheckmark ?? this.showCheckmark,
      control: control ?? this.control,
      highlightColor: highlightColor ?? this.highlightColor,
      color: color ?? this.color,
      accentColor: accentColor ?? this.accentColor,
      brightness: brightness ?? this.brightness,
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
      margin: other.margin,
      padding: other.padding,
      showCheckmark: other.showCheckmark,
      control: other.control,
      highlightColor: other.highlightColor,
      color: other.color,
      accentColor: other.accentColor,
      brightness: other.brightness,
      borderOpacity: other.borderOpacity,
      clipBehavior: other.clipBehavior,
    );
  }
}
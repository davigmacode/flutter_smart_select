import 'package:flutter/widgets.dart';

/// Configure choices group header style
class SmartSelectChoiceGroupHeaderStyle {

  /// Group header background color
  final Color backgroundColor;

  /// Group header text style
  final TextStyle textStyle;

  /// Group header padding
  final EdgeInsetsGeometry padding;

  /// Group header height
  final double height;

  /// Create a configuration of choices group header style
  const SmartSelectChoiceGroupHeaderStyle({
    this.backgroundColor = const Color(0xFFECEFF1),
    this.textStyle = const TextStyle(color: Color(0x8A000000)),
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.height = 45.0,
  });
}

/// Configure choices item style
class SmartSelectChoiceStyle {

  /// Checkbox Checked icon color
  final Color checkColor;

  /// Checkbox or radio active color
  final Color activeColor;

  /// Inactive checkbox or radio color
  final Color inactiveColor;

  /// Switch active thumb image
  final ImageProvider activeThumbImage;

  /// Switch active track color
  final Color activeTrackColor;

  /// Switch inactive thumb color
  final Color inactiveThumbColor;

  /// Switch inactive thumb image
  final ImageProvider inactiveThumbImage;

  /// Switch inactive track color
  final Color inactiveTrackColor;

  /// choices item title style
  final TextStyle titleStyle;

  /// choices item subtitle style
  final TextStyle subtitleStyle;

  /// Active choices item title style
  final TextStyle activeTitleStyle;

  /// Active choices item subtitle style
  final TextStyle activeSubtitleStyle;

  /// Choices item padding
  final EdgeInsetsGeometry padding;

  /// Create a configuration of choices item style
  const SmartSelectChoiceStyle({
    this.checkColor,
    this.activeColor,
    this.inactiveColor,
    this.activeThumbImage,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveThumbImage,
    this.inactiveTrackColor,
    this.titleStyle = const TextStyle(color: Color(0xFF616161)),
    this.subtitleStyle = const TextStyle(color: Color(0xFF616161)),
    this.activeTitleStyle,
    this.activeSubtitleStyle,
    this.padding,
  });
}
import 'package:flutter/widgets.dart';
import 'dart:ui';

/// Configure modal style
class SmartSelectModalStyle {

  /// Modal border shape
  /// used in popup dialog and bottom sheet
  final ShapeBorder shape;

  /// Modal elevation
  /// used in popup dialog and bottom sheet
  final double elevation;

  /// Modal background color
  final Color backgroundColor;

  /// Create a configuration of modal style
  const SmartSelectModalStyle({
    this.shape,
    this.elevation,
    this.backgroundColor,
  });
}

/// Configure modal option header style
class SmartSelectModalHeaderStyle {

  /// Header border shape
  final ShapeBorder shape;

  /// Header elevation
  final double elevation;

  /// Header background color
  final Color backgroundColor;

  /// Header brightness
  final Brightness brightness;

  /// Whether the header title is centered
  final bool centerTitle;

  /// Header text style
  /// used by title and search field
  final TextStyle textStyle;

  /// Header icon theme
  final IconThemeData iconTheme;

  /// Header actions icon theme
  final IconThemeData actionsIconTheme;

  /// Create a configuration of modal option header style
  const SmartSelectModalHeaderStyle({
    this.shape,
    this.elevation = 0.5,
    this.centerTitle = false,
    this.textStyle = const TextStyle(color: Color(0x8A000000)),
    this.iconTheme = const IconThemeData(color: Color(0x8A000000)),
    this.actionsIconTheme = const IconThemeData(color: Color(0x8A000000)),
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.brightness,
  });
}
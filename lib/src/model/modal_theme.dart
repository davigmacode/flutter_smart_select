import 'package:flutter/widgets.dart';
import 'dart:ui';

/// Configure modal style
class S2ModalStyle {

  /// Modal border shape
  /// used in popup dialog and bottom sheet
  final ShapeBorder shape;

  /// Modal elevation
  /// used in popup dialog and bottom sheet
  final double elevation;

  /// Modal background color
  final Color backgroundColor;

  /// Modal clip behavior
  final Clip clipBehavior;

  /// Create a configuration of modal style
  const S2ModalStyle({
    this.shape,
    this.elevation,
    this.backgroundColor,
    this.clipBehavior,
  });

  /// Creates a copy of this [S2ModalStyle] but with
  /// the given fields replaced with the new values.
  S2ModalStyle copyWith({
    ShapeBorder shape,
    double elevation,
    Color backgroundColor,
    Clip clipBehavior,
  }) {
    return S2ModalStyle(
      shape: shape ?? this.shape,
      elevation: elevation ?? this.elevation,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      clipBehavior: clipBehavior ?? this.clipBehavior,
    );
  }

  /// Returns a new [S2ModalStyle] that is
  /// a combination of this object and the given [other] style.
  S2ModalStyle merge(S2ModalStyle other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      shape: other.shape,
      elevation: other.elevation,
      backgroundColor: other.backgroundColor,
      clipBehavior: other.clipBehavior,
    );
  }
}

/// Configure modal option header style
class S2ModalHeaderStyle {

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

  /// Whether the header use automaticallyImplyLeading or not
  final bool useLeading;

  /// Header text style
  /// used by title and search field
  final TextStyle textStyle;

  /// Error text style
  final TextStyle errorStyle;

  /// Header icon theme
  final IconThemeData iconTheme;

  /// Header actions icon theme
  final IconThemeData actionsIconTheme;

  /// Create a configuration of modal option header style
  const S2ModalHeaderStyle({
    this.shape,
    this.elevation = 0.5,
    this.useLeading,
    this.centerTitle = false,
    this.textStyle = const TextStyle(color: Color(0x8A000000)),
    this.errorStyle = const TextStyle(color: Color(0xFFF44336), fontSize: 13.5, fontWeight: FontWeight.w500),
    this.iconTheme = const IconThemeData(color: Color(0x8A000000)),
    this.actionsIconTheme = const IconThemeData(color: Color(0x8A000000)),
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.brightness,
  }) :
    assert(elevation != null),
    assert(centerTitle != null);

  /// Creates a copy of this [S2ModalHeaderStyle] but with
  /// the given fields replaced with the new values.
  S2ModalHeaderStyle copyWith({
    ShapeBorder shape,
    double elevation,
    Color backgroundColor,
    Brightness brightness,
    bool useLeading,
    bool centerTitle,
    TextStyle textStyle,
    TextStyle errorStyle,
    IconThemeData iconTheme,
    IconThemeData actionsIconTheme,
  }) {
    return S2ModalHeaderStyle(
      shape: shape ?? this.shape,
      elevation: elevation ?? this.elevation,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      brightness: brightness ?? this.brightness,
      useLeading: useLeading ?? this.useLeading,
      centerTitle: centerTitle ?? this.centerTitle,
      textStyle: textStyle ?? this.textStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      iconTheme: iconTheme ?? this.iconTheme,
      actionsIconTheme: actionsIconTheme ?? this.actionsIconTheme,
    );
  }

  /// Returns a new [S2ModalHeaderStyle] that is
  /// a combination of this object and the given [other] style.
  S2ModalHeaderStyle merge(S2ModalHeaderStyle other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      shape: other.shape,
      elevation: other.elevation,
      backgroundColor: other.backgroundColor,
      brightness: other.brightness,
      useLeading: other.useLeading,
      centerTitle: other.centerTitle,
      textStyle: other.textStyle,
      errorStyle: other.errorStyle,
      iconTheme: other.iconTheme,
      actionsIconTheme: other.actionsIconTheme,
    );
  }
}
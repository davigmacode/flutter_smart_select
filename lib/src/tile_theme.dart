import 'package:flutter/widgets.dart';
import 'dart:ui';

/// Configure tile text style
class SmartSelectTileStyle {
  /// Tile text style
  /// used by title
  final TextStyle textStyle;

  /// Create a configuration of modal option header style
  const SmartSelectTileStyle({
    this.textStyle = const TextStyle(color: Color(0x8A000000)),
  });
}

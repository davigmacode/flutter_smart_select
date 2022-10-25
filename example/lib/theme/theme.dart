import 'package:flutter/material.dart';
import 'dart:math';

/// The theme patrol data
///
/// Contains light and dark theme data, and the theme mode
class ThemePatrolData {
  /// Default constructor
  const ThemePatrolData({
    this.light,
    this.dark,
    this.mode = ThemeMode.system,
  });

  /// The default light theme data
  final ThemeData? light;

  /// The default dark theme data
  final ThemeData? dark;

  /// The default theme mode
  ///
  /// Defaults to `ThemeMode.light`
  final ThemeMode mode;

  /// Creates a copy of this [ThemePatrolData] but with
  /// the given fields replaced with the new values.
  ThemePatrolData copyWith({
    ThemeData? light,
    ThemeData? dark,
    ThemeMode? mode,
  }) {
    return ThemePatrolData(
      light: light ?? this.light,
      dark: dark ?? this.dark,
      mode: mode ?? this.mode,
    );
  }

  /// Returns a new [ThemePatrolData] that is
  /// a combination of this object and the given [other] style.
  ThemePatrolData merge(ThemePatrolData? other) {
    // if null return current object
    if (other == null) return this;

    return ThemePatrolData(
      light: other.light,
      dark: other.dark,
      mode: other.mode,
    );
  }
}

/// The widget builder to
typedef ThemePatrolBuilder = Widget Function(
    BuildContext context, ThemePatrolData? theme);

/// A Widget that help you to keep an eyes on your app theme changes
class ThemePatrol extends StatefulWidget {
  /// Internal constructor
  ThemePatrol._({
    Key? key,
    required this.builder,
    required this.theme,
  }) : super(key: key);

  /// Default constructor
  factory ThemePatrol({
    Key? key,
    required ThemePatrolBuilder builder,
    ThemePatrolData? theme,
    ThemeData? light,
    ThemeData? dark,
    ThemeMode? mode,
  }) {
    return ThemePatrol._(
        builder: builder,
        theme: ThemePatrolData().merge(theme).copyWith(
          light: light,
          dark: dark,
          mode: mode,
        ));
  }

  /// Builder that gets called when the brightness or theme changes
  final ThemePatrolBuilder builder;

  /// Theme data
  final ThemePatrolData theme;

  @override
  ThemePatrolState createState() => ThemePatrolState();

  static ThemePatrolState? of(BuildContext context) {
    return context.findAncestorStateOfType<ThemePatrolState>();
  }

  /// Generate [MaterialColor] from a [Color]
  static MaterialColor createColorSwatch(Color color) {
    return MaterialColor(color.value, {
      50: _tintColor(color, 0.5),
      100: _tintColor(color, 0.4),
      200: _tintColor(color, 0.3),
      300: _tintColor(color, 0.2),
      400: _tintColor(color, 0.1),
      500: _tintColor(color, 0),
      600: _tintColor(color, -0.1),
      700: _tintColor(color, -0.2),
      800: _tintColor(color, -0.3),
      900: _tintColor(color, -0.4),
    });
  }

  static int _tintValue(int value, double factor) {
    return max(0, min((value + ((255 - value) * factor)).round(), 255));
  }

  static Color _tintColor(Color color, double factor) {
    return Color.fromRGBO(_tintValue(color.red, factor),
        _tintValue(color.green, factor), _tintValue(color.blue, factor), 1);
  }
}

class ThemePatrolState extends State<ThemePatrol> {
  /// The current theme data
  ThemePatrolData? theme;

  /// The current light theme data, shortcut to [theme.light]
  ThemeData? get lightTheme => theme?.light;

  /// The current dark theme data, shortcut to [theme.dark]
  ThemeData? get darkTheme => theme?.dark;

  /// The current theme mode, shortcut to [theme.mode]
  ThemeMode? get themeMode => theme?.mode;

  /// Whether the current theme mode is [ThemeMode.light] or not
  bool get isLightMode => themeMode == ThemeMode.light;

  /// Whether the current theme mode is [ThemeMode.dark] or not
  bool get isDarkMode => themeMode == ThemeMode.dark;

  /// Whether the current theme mode is [ThemeMode.dark] or not
  bool get isSystemMode => themeMode == ThemeMode.dark;

  /// Set the current theme
  void setTheme({
    ThemePatrolData? data,
    ThemeData? light,
    ThemeData? dark,
    ThemeMode? mode,
  }) {
    setState(() {
      theme = theme?.merge(data).copyWith(
        light: light,
        dark: dark,
        mode: mode,
      ) ??
          data;
    });
  }

  ///  the current theme
  void setColor(Color primary, {Color? accent}) {
    final MaterialColor swatch = ThemePatrol.createColorSwatch(primary);
    setTheme(
      light: ThemeData(
        primarySwatch: swatch,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      dark: ThemeData(
        primarySwatch: swatch,
        primaryColor: primary,
        colorScheme: ColorScheme.dark(secondary: accent ?? primary),
        toggleableActiveColor: accent ?? swatch[600],
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }

  /// Set the theme mode
  void setMode(ThemeMode mode) {
    setTheme(mode: mode);
  }

  /// Set theme mode to [ThemeMode.light]
  void lightMode() {
    setMode(ThemeMode.light);
  }

  /// Set theme mode to [ThemeMode.dark]
  void darkMode() {
    setMode(ThemeMode.dark);
  }

  /// Set theme mode to [ThemeMode.system]
  void systemMode() {
    setMode(ThemeMode.system);
  }

  @override
  void initState() {
    super.initState();
    setTheme(data: widget.theme);
  }

  @override
  void didUpdateWidget(ThemePatrol oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.theme != widget.theme) {
      setTheme(data: widget.theme);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setTheme(data: widget.theme);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, theme);
  }
}

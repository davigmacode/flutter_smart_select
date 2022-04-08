import 'package:flutter/material.dart';

/// Generate ChipTheme that supports outlined and raised chip
class S2ChipTheme extends StatelessWidget {
  /// Default constructor
  S2ChipTheme({
    Key? key,
    required this.child,
    this.color,
    this.outlined = false,
    this.raised = false,
    this.elevation = 1,
    this.opacity,
    this.shape,
    this.labelStyle,
    this.selected = false,
  }) : super(key: key);

  /// The child widget
  final Widget child;

  /// The primary color of the chip item
  final Color? color;

  /// Whether the chip is outlined or not
  final bool? outlined;

  /// Whether the chip is raised or not
  final bool? raised;

  /// If [raised] is [true], define the elevation of the raised chip widget
  final double? elevation;

  /// If [outlined] is [true] this value becomes the border opacity, defaults to `0.3`
  ///
  /// If [outlined] is [false] this value becomes the background opacity, defaults to `0.12`
  final double? opacity;

  /// Shape of the chip widget
  final ShapeBorder? shape;

  /// The [TextStyle] of the chip label
  final TextStyle? labelStyle;

  /// Whether the chip is selected or not
  final bool selected;

  @override
  Widget build(BuildContext context) {
    // These are Material Design defaults, and are used to derive
    // component Colors (with opacity) from base colors.
    const double backgroundAlpha = .12; // 10%
    const double borderAlpha = .21; // 20%
    const int foregroundAlpha = 0xde; // 87%
    const int disabledAlpha = 0x0c; // 38% * 12% = 5%
    const EdgeInsetsGeometry padding = EdgeInsets.all(4.0);

    final Brightness brightness = Theme.of(context).brightness;
    final bool isDark = brightness == Brightness.dark;

    final Color primaryColor = color ??
        (!isDark
            ? Theme.of(context).unselectedWidgetColor
            : ChipTheme.of(context).backgroundColor!);
    final Color backgroundColor = raised == true
        ? primaryColor
        : outlined == true
            ? Colors.transparent
            : primaryColor.withOpacity(opacity ?? backgroundAlpha);
    final Color disabledColor = primaryColor.withAlpha(disabledAlpha);

    final Color secondaryColor = color ?? Theme.of(context).primaryColor;
    final Color selectedColor = raised == true
        ? secondaryColor
        : outlined == true
            ? Colors.transparent
            : secondaryColor.withOpacity(opacity ?? backgroundAlpha);

    final Color foregroundColor = raised == true
        ? Colors.white
        : selected == true
            ? secondaryColor.withAlpha(foregroundAlpha)
            : primaryColor.withAlpha(foregroundAlpha);

    final TextStyle defaultLabelStyle = ChipTheme.of(context).labelStyle!;
    final TextStyle primaryLabelStyle =
        defaultLabelStyle.merge(labelStyle).copyWith(color: foregroundColor);
    final TextStyle selectedLabelStyle = defaultLabelStyle
        .merge(labelStyle)
        .copyWith(
            color: raised == true
                ? Colors.white
                : secondaryColor.withAlpha(foregroundAlpha));

    final ShapeBorder? chipShapeRaised =
        raised == true ? StadiumBorder() : null;
    final ShapeBorder? chipShapeOutlined = outlined == true
        ? StadiumBorder(
            side: BorderSide(
              color: selected == true
                  ? secondaryColor.withOpacity(opacity ?? borderAlpha)
                  : primaryColor.withOpacity(opacity ?? borderAlpha),
            ),
          )
        : null;

    return ChipTheme(
      child: child,
      data: ChipThemeData(
        padding: padding,
        brightness: brightness,
        backgroundColor: backgroundColor,
        deleteIconColor: foregroundColor,
        checkmarkColor: foregroundColor,
        disabledColor: disabledColor,
        selectedColor: selectedColor,
        secondarySelectedColor: selectedColor,
        shape: shape as OutlinedBorder? ??
            chipShapeRaised as OutlinedBorder? ??
            chipShapeOutlined as OutlinedBorder? ??
            StadiumBorder(),
        labelStyle: primaryLabelStyle,
        secondaryLabelStyle: selectedLabelStyle,
        elevation: raised == true ? elevation : 0,
      ),
    );
  }
}

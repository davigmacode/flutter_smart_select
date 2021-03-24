import 'package:flutter/material.dart';
import '../chip_theme.dart';

/// Chips tile/trigger widget
class S2TileChips extends StatelessWidget {
  /// List of value of the selected choices.
  final int chipLength;

  /// Widget builder for chip label item
  final IndexedWidgetBuilder chipLabelBuilder;

  /// Widget builder for chip avatar item
  final IndexedWidgetBuilder? chipAvatarBuilder;

  /// Widget builder for chip item
  final IndexedWidgetBuilder? chipBuilder;

  /// Called when the user delete the chip item.
  final ValueChanged<int>? chipOnDelete;

  /// The primary color of the chip item
  final Color? chipColor;

  /// Whether the chip is outlined or not
  final bool chipOutlined;

  /// Whether the chip is raised or not
  final bool chipRaised;

  /// If [chipOutlined] is [true] this value becomes the border opacity,
  /// If [chipOutlined] is [false] this value becomes the background opacity
  final double? chipOpacity;

  /// The icon of the delete button
  final Icon? chipDeleteIcon;

  /// Chip spacing
  final double? chipSpacing;

  /// Chip run spacing
  final double? chipRunSpacing;

  /// Chip shape border
  final ShapeBorder? chipShape;

  /// The [TextStyle] of the chip label
  final TextStyle? chipLabelStyle;

  /// The elevation of the chip widget
  final double chipElevation;

  /// The [Widget] displayed when the [values] is null
  final Widget? placeholder;

  /// Whether the chip list is scrollable or not
  final bool scrollable;

  /// Chip list padding
  final EdgeInsetsGeometry? padding;

  /// Create a chips tile/trigger widget
  S2TileChips({
    Key? key,
    required this.chipLength,
    required this.chipLabelBuilder,
    this.chipAvatarBuilder,
    this.chipBuilder,
    this.chipOnDelete,
    this.chipColor,
    this.chipOutlined = false,
    this.chipRaised = false,
    this.chipOpacity,
    this.chipDeleteIcon,
    this.chipSpacing,
    this.chipRunSpacing,
    this.chipShape,
    this.chipLabelStyle,
    this.chipElevation = 1,
    this.placeholder,
    this.scrollable = false,
    this.padding,
  }) : super(key: key);

  /// default padding
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.fromLTRB(15, 0, 15, 10);

  /// default placeholder
  static final Widget defaultPlaceholder = Container();

  @override
  Widget build(BuildContext context) {
    return chipLength > 0
        ? scrollable
            ? _chipScrollable(context)
            : _chipWrapped(context)
        : placeholder ?? defaultPlaceholder;
  }

  Widget _chipWrapped(BuildContext context) {
    return S2ChipTheme(
      color: chipColor,
      outlined: chipOutlined,
      raised: chipRaised,
      elevation: chipElevation,
      opacity: chipOpacity,
      shape: chipShape,
      labelStyle: chipLabelStyle,
      child: Padding(
        padding: padding ?? defaultPadding,
        child: Wrap(
          runAlignment: WrapAlignment.start,
          alignment: WrapAlignment.start,
          spacing: chipSpacing ?? 7,
          runSpacing: chipRunSpacing ?? -5,
          children: _chipList(context),
        ),
      ),
    );
  }

  Widget _chipScrollable(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) => true,
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: padding ?? defaultPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _chipList(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _chipList(BuildContext context) {
    return List<Widget>.generate(
      chipLength,
      (i) {
        // build chip widget
        Widget _chip =
            chipBuilder?.call(context, i) ?? _chipGenerator(context, i);

        // add spacing if chip is scrollable
        if (scrollable) {
          _chip = Padding(
            padding: EdgeInsets.only(
              right: i < chipLength - 1 ? chipSpacing ?? 7 : 0,
            ),
            child: _chip,
          );
        }

        return _chip;
      },
    ).toList();
  }

  Widget _chipGenerator(BuildContext context, int i) {
    return Chip(
      label: chipLabelBuilder.call(context, i),
      avatar: chipAvatarBuilder?.call(context, i),
      deleteIcon: chipDeleteIcon,
      onDeleted: chipOnDelete != null ? () => chipOnDelete!(i) : null,
    );
  }
}

import 'package:flutter/material.dart';
import '../model/choice_item.dart';
import '../widget.dart';

/// Chips tile/trigger widget
class S2ChipsTile<T> extends StatelessWidget {

  /// List of value of the selected choices.
  final List<S2Choice<T>> values;

  /// Called when the user taps this list tile.
  ///
  /// Inoperative if [enabled] is false.
  final GestureTapCallback onTap;

  /// The primary content of the list tile.
  final Widget title;

  /// Additional content displayed below the title.
  final Widget subtitle;

  /// A widget to display before the title.
  ///
  /// Typically an [Icon] or a [CircleAvatar] widget.
  final Widget leading;

  /// A widget to display after the title.
  ///
  /// Typically an [Icon] widget.
  ///
  /// To show right-aligned metadata (assuming left-to-right reading order;
  /// left-aligned for right-to-left reading order), consider using a [Row] with
  /// [MainAxisAlign.baseline] alignment whose first item is [Expanded] and
  /// whose second child is the metadata text, instead of using the [trailing]
  /// property.
  final Widget trailing;

  /// Divider widget
  final Widget divider;

  /// The [Widget] displayed when the [values] is null
  final Widget placeholder;

  /// Hide placeholder when the [values] is null
  final bool placeholderIgnore;

  /// Whether the chip list is scrollable or not
  final bool scrollable;

  /// Chip list padding
  final EdgeInsetsGeometry padding;

  /// Chip color
  final Color chipColor;

  /// Chip border opacity
  final double chipBorderOpacity;

  /// Chip brightness
  final Brightness chipBrightness;

  /// Chip delete button color
  final Color chipDeleteColor;

  /// Chip delete button icon
  final Icon chipDeleteIcon;

  /// Chip spacing
  final double chipSpacing;

  /// Chip run spacing
  final double chipRunSpacing;

  /// Chip shape border
  final ShapeBorder chipShape;

  /// Widget builder for chip item
  final IndexedWidgetBuilder chipBuilder;

  /// Widget builder for chip label item
  final IndexedWidgetBuilder chipLabelBuilder;

  /// Widget builder for chip avatar item
  final IndexedWidgetBuilder chipAvatarBuilder;

  /// Called when the user delete the chip item.
  final ValueChanged<T> chipOnDelete;

  /// Create a chips tile/trigger widget
  S2ChipsTile({
    Key key,
    @required this.values,
    @required this.onTap,
    @required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.divider,
    this.placeholder,
    this.placeholderIgnore= false,
    this.scrollable = false,
    this.padding,
    this.chipColor = Colors.black87,
    this.chipBorderOpacity,
    this.chipBrightness,
    this.chipDeleteColor,
    this.chipDeleteIcon,
    this.chipSpacing,
    this.chipRunSpacing,
    this.chipShape,
    this.chipBuilder,
    this.chipLabelBuilder,
    this.chipAvatarBuilder,
    this.chipOnDelete,
  }) : super(key: key);

  /// Create a chips tile/trigger widget from state
  S2ChipsTile.fromState(
    S2MultiState<T> state, {
    Key key,
    List<S2Choice<T>> values,
    GestureTapCallback onTap,
    Widget title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.divider,
    this.placeholder,
    this.placeholderIgnore = false,
    this.scrollable = false,
    this.padding,
    this.chipColor = Colors.black87,
    this.chipBorderOpacity,
    this.chipBrightness,
    this.chipDeleteColor,
    this.chipDeleteIcon,
    this.chipSpacing,
    this.chipRunSpacing,
    this.chipShape,
    this.chipBuilder,
    this.chipLabelBuilder,
    this.chipAvatarBuilder,
    this.chipOnDelete,
  }) :
    title = title ?? state.titleWidget,
    values = values ?? state.valueObject,
    onTap = onTap ?? state.showModal,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: chipOnDelete == null ? onTap : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: title,
            subtitle: subtitle ?? _placeholder,
            leading: leading,
            trailing: trailing ?? Icon(Icons.arrow_drop_down),
            onTap: chipOnDelete != null ? onTap : null,
          ),
          divider,
          _chipLayout(context),
        ]..removeWhere((item) => item == null),
      ),
    );
  }

  Widget get _placeholder {
    return placeholderIgnore != true
      ? values?.isEmpty ?? true
        ? placeholder ?? const Text('Select one or more')
        : null
      : null;
  }

  EdgeInsetsGeometry get _defaultPadding {
    return EdgeInsets.fromLTRB(15, divider != null ? 10 : 0, 15, 10);
  }

  Widget _chipLayout(BuildContext context) {
    return values?.isNotEmpty ?? false
      ? scrollable
        ? _chipScrollable(context)
        : _chipWrapped(context)
      : null;
  }

  Widget _chipWrapped(BuildContext context) {
    return Padding(
      padding: padding ?? _defaultPadding,
      child: Wrap(
        runAlignment: WrapAlignment.start,
        alignment: WrapAlignment.start,
        spacing: chipSpacing ?? 7,
        runSpacing: chipRunSpacing ?? -5,
        children: _chipList(context),
      ),
    );
  }

  Widget _chipScrollable(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) => true,
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: padding ?? _defaultPadding,
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
    final int n = values.length;
    return List<Widget>.generate(
      n,
      (i) {
        // build chip widget
        Widget _chip = chipBuilder?.call(context, i) ?? _chipGenerator(context, i);

        // add spacing if chip is scrollable
        if (scrollable) {
          _chip = Padding(
            padding: EdgeInsets.only(
              right: i < n - 1 ? chipSpacing ?? 7 : 0
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
      label: chipLabelBuilder?.call(context, i) ?? Text(values[i].title),
      labelStyle: TextStyle(
        color: _chipIsDark ? Colors.white : chipColor
      ),
      avatar: chipAvatarBuilder?.call(context, i),
      backgroundColor: _chipIsDark ? chipColor : Colors.white,
      deleteIconColor: chipDeleteColor ?? _chipIsDark ? Colors.white : chipColor,
      deleteIcon: chipDeleteIcon,
      shape: chipShape ?? StadiumBorder(
        side: BorderSide(
          color: _chipIsDark
            ? chipColor
            : chipColor.withOpacity(chipBorderOpacity ?? .1),
        ),
      ),
      onDeleted: chipOnDelete != null
        ? () => chipOnDelete(values[i].value)
        : null,
    );
  }

  bool get _chipIsDark => chipBrightness == Brightness.dark;
}
import 'package:flutter/material.dart';
import '../widget.dart';

class S2ChipsTile<T> extends StatelessWidget {

  final S2MultiState<T> state;
  final Widget title;
  final Widget subtitle;
  final Widget leading;
  final Widget trailing;
  final Widget placeholder;
  final Widget divider;
  final bool scrollable;
  final bool hidePlaceholder;
  final EdgeInsetsGeometry padding;
  final Color chipColor;
  final double chipBorderOpacity;
  final Brightness chipBrightness;
  final Color chipActionColor;
  final double chipSpacing;
  final double chipRunSpacing;
  final IndexedWidgetBuilder chipBuilder;
  final ValueChanged<T> onDeleted;

  S2ChipsTile({
    Key key,
    @required this.state,
    @required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.placeholder,
    this.divider,
    this.scrollable = false,
    this.hidePlaceholder = false,
    this.padding,
    this.chipColor = Colors.black87,
    this.chipBorderOpacity,
    this.chipBrightness,
    this.chipActionColor,
    this.chipSpacing,
    this.chipRunSpacing,
    this.chipBuilder,
    this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDeleted == null ? state.showModal : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: title,
            subtitle: subtitle ?? _placeholder,
            leading: leading,
            trailing: trailing ?? Icon(Icons.arrow_drop_down),
            onTap: onDeleted != null ? state.showModal : null,
          ),
          divider,
          _chipLayout(context),
        ]..removeWhere((item) => item == null),
      ),
    );
  }

  Widget get _placeholder {
    return hidePlaceholder != true
      ? state.valueObject?.isEmpty ?? true
        ? placeholder ?? Text(state.widget.placeholder)
        : null
      : null;
  }

  EdgeInsetsGeometry get _defaultPadding {
    return EdgeInsets.fromLTRB(15, divider != null ? 10 : 0, 15, 10);
  }

  Widget _chipLayout(BuildContext context) {
    return state.valueObject?.isNotEmpty ?? false
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
    final int n = state.valueObject.length;
    return List<Widget>.generate(
      n,
      (i) {
        // build chip widget
        Widget _chip = chipBuilder?.call(context, i) ?? _chipGenerator(i);

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

  Widget _chipGenerator(int i) {
    return Chip(
      label: Text(
        state.valueObject[i].title,
        style: TextStyle(
          color: _chipIsDark ? Colors.white : chipColor
        ),
      ),
      backgroundColor: _chipIsDark ? chipColor : Colors.white,
      deleteIconColor: chipActionColor ?? _chipIsDark ? Colors.white : chipColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: _chipIsDark
            ? chipColor
            : chipColor.withOpacity(chipBorderOpacity ?? .1),
        ),
      ),
      onDeleted: onDeleted != null
        ? () => onDeleted(state.valueObject[i].value)
        : null,
    );
  }

  bool get _chipIsDark => chipBrightness == Brightness.dark;
}
import 'package:flutter/material.dart';
import './state.dart';
import './option.dart';

class RouteHeader extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool filterable;
  final Widget confirmButton;
  final SmartSelectTarget target;
  final SmartSelectOptionHeaderTheme theme;
  final void Function(bool) onFilterStatus;
  final void Function(String) onFilterQuery;

  RouteHeader({
    Key key,
    this.title,
    this.target,
    this.filterable = false,
    this.confirmButton,
    this.theme,
    this.onFilterStatus,
    this.onFilterQuery,
  });

  @override
  _RouteHeaderState createState() => _RouteHeaderState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _RouteHeaderState extends State<RouteHeader> {
  // Create a filter controller and use it to
  // retrieve the current value of the Filter TextField.
  TextEditingController _filterCtrl = TextEditingController();
  bool _isFiltering = false;

  @override
  void dispose() {
    // Clean up the filter controller when the widget is disposed.
    _filterCtrl.dispose();
    super.dispose();
  }

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      shape: widget.theme.shape,
      elevation: widget.theme.elevation,
      brightness: widget.theme.brightness,
      backgroundColor: widget.theme.backgroundColor,
      actionsIconTheme: widget.theme.actionsIconTheme,
      iconTheme: widget.theme.iconTheme,
      centerTitle: widget.theme.centerTitle,
      automaticallyImplyLeading: _automaticallyImplyLeading,
      title: _titleBar,
      actions: _buttonBar,
    );
  }

  // Widget get _backButton {
  //   return _isFiltering == true
  //     ? BackButton()
  //     : IconButton(
  //         icon: Icon(Icons.close),
  //         onPressed: () => Navigator.pop(context),
  //       );
  // }

  bool get _automaticallyImplyLeading {
    return widget.target == SmartSelectTarget.page || _isFiltering == true;
  }

  Widget get _titleBar {
    return _isFiltering == true ? _searchWidget : _titleWidget;
  }

  Widget get _titleWidget {
    return Text(
      widget.title,
      style: _textStyle,
    );
  }

  Widget get _searchWidget {
    return TextField(
      controller: _filterCtrl,
      style: _textStyle,
      autofocus: true,
      decoration: InputDecoration.collapsed(
        hintText: 'Search on ${widget.title}',
        hintStyle: _textStyle,
      ),
      onSubmitted: _updateFilterQuery,
    );
  }

  TextStyle get _textStyle {
    return Theme.of(context).textTheme.title.merge(widget.theme.textStyle);
  }

  List<Widget> get _buttonBar {
    return <Widget>[
      _filterButton,
      _clearButton,
      _confirmButton,
      Container(width: 5.0),
    ].where((child) => child != null).toList();
  }

  Widget get _filterButton {
    return widget.filterable && !_isFiltering
        ? IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _startFilter(),
          )
        : null;
  }

  Widget get _clearButton {
    return _isFiltering
        ? IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _stopFilter();
              Navigator.pop(context);
            },
          )
        : null;
  }

  Widget get _confirmButton {
    return !_isFiltering ? widget.confirmButton : null;
  }

  void _startFilter() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopFilter));

    _updateFilterStatus(true);
  }

  void _stopFilter() {
    _clearFilter();
    _updateFilterStatus(false);
  }

  void _clearFilter() {
    _updateFilterQuery(null);
    setState(() => _filterCtrl.clear());
  }

  void _updateFilterStatus(bool val) {
    setState(() => _isFiltering = val);
    if (widget.onFilterStatus != null) {
      widget.onFilterStatus(val);
    }
  }

  void _updateFilterQuery(String val) {
    if (widget.onFilterQuery != null) {
      widget.onFilterQuery(val);
    }
  }
}

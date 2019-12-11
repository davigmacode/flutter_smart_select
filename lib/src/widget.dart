import 'package:flutter/material.dart';
import './option.dart';
import './state.dart';
import './route.dart';
import './tile.dart';

class SmartSelect extends StatefulWidget {
  final String title;
  final String placeholder;
  final Widget leading;
  final Widget trailing;
  final String loadingText;
  final bool isLoading;
  final bool isTwoLine;
  final bool enabled;
  final bool selected;
  final bool dense;
  final dynamic value;
  final SmartSelectOption option;
  final EdgeInsetsGeometry padding;
  final SmartSelectTarget target;
  final SmartSelectOnChange onChange;
  final SmartSelectBuilder builder;

  SmartSelect({
    Key key,
    @required this.title,
    @required this.value,
    @required this.option,
    this.placeholder,
    this.leading,
    this.trailing,
    this.loadingText = 'Loading..',
    this.isLoading = false,
    this.isTwoLine = false,
    this.enabled = true,
    this.selected = false,
    this.dense = false,
    this.padding,
    this.target = SmartSelectTarget.page,
    this.onChange,
    this.builder,
  }) : super(key: key);

  SmartSelect.popup({
    Key key,
    @required this.title,
    @required this.value,
    @required this.option,
    this.placeholder,
    this.leading,
    this.trailing,
    this.loadingText = 'Loading..',
    this.isLoading = false,
    this.isTwoLine = false,
    this.enabled = true,
    this.selected = false,
    this.dense = false,
    this.padding,
    this.onChange,
    this.builder,
  })  : this.target = SmartSelectTarget.popup,
        super(key: key);

  SmartSelect.sheet({
    Key key,
    @required this.title,
    @required this.value,
    @required this.option,
    this.placeholder,
    this.leading,
    this.trailing,
    this.loadingText = 'Loading..',
    this.isLoading = false,
    this.isTwoLine = false,
    this.enabled = true,
    this.selected = false,
    this.dense = false,
    this.padding,
    this.onChange,
    this.builder,
  })  : this.target = SmartSelectTarget.sheet,
        super(key: key);

  @override
  _SmartSelectState createState() => _SmartSelectState();
}

class _SmartSelectState extends State<SmartSelect> {
  final GlobalKey<SmartSelectRouteState> _routeCtrl =
      GlobalKey<SmartSelectRouteState>();

  @override
  Widget build(BuildContext context) {
    return widget.builder != null
        ? widget.builder(context, _state, this._showOptions)
        : SmartSelectTile(
            title: widget.title,
            value: _state.valueDisplay,
            leading: widget.leading,
            trailing: widget.trailing,
            loadingText: widget.loadingText,
            isLoading: widget.isLoading,
            isTwoLine: widget.isTwoLine,
            enabled: widget.enabled,
            selected: widget.selected,
            dense: widget.dense,
            padding: widget.padding,
            onTap: () => this._showOptions(context),
          );
  }

  SmartSelectState get _state {
    return SmartSelectState(
      title: widget.title,
      value: widget.value,
      option: widget.option,
      placeholder: widget.placeholder,
    );
  }

  Widget get _routeWidget {
    return SmartSelectRoute(
      key: _routeCtrl,
      title: widget.title,
      value: widget.value,
      option: widget.option,
      target: widget.target,
    );
  }

  void _showOptions(BuildContext context) async {
    var confirmed = true;

    switch (widget.target) {
      case SmartSelectTarget.page:
        confirmed = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => _routeWidget),
        );
        break;
      case SmartSelectTarget.sheet:
        confirmed = await showModalBottomSheet(
          context: context,
          shape: widget.option.shape,
          backgroundColor: widget.option.backgroundColor,
          elevation: widget.option.elevation,
          builder: (_) => _routeWidget,
        );
        break;
      case SmartSelectTarget.popup:
        confirmed = await showDialog(
          context: context,
          builder: (_) => Dialog(
            shape: widget.option.shape,
            backgroundColor: widget.option.backgroundColor,
            elevation: widget.option.elevation,
            child: _routeWidget,
          ),
        );
        break;
    }

    // selected
    var selected = _routeCtrl.currentState.choicesCtrl.currentState.selected;

    // return value
    if (widget.onChange != null && selected != null) {
      if (widget.option.useConfirmation == true && confirmed != true) return;
      widget.onChange(selected);
    }
  }
}

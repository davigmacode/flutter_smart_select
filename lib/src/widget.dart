import 'package:flutter/material.dart';
import './option.dart';
import './state.dart';
import './route.dart';
import './tile.dart';

/// SmartSelect that allows you to easily convert your usual form selects
/// to dynamic pages with grouped radio or checkbox inputs.
class SmartSelect extends StatefulWidget {

  /// The primary content of the widget.
  /// Used in trigger widget and header option
  final String title;

  /// The text displayed when the value is null
  final String placeholder;

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

  /// Whether the is intended to display loading stats.
  final bool isLoading;

  // String text used as loading text
  final String loadingText;

  /// Whether this list tile is intended to display two lines of text.
  final bool isTwoLine;

  /// Whether this list tile is interactive.
  ///
  /// If false, this list tile is styled with the disabled color from the
  /// current [Theme] and the [onTap] and [onLongPress] callbacks are
  /// inoperative.
  final bool enabled;

  /// If this tile is also [enabled] then icons and text are rendered with the same color.
  ///
  /// By default the selected color is the theme's primary color. The selected color
  /// can be overridden with a [ListTileTheme].
  final bool selected;

  /// Whether this list tile is part of a vertically dense list.
  ///
  /// If this property is null then its value is based on [ListTileTheme.dense].
  ///
  /// Dense list tiles default to a smaller height.
  final bool dense;

  /// The value of the widget.
  final dynamic value;

  /// The tile's internal padding.
  ///
  /// Insets a [ListTile]'s contents: its [leading], [title], [subtitle],
  /// and [trailing] widgets.
  ///
  /// If null, `EdgeInsets.symmetric(horizontal: 16.0)` is used.
  final EdgeInsetsGeometry padding;

  /// List of option along with its configuration
  final SmartSelectOption option;

  /// Target to open option list
  final SmartSelectTarget target;

  /// Called when the widget value changed
  final SmartSelectOnChange onChange;

  /// Builder for custom trigger widget
  final SmartSelectBuilder builder;

  /// Default constructor
  /// Open option in a new page
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

  /// Custom constructor
  /// Open option in popup dialog
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

  /// Custom constructor
  /// Open option in bottom sheet
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

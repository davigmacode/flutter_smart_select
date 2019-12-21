import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './model/option_config.dart';
import './model/choice_config.dart';
import './model/modal_config.dart';
import './model/state.dart';
import './model/state_filter.dart';
import './model/state_selected.dart';
import './choices.dart';
import './modal.dart';
import './tile.dart';
import './utils.dart' as utils;

/// A function that called when the widget value changed
typedef void SmartSelectOnChange(dynamic value);

/// A function that used to show choices modal
typedef void SmartSelectShowModal(BuildContext context);

/// Builder for custom trigger widget
typedef Widget SmartSelectBuilder(
  BuildContext context,
  SmartSelectState state,
  SmartSelectShowModal showChoices
);

/// SmartSelect that allows you to easily convert your usual form selects
/// to dynamic pages with grouped radio or checkbox inputs.
class SmartSelect extends StatelessWidget {

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

  /// Whether show the options list
  /// as single choice or multiple choice
  final bool isMultiChoice;

  /// Whether this list tile is intended to display two lines of text.
  final bool isTwoLine;

  /// Whether the is intended to display loading stats.
  final bool isLoading;

  // String text used as loading text
  final String loadingText;

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
  final SmartSelectOptionConfig option;

  /// Choice configuration
  final SmartSelectChoiceConfig choice;

  /// Modal configuration
  final SmartSelectModalConfig modal;

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
    this.isMultiChoice = false,
    this.isTwoLine = false,
    this.isLoading = false,
    this.loadingText = 'Loading..',
    this.enabled = true,
    this.selected = false,
    this.dense = false,
    this.padding,
    this.choice = const SmartSelectChoiceConfig(),
    this.modal = const SmartSelectModalConfig(),
    this.onChange,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder != null
      ? builder(context, _state, this._showModal)
      : SmartSelectTile(
          title: title,
          value: _state.valueDisplay,
          leading: leading,
          trailing: trailing,
          loadingText: loadingText,
          isLoading: isLoading,
          isTwoLine: isTwoLine,
          enabled: enabled,
          selected: selected,
          dense: dense,
          padding: padding,
          onTap: () => this._showModal(context),
        );
  }

  dynamic get _defaultValue => isMultiChoice ? [] : null;

  SmartSelectState get _state => SmartSelectState(
    title: title,
    value: value ?? _defaultValue,
    option: option.items,
    placeholder: placeholder,
    isMultiChoice: isMultiChoice,
  );

  void _showModal(BuildContext context) async {
    bool confirmed = false;
    BuildContext _context;

    Widget _routeWidget = MultiProvider(
      providers: [
        ChangeNotifierProvider<SmartSelectStateSelected>(
          create: (_) => SmartSelectStateSelected(
            isMultiChoice,
            isMultiChoice ? List.from(value ?? _defaultValue) : value,
          ),
        ),
        ChangeNotifierProvider<SmartSelectStateFilter>(
          create: (_) => SmartSelectStateFilter(),
        ),
        // Provider<SmartSelectModal>.value(value: modal),
        // Provider<SmartSelectChoice>.value(value: choice),
      ],
      child: Builder(
        builder: (_) {
          _context = _;
          return SmartSelectModal(
            title: title,
            config: modal,
            choices: Consumer<SmartSelectStateFilter>(
              builder: (context, state, _) {
                return SmartSelectChoices(
                  config: choice,
                  query: state.query,
                  items: option.filteredItems(state.query),
                  useConfirmation: modal.useConfirmation,
                  isMultiChoice: isMultiChoice,
                  isGrouped: option.groupBy != null,
                );
              }
            ),
          );
        },
      ),
    );

    switch (modal.type) {
      case SmartSelectModalType.fullPage:
        confirmed = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => _routeWidget),
        );
        break;
      case SmartSelectModalType.bottomSheet:
        confirmed = await showModalBottomSheet(
          context: context,
          shape: modal.style.shape,
          backgroundColor: modal.style.backgroundColor,
          elevation: modal.style.elevation,
          builder: (_) => _routeWidget,
        );
        break;
      case SmartSelectModalType.popupDialog:
        confirmed = await showDialog(
          context: context,
          builder: (_) => Dialog(
            shape: modal.style.shape,
            backgroundColor: modal.style.backgroundColor,
            elevation: modal.style.elevation,
            child: _routeWidget,
          ),
        );
        break;
    }

    // get selected value(s)
    dynamic selected = utils.getStateSelected(_context).value;

    // return value
    if (onChange != null && selected != null) {
      if (modal.useConfirmation == true && confirmed != true) return;
      onChange(selected);
    }
  }
}
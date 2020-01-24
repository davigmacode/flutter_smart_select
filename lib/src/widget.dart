import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './model/option.dart';
import './model/choice_config.dart';
import './model/modal_config.dart';
import './model/state.dart';
import './model/state_filter.dart';
import './model/state_selected.dart';
import './choices.dart';
import './modal.dart';
import './tile.dart';

/// A function that called when the widget value changed
typedef void SmartSelectOnChange<T>(T value);

/// A function that used to show choices modal
typedef void SmartSelectShowModal(BuildContext context);

/// Builder for custom trigger widget
typedef Widget SmartSelectBuilder<T>(
  BuildContext context,
  SmartSelectState<T> state,
  SmartSelectShowModal showChoices
);

/// SmartSelect that allows you to easily convert your usual form selects
/// to dynamic pages with grouped radio or checkbox inputs.
class SmartSelect<T> extends StatelessWidget {

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

  // /// The value of the widget.
  // final T value;

  // /// The value of the widget.
  // final T values;

  /// The tile's internal padding.
  ///
  /// Insets a [ListTile]'s contents: its [leading], [title], [subtitle],
  /// and [trailing] widgets.
  ///
  /// If null, `EdgeInsets.symmetric(horizontal: 16.0)` is used.
  final EdgeInsetsGeometry padding;

  /// List of option item
  final List<SmartSelectOption<T>> options;

  /// When [isMultiChoice] is true
  /// [choiceType] can use [SmartSelectChoiceType.checkboxes]
  /// or [SmartSelectChoiceType.switches] or [SmartSelectChoiceType.chips]
  /// and when [isMultiChoice] is false
  /// [choiceType] can use [SmartSelectChoiceType.radios]
  /// or [SmartSelectChoiceType.chips]
  final SmartSelectChoiceType choiceType;

  /// Choice configuration
  final SmartSelectChoiceConfig<T> choiceConfig;

  /// Modal type
  final SmartSelectModalType modalType;

  /// Modal configuration
  final SmartSelectModalConfig modalConfig;

  /// Called when single choice value changed
  final SmartSelectOnChange<T> _onChangeSingle;

  /// Called when multiple choice value changed
  final SmartSelectOnChange<List<T>> _onChangeMultiple;

  /// Builder for custom trigger widget
  final SmartSelectBuilder<T> builder;

  /// Whether show the options list
  /// as single choice or multiple choice
  final bool isMultiChoice;

  /// state used internally
  final SmartSelectState<T> _state;

  /// Constructor for single choice
  SmartSelect.single({
    Key key,
    @required T value,
    @required this.title,
    @required this.options,
    @required SmartSelectOnChange<T> onChange,
    this.placeholder = 'Select one',
    this.leading,
    this.trailing,
    this.isTwoLine = false,
    this.isLoading = false,
    this.loadingText = 'Loading..',
    this.enabled = true,
    this.selected = false,
    this.dense = false,
    this.padding,
    this.choiceType = SmartSelectChoiceType.radios,
    this.modalType = SmartSelectModalType.fullPage,
    this.choiceConfig = const SmartSelectChoiceConfig(),
    this.modalConfig = const SmartSelectModalConfig(),
    this.builder,
  }) : assert(choiceType == SmartSelectChoiceType.radios || choiceType == SmartSelectChoiceType.chips, 'SmartSelect.single only support SmartSelectChoiceType.radios and SmartSelectChoiceType.chips'),
    isMultiChoice = false,
    _onChangeMultiple = null,
    _onChangeSingle = onChange,
    _state =  SmartSelectState<T>.single(
      value,
      title: title,
      options: options,
      placeholder: placeholder,
    ),
    super(key: key);

  /// Constructor for multiple choice
  SmartSelect.multiple({
    Key key,
    @required List<T> value,
    @required this.title,
    @required this.options,
    @required SmartSelectOnChange<List<T>> onChange,
    this.placeholder = 'Select one or more',
    this.leading,
    this.trailing,
    this.isTwoLine = false,
    this.isLoading = false,
    this.loadingText = 'Loading..',
    this.enabled = true,
    this.selected = false,
    this.dense = false,
    this.padding,
    this.choiceType = SmartSelectChoiceType.checkboxes,
    this.modalType = SmartSelectModalType.fullPage,
    this.choiceConfig = const SmartSelectChoiceConfig(),
    this.modalConfig = const SmartSelectModalConfig(),
    this.builder,
  }) : assert(choiceType == SmartSelectChoiceType.checkboxes || choiceType == SmartSelectChoiceType.switches || choiceType == SmartSelectChoiceType.chips, 'SmartSelect.multiple only support SmartSelectChoiceType.checkboxes, SmartSelectChoiceType.switches and SmartSelectChoiceType.chips'),
    isMultiChoice = true,
    _onChangeSingle = null,
    _onChangeMultiple = onChange,
    _state = SmartSelectState<T>.multiple(
      value ?? [],
      title: title,
      options: options,
      placeholder: placeholder,
    ),
    super(key: key);

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

  void _showModal(BuildContext context) async {
    bool confirmed = false;
    BuildContext _context;

    // Widget _route = StateProvider<SmartSelectStateSelected>(
    //   state: _stateSelected,
    //   child: StateProvider<SmartSelectStateFilter>(
    //     state: SmartSelectStateFilter(),
    //     child: Builder(
    //       builder: (_ctx) {
    //         _context = _ctx;
    //         return SmartSelectModal(
    //           title: title,
    //           type: modalType,
    //           config: modalConfig,
    //           choices: StateConsumer<SmartSelectStateFilter>(
    //             builder: (context, state, _) {
    //               return SmartSelectChoices(
    //                 type: choiceType,
    //                 config: choiceConfig,
    //                 query: state.query,
    //                 items: _filteredOptions(state.query),
    //               );
    //             },
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );

    Widget _routeWidget = MultiProvider(
      providers: [
        ChangeNotifierProvider<SmartSelectStateSelected<T>>(
          create: (_) => isMultiChoice == true
            ? SmartSelectStateSelected<T>.multiple(
                List.from(_state.values) ?? [],
                useConfirmation: modalConfig.useConfirmation
              )
            : SmartSelectStateSelected<T>.single(
                _state.value,
                useConfirmation: modalConfig.useConfirmation
              ),
        ),
        ChangeNotifierProvider<SmartSelectStateFilter>(
          create: (_) => SmartSelectStateFilter(),
        ),
      ],
      child: Builder(
        builder: (_) {
          _context = _;
          return SmartSelectModal(
            title: title,
            type: modalType,
            config: modalConfig,
            choices: Consumer<SmartSelectStateFilter>(
              builder: (context, state, _) {
                return SmartSelectChoices<T>(
                  type: choiceType,
                  config: choiceConfig,
                  query: state.query,
                  items: options,
                );
              },
            ),
          );
        },
      ),
    );

    switch (modalType) {
      case SmartSelectModalType.fullPage:
        confirmed = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => _routeWidget),
        );
        break;
      case SmartSelectModalType.bottomSheet:
        confirmed = await showModalBottomSheet(
          context: context,
          shape: modalConfig.style.shape,
          backgroundColor: modalConfig.style.backgroundColor,
          elevation: modalConfig.style.elevation,
          builder: (_) => _routeWidget,
        );
        break;
      case SmartSelectModalType.popupDialog:
        confirmed = await showDialog(
          context: context,
          builder: (_) => Dialog(
            shape: modalConfig.style.shape,
            backgroundColor: modalConfig.style.backgroundColor,
            elevation: modalConfig.style.elevation,
            child: _routeWidget,
          ),
        );
        break;
    }

    // dont return value if modal need confirmation and not confirmed
    if (modalConfig.useConfirmation == true && confirmed != true) return;

    if (isMultiChoice == true) {
      // get selected value(s)
      List<T> selected = Provider.of<SmartSelectStateSelected<T>>(_context, listen: false).values;
      // return value
      if (selected != null) _onChangeMultiple?.call(selected);
    } else {
      // get selected value(s)
      T selected = Provider.of<SmartSelectStateSelected<T>>(_context, listen: false).value;
      // return value
      if (selected != null) _onChangeSingle?.call(selected);
    }
  }
}


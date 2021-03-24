import 'package:flutter/material.dart';
import '../widget.dart';

/// Default trigger/tile widget
class S2Tile<T> extends StatelessWidget {
  /// The value of the selected option.
  final Widget value;

  /// Called when the user taps this list tile.
  ///
  /// Inoperative if [enabled] is false.
  final GestureTapCallback onTap;

  /// The primary content of the list tile.
  final Widget title;

  /// A widget to display before the title.
  ///
  /// Typically an [Icon] or a [CircleAvatar] widget.
  final Widget? leading;

  /// A widget to display after the title.
  ///
  /// Typically an [Icon] widget.
  ///
  /// To show right-aligned metadata (assuming left-to-right reading order;
  /// left-aligned for right-to-left reading order), consider using a [Row] with
  /// [MainAxisAlign.baseline] alignment whose first item is [Expanded] and
  /// whose second child is the metadata text, instead of using the [trailing]
  /// property.
  final Widget? trailing;

  /// Whether this list tile is intended to display loading stats.
  final bool isLoading;

  /// String text used as loading text
  final String? loadingText;

  /// Widget used as loading message
  final Widget? loadingMessage;

  /// Widget used as loading indicator
  final Widget? loadingIndicator;

  /// Whether this list tile is intended to display error widget.
  final bool isError;

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

  /// Whether the [value] is displayed or not
  final bool hideValue;

  /// The tile's internal padding.
  ///
  /// Insets a [ListTile]'s contents: its [leading], [title], [subtitle],
  /// and [trailing] widgets.
  ///
  /// If null, `EdgeInsets.symmetric(horizontal: 16.0)` is used.
  final EdgeInsetsGeometry? padding;

  /// widget to display below the tile
  /// usually used to display chips with S2TileChips
  final Widget? body;

  /// Create a default trigger widget
  S2Tile({
    Key? key,
    required this.value,
    required this.onTap,
    required this.title,
    this.leading,
    this.trailing,
    this.loadingText,
    this.loadingMessage,
    this.loadingIndicator,
    this.isLoading = false,
    this.isError = false,
    this.isTwoLine = false,
    this.enabled = true,
    this.selected = false,
    this.dense = false,
    this.hideValue = false,
    this.padding,
    this.body,
  }) : super(key: key);

  /// Create a default trigger widget from state
  S2Tile.fromState(
    S2State<T> state, {
    Key? key,
    Widget? value,
    GestureTapCallback? onTap,
    Widget? title,
    bool? isError,
    bool? isLoading,
    this.leading,
    this.trailing,
    this.loadingText,
    this.loadingMessage,
    this.loadingIndicator,
    this.isTwoLine = false,
    this.enabled = true,
    this.selected = false,
    this.dense = false,
    this.hideValue = false,
    this.padding,
    this.body,
  })  : title = title ?? state.titleWidget,
        value = value ?? Text(state.selected.toString()),
        onTap = onTap ?? state.showModal,
        isLoading = isLoading ?? state.selected!.isResolving,
        isError = isError ?? state.selected!.isNotValid,
        super(key: key);

  /// Returns default trailing widget
  static const Widget defaultTrailing = const Icon(
    Icons.keyboard_arrow_right,
    color: Colors.grey,
  );

  /// Returns default loading indicator widget
  static const Widget defaultLoadingIndicator = const SizedBox(
    child: CircularProgressIndicator(
      strokeWidth: 1.5,
    ),
    height: 16.0,
    width: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    return body == null ? _tileWidget : _tileWithBodyWidget;
  }

  Widget get _tileWidget {
    return ListTile(
      dense: dense,
      enabled: enabled && isLoading != true,
      selected: selected,
      contentPadding: padding,
      leading: leading,
      title: title,
      subtitle: isTwoLine && hideValue != true ? _valueWidget : null,
      trailing: _trailingWidget,
      onTap: onTap,
    );
  }

  Widget get _tileWithBodyWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _tileWidget,
        body!,
      ],
    );
  }

  Widget? get _trailingWidget {
    return isTwoLine != true && hideValue != true
        ? Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  constraints: const BoxConstraints(maxWidth: 100),
                  child: _valueWidget,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: _trailingIconWidget,
                ),
              ],
            ),
          )
        : _trailingIconWidget;
  }

  Widget? get _trailingIconWidget {
    return isLoading != true
        ? trailing != null
            ? trailing
            : S2Tile.defaultTrailing
        : S2Tile.defaultLoadingIndicator;
  }

  Widget get _loadingWidget {
    return loadingMessage ?? Text(loadingText ?? 'Loading..');
  }

  Widget get _valueWidget {
    return Builder(
      builder: (context) {
        return DefaultTextStyle.merge(
          child: isLoading == true ? _loadingWidget : value,
          style: isError == true
              ? TextStyle(color: Theme.of(context).errorColor)
              : null,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        );
      },
    );
  }
}

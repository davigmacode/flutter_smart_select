import 'package:flutter/material.dart';
import 'package:smart_select/src/smart_select_tile_config.dart';
import 'package:smart_select/src/tile_theme.dart';

/// Default trigger widget
class SmartSelectTile extends StatelessWidget {
  /// The value of the selected option.
  final String value;

  /// The primary content of the list tile.
  final String title;

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

  /// Whether this list tile is intended to display loading stats.
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

  /// The tile's internal padding.
  ///
  /// Insets a [ListTile]'s contents: its [leading], [title], [subtitle],
  /// and [trailing] widgets.
  ///
  /// If null, `EdgeInsets.symmetric(horizontal: 16.0)` is used.
  final EdgeInsetsGeometry padding;

  /// Called when the user taps this list tile.
  ///
  /// Inoperative if [enabled] is false.
  final GestureTapCallback onTap;

  final SmartSelectTileConfig config;

  /// Create a default trigger widget
  SmartSelectTile(
      {Key key,
      this.value,
      this.title,
      this.leading,
      this.trailing,
      this.loadingText = 'Loading..',
      this.isLoading = false,
      this.isTwoLine = false,
      this.enabled = true,
      this.selected = false,
      this.dense = false,
      this.padding,
      this.onTap,
      this.config})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: dense,
      enabled: enabled && isLoading != true,
      selected: selected,
      contentPadding: padding,
      leading: leading,
      title: Text(title,
          style: config != null
              ? titleStyle.textStyle
              : TextStyle(color: Color(0x8A000000))),
      subtitle: isTwoLine ? _valueWidget : null,
      trailing: _trailingWidget,
      onTap: onTap,
    );
  }

  Widget get _trailingWidget {
    return isTwoLine != true
        ? Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(maxWidth: 100),
                  child: _valueWidget,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: _trailingIconWidget,
                ),
              ],
            ),
          )
        : _trailingIconWidget;
  }

  Widget get _trailingIconWidget {
    return isLoading != true
        ? trailing != null
            ? trailing
            : Icon(Icons.keyboard_arrow_right, color: Colors.grey)
        : SizedBox(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black45),
              strokeWidth: 1.5,
            ),
            height: 16.0,
            width: 16.0,
          );
  }

  Widget get _valueWidget {
    return Text(
      isLoading ? loadingText : value,
      style: TextStyle(color: Colors.grey),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  SmartSelectTileStyle get titleStyle {
    return config.style;
  }
}

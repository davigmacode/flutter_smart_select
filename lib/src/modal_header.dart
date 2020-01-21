import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './model/state_filter.dart';
import './model/modal_theme.dart';
import './model/modal_config.dart';

class SmartSelectModalHeader extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final SmartSelectModalType type;
  final SmartSelectModalConfig config;

  SmartSelectModalHeader({
    Key key,
    @required this.title,
    @required this.type,
    @required this.config,
  }) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    // get state
    SmartSelectStateFilter filter = Provider.of<SmartSelectStateFilter>(context);
    bool isFiltering = filter.activated;

    String modalTitle = config.title ?? title;

    // define text style
    TextStyle textStyle = Theme.of(context).textTheme.title.merge(theme.textStyle);

    // build title widget
    Widget titleWidget = Text(modalTitle, style: textStyle);

    // build search widget
    Widget searchWidget = TextField(
      controller: filter.ctrl,
      style: textStyle,
      autofocus: true,
      decoration: InputDecoration.collapsed(
        hintText: config.searchBarHint ?? 'Search on $title',
        hintStyle: textStyle,
      ),
      onSubmitted: filter.setQuery,
    );

    Widget confirmButton = config.useConfirmation && !isFiltering
      ? config.confirmationBuilder != null
        ? config.confirmationBuilder(context, () => Navigator.pop(context, true))
        : IconButton(
            icon: Icon(Icons.check_circle_outline),
            onPressed: () => Navigator.pop(context, true),
          )
      : null;

    Widget filterButton = config.useFilter && !isFiltering
      ? IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // add history to route, so back button will appear
            // and when physical back button pressed
            // will close the searchbar instead of close the modal
            LocalHistoryEntry entry = LocalHistoryEntry(onRemove: filter.stop);
            ModalRoute.of(context).addLocalHistoryEntry(entry);

            filter.start();
          },
        )
      : null;

    Widget clearButton = isFiltering == true
      ? IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            filter.stop();
            Navigator.pop(context);
          },
        )
      : null;

    return AppBar(
      shape: theme.shape,
      elevation: theme.elevation,
      brightness: theme.brightness,
      backgroundColor: theme.backgroundColor,
      actionsIconTheme: theme.actionsIconTheme,
      iconTheme: theme.iconTheme,
      centerTitle: theme.centerTitle,
      automaticallyImplyLeading: type == SmartSelectModalType.fullPage || isFiltering == true,
      title: isFiltering == true ? searchWidget : titleWidget,
      actions: <Widget>[
        filterButton,
        clearButton,
        confirmButton,
        Container(width: 5.0),
      ].where((child) => child != null).toList(),
    );
  }

  SmartSelectModalHeaderStyle get theme {
    return config.headerStyle;
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
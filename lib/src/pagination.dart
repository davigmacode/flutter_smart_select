import 'package:flutter/material.dart';

/// Widget that wraps the child with refresher and/or pagination
class S2Pagination extends StatelessWidget {
  /// Default constructor
  S2Pagination({
    Key? key,
    this.child,
    this.onReload,
    this.onAppend,
    this.reloadable = false,
    this.appendable = false,
  }) : super(key: key);

  /// The child widget that needs to wrapped with reloadable and/or appendable widget
  final Widget? child;

  /// A function called when the child widget need to refresh
  final VoidCallback? onReload;

  /// A function called when the child widget need to load more
  final VoidCallback? onAppend;

  /// Whether the child is realoadable or not
  final bool reloadable;

  /// Whether the child is appendable or not
  final bool appendable;

  @override
  Widget build(BuildContext context) {
    Widget? result = child;

    if (appendable) result = appendableWidget(result!);

    if (reloadable) result = reloadableWidget(result!);

    return result!;
  }

  /// Returns the child wrapped with
  Widget reloadableWidget(Widget child) {
    return RefreshIndicator(
      child: child,
      onRefresh: () async => onReload?.call(),
    );
  }

  /// Returns the child wrapped with
  Widget appendableWidget(Widget child) {
    return NotificationListener<ScrollNotification>(
      child: child,
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollEndNotification &&
            scrollInfo.metrics.extentAfter == 0) {
          onAppend?.call();
          return true;
        }
        return false;
      },
    );
  }
}

import 'package:flutter/widgets.dart';
import 'model/group_style.dart';

/// choice group header widget
class S2GroupHeader extends StatelessWidget {

  /// choice group title
  final Widget title;

  /// Trailing widget
  final Widget trailing;

  /// The header Style
  final S2GroupHeaderStyle style;

  /// default constructor
  S2GroupHeader({
    Key key,
    @required this.title,
    this.trailing,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: style.height,
      color: style.backgroundColor,
      padding: style.padding,
      child: Row(
        crossAxisAlignment: style.crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisAlignment: style.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
        children: <Widget>[
          title,
          trailing,
        ]..removeWhere((e) => e == null),
      ),
    );
  }
}
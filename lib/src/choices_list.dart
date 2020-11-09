import 'package:flutter/widgets.dart';
import 'model/builder.dart';
import 'model/choice_config.dart';
import 'model/choice_theme.dart';
import 'model/choice_item.dart';
import 'scrollbar.dart';

/// choices list widget
class S2ChoicesList<T> extends StatelessWidget {

  /// single choice widget builder
  final Widget Function(S2Choice<T>) itemBuilder;

  /// list of choice data
  final List<S2Choice<T>> items;

  /// configuration of single choice widget
  final S2ChoiceConfig config;

  /// collection of available builder widget
  final S2Builder<T> builder;

  /// default constructor
  S2ChoicesList({
    Key key,
    @required this.itemBuilder,
    @required this.items,
    @required this.config,
    @required this.builder,
  }) : super(key: key);

  /// get choice style
  S2ChoiceStyle get style => config.style;

  @override
  Widget build(BuildContext context) {
    Widget result = NotificationListener<ScrollNotification>(
      onNotification: (notification) => true,
      child: Scrollbar(
        child: config.isWrapLayout
          ? _listWrap()
          : config.isGridLayout
            ? _listGrid()
            : config.useDivider
              ? _listSeparated()
              : _listDefault(),
      ),
    );

    return config.direction == Axis.horizontal
      ? Wrap(children: <Widget>[result])
      : result;
  }

  Widget _listWrap() {
    return SingleChildScrollView(
      physics: config.physics,
      scrollDirection: config.direction,
      padding: config.padding ?? const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15.0,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          spacing: config.spacing ?? 12.0, // gap between adjacent chips
          runSpacing: config.runSpacing ?? 0.0, // gap between lines
          children: List<Widget>.generate(
            items.length,
            (i) => itemBuilder(items[i]),
          ).toList(),
        ),
      ),
    );
  }

  Widget _listDefault() {
    return ListView.builder(
      shrinkWrap: true,
      physics: config.physics,
      scrollDirection: config.direction,
      padding: config.padding ?? const EdgeInsets.symmetric(vertical: 10.0),
      itemCount: items.length,
      itemBuilder: (context, i) => itemBuilder(items[i]),
    );
  }

  Widget _listSeparated() {
    return ListView.separated(
      shrinkWrap: true,
      physics: config.physics,
      scrollDirection: config.direction,
      padding: config.padding ?? const EdgeInsets.symmetric(vertical: 10.0),
      itemCount: items.length,
      itemBuilder: (context, i) => itemBuilder(items[i]),
      separatorBuilder: builder.choiceDivider ?? _dividerBuilderDefault,
    );
  }

  Widget _listGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: config.physics,
      scrollDirection: config.direction,
      padding: config.padding ?? const EdgeInsets.all(10.0),
      itemCount: items.length,
      itemBuilder: (context, i) => itemBuilder(items[i]),
      gridDelegate: config.gridDelegate ?? SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: config.gridCount,
        crossAxisSpacing: config.gridSpacing,
        mainAxisSpacing: config.gridSpacing,
      ),
    );
  }

  Widget _dividerBuilderDefault(BuildContext context, int index) {
    return S2Divider(
      color: config.dividerColor,
      spacing: config.dividerSpacing,
      thickness: config.dividerThickness,
    );
  }
}

/// default divider widget
class S2Divider extends StatelessWidget {

  /// divider color
  final Color color;

  /// divider thickness
  final double thickness;

  /// divider spacing
  final double spacing;

  /// default constructor
  const S2Divider({
    Key key,
    this.color,
    this.thickness,
    this.spacing,
  }) : super(key: key);

  /// Default color of the divider widget
  static const Color defaultColor = const Color(0xFFEEEEEE);

  /// Default spacing of the divider widget
  static const double defaultSpacing = 4.0;

  /// Default thickness of the divider widget
  static const double defaultThickness = 1.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: spacing ?? S2Divider.defaultSpacing
      ),
      child: SizedBox(
        height: thickness ?? S2Divider.defaultThickness,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: color ?? S2Divider.defaultColor,
                width: thickness ?? S2Divider.defaultThickness,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
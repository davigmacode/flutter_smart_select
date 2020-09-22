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
        child: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: config.direction == Axis.vertical
              ? AxisDirection.down
              : AxisDirection.right,
            color: config.overscrollColor ?? config.style?.activeColor,
            child: config.layout == S2ChoiceLayout.wrap || config.type == S2ChoiceType.chips
              ? _listWrap()
              : config.layout == S2ChoiceLayout.grid
                ? _listGrid()
                : config.useDivider
                  ? _listSeparated()
                  : _listDefault()
          ),
        ),
      ),
    );

    return config.direction == Axis.horizontal
      ? Wrap(children: <Widget>[result])
      : result;
  }

  Widget _listWrap() {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      scrollDirection: config.direction,
      padding: style.wrapperPadding ?? const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15.0,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          spacing: style.spacing ?? 12.0, // gap between adjacent chips
          runSpacing: style.runSpacing ?? 0.0, // gap between lines
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
      physics: const ScrollPhysics(),
      scrollDirection: config.direction,
      padding: style.wrapperPadding ?? const EdgeInsets.symmetric(vertical: 10.0),
      itemCount: items.length,
      itemBuilder: (context, i) => itemBuilder(items[i]),
    );
  }

  Widget _listSeparated() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      scrollDirection: config.direction,
      padding: style.wrapperPadding ?? const EdgeInsets.symmetric(vertical: 10.0),
      itemCount: items.length,
      itemBuilder: (context, i) => itemBuilder(items[i]),
      separatorBuilder: builder.choiceDivider ?? _dividerBuilderDefault,
    );
  }

  Widget _listGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      scrollDirection: config.direction,
      padding: style.wrapperPadding ?? const EdgeInsets.all(10.0),
      itemCount: items.length,
      itemBuilder: (context, i) => itemBuilder(items[i]),
      gridDelegate: config.gridDelegate ?? SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  Widget _dividerBuilderDefault(BuildContext context, int index) {
    return S2Divider();
  }
}

/// default divider widget
class S2Divider extends StatelessWidget {

  /// divider color
  final Color color;

  /// divider height
  final double height;

  /// divider spacing
  final double spacing;

  /// default constructor
  const S2Divider({
    Key key,
    this.color,
    this.height,
    this.spacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: spacing ?? 4.0
      ),
      child: SizedBox(
        height: height ?? 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: color ?? Color(0xFFEEEEEE),
                width: height ?? 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
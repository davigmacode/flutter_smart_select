import 'package:flutter/widgets.dart';
import 'model/choice_config.dart';
import 'choice_divider.dart';
import 'scrollbar.dart';

/// Choices list widget
class S2ChoicesList<T> extends StatelessWidget {
  /// the length of the choice list
  final int itemLength;

  /// The builder of the choice item
  final IndexedWidgetBuilder itemBuilder;

  /// The builder of the choice divider
  final IndexedWidgetBuilder? dividerBuilder;

  /// Configuration of single choice widget
  final S2ChoiceConfig config;

  /// Default constructor
  S2ChoicesList({
    Key? key,
    required this.itemLength,
    required this.itemBuilder,
    required this.dividerBuilder,
    required this.config,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget result = NotificationListener<ScrollNotification>(
      onNotification: (notification) => false,
      child: Scrollbar(
        child: config.isWrapLayout
            ? _listWrap(context)
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

  Widget _listWrap(BuildContext context) {
    return SingleChildScrollView(
      physics: config.physics,
      scrollDirection: config.direction,
      padding: config.padding ??
          const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          spacing: config.spacing ?? 12.0, // gap between adjacent chips
          runSpacing: config.runSpacing ?? 0.0, // gap between lines
          children: List<Widget>.generate(
            itemLength,
            (i) => itemBuilder(context, i),
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
      itemCount: itemLength,
      itemBuilder: itemBuilder,
    );
  }

  Widget _listSeparated() {
    return ListView.separated(
      shrinkWrap: true,
      physics: config.physics,
      scrollDirection: config.direction,
      padding: config.padding ?? const EdgeInsets.symmetric(vertical: 10.0),
      itemCount: itemLength,
      itemBuilder: itemBuilder,
      separatorBuilder: dividerBuilder ?? _dividerBuilderDefault,
    );
  }

  Widget _listGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: config.physics,
      scrollDirection: config.direction,
      padding: config.padding ?? const EdgeInsets.all(10.0),
      itemCount: itemLength,
      itemBuilder: itemBuilder,
      gridDelegate: config.gridDelegate ??
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: config.gridCount,
            crossAxisSpacing: config.gridSpacing,
            mainAxisSpacing: config.gridSpacing,
          ),
    );
  }

  Widget _dividerBuilderDefault(BuildContext context, int index) {
    return Divider(
      color: config.dividerColor,
      thickness: config.dividerThickness,
      height: config.dividerSpacing,
    );
    // return S2Divider(
    //   color: config.dividerColor,
    //   spacing: config.dividerSpacing,
    //   thickness: config.dividerThickness,
    // );
  }
}

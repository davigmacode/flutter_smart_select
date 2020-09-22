import 'package:flutter/widgets.dart';
import 'model/builder.dart';
import 'model/choice_config.dart';
import 'model/choice_item.dart';
import 'model/choice_group.dart';
import 'choices_list.dart';
import 'scrollbar.dart';
import 'text.dart';

class S2ChoicesGrouped<T> extends StatelessWidget {

  final List<String> groupKeys;
  final Widget Function(S2Choice<T>) itemBuilder;
  final List<S2Choice<T>> items;
  final S2ChoiceConfig config;
  final S2Builder<T> builder;
  final String query;

  S2ChoicesGrouped({
    Key key,
    @required this.groupKeys,
    @required this.itemBuilder,
    @required this.items,
    @required this.config,
    @required this.builder,
    @required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: config.overscrollColor ?? config.style?.activeColor,
          child: ListView.builder(
            itemCount: groupKeys.length,
            itemBuilder: (BuildContext context, int i) {
              final String groupKey = groupKeys[i];
              final List<S2Choice<T>> groupItems = _groupItems(groupKey);
              final S2ChoiceGroup group = S2ChoiceGroup(
                name: groupKey,
                count: groupItems.length,
                style: config.headerStyle,
              );
              final Widget groupHeader = builder.choiceHeader?.call(context, group, query)
                ?? SmartSelectChoicesGroupedHeader(
                    group: group,
                    query: query,
                  );
              final Widget groupChoices = S2ChoicesList<T>(
                config: config,
                builder: builder,
                items: groupItems,
                itemBuilder: itemBuilder,
              );
              return builder.choiceGroup?.call(context, groupHeader, groupChoices)
                ?? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    groupHeader,
                    groupChoices,
                  ],
                );
            },
          ),
        ),
      ),
    );
  }

  /// return a list of group items
  List<S2Choice<T>> _groupItems(String key) {
    return items.where((S2Choice<T> item) => item.group == key).toList();
  }
}

class SmartSelectChoicesGroupedHeader extends StatelessWidget {

  final S2ChoiceGroup group;
  final String query;

  SmartSelectChoicesGroupedHeader({
    Key key,
    this.group,
    this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = DefaultTextStyle.of(context).style;
    return Container(
      height: group.style.height,
      color: group.style.backgroundColor,
      padding: group.style.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          S2Text(
            text: group.name,
            highlight: query,
            style: textStyle.merge(group.style.textStyle),
            highlightColor: group.style.highlightColor ?? Color(0xFFFFF176),
          ),
          Text(
            group.count.toString(),
            style: textStyle.merge(group.style.textStyle),
          ),
        ],
      ),
    );
  }
}
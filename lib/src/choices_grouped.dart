import 'package:flutter/widgets.dart';
// import 'package:sticky_headers/sticky_headers.dart';
import 'model/builder.dart';
import 'model/choice_config.dart';
import 'model/choice.dart';
import 'model/option.dart';
import 'choices_list.dart';
import 'text.dart';

class S2ChoicesGrouped<T> extends StatelessWidget {

  final List<String> groupKeys;
  final Widget Function(S2Option<T>) itemBuilder;
  final List<S2Option<T>> items;
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
    return ListView.builder(
      itemCount: groupKeys.length,
      itemBuilder: (BuildContext context, int i) {
        final String groupKey = groupKeys[i];
        final List<S2Option<T>> groupItems = _groupItems(groupKey);
        final S2ChoiceGroup group = S2ChoiceGroup(
          name: groupKey,
          count: groupItems.length,
          style: config.headerStyle,
        );
        final Widget groupHeader = builder.groupHeaderBuilder?.call(context, group, query)
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
        return builder.groupBuilder?.call(context, groupHeader, groupChoices)
          ?? Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              groupHeader,
              groupChoices,
            ],
          );
        // return StickyHeader(
        //   content: S2ChoicesList<T>(
        //     config: config,
        //     builder: builder,
        //     items: groupItems,
        //     itemBuilder: itemBuilder,
        //   ),
        //   header: builder.groupHeaderBuilder?.call(context, group, query)
        //     ?? SmartSelectChoicesGroupedHeader(
        //         group: group,
        //         query: query,
        //       ),
        // );
      },
    );
  }

  /// return a list of group items
  List<S2Option<T>> _groupItems(String key) {
    return items.where((S2Option<T> item) => item.group == key).toList();
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
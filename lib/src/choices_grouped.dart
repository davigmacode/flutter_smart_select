import 'package:flutter/widgets.dart';
import 'model/builder.dart';
import 'model/choice_config.dart';
import 'model/choice_item.dart';
import 'model/choice_group.dart';
import 'choices_list.dart';
import 'scrollbar.dart';
import 'text.dart';

/// grouped choices list widget
class S2ChoicesGrouped<T> extends StatelessWidget {

  /// list of string of group
  final List<S2ChoiceGroup> groups;

  /// item builder of choice widget
  final Widget Function(S2Choice<T>) itemBuilder;

  /// choices configuration
  final S2ChoiceConfig config;

  /// collection of builder widget
  final S2Builder<T> builder;

  /// current filter query
  final String query;

  /// default constructor
  S2ChoicesGrouped({
    Key key,
    @required this.groups,
    @required this.itemBuilder,
    @required this.config,
    @required this.builder,
    @required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (BuildContext context, int i) {
          final S2ChoiceGroup group = groups[i];
          final Widget groupHeader = builder.choiceHeader?.call(context, group, query)
            ?? S2ChoicesGroupedHeader(
                group: group,
                query: query,
              );
          final Widget groupChoices = S2ChoicesList<T>(
            config: config,
            builder: builder,
            items: group.items,
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
    );
  }
}

/// choice group header widget
class S2ChoicesGroupedHeader extends StatelessWidget {

  /// choices group data
  final S2ChoiceGroup group;

  /// current filter query
  final String query;

  /// default constructor
  S2ChoicesGroupedHeader({
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
        crossAxisAlignment: group.style.crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisAlignment: group.style.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
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
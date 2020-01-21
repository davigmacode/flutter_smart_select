import 'package:flutter/material.dart';
import './model/choice_config.dart';
import './model/option.dart';
import './choices_grouped.dart';
import './choices_list.dart';
import './choices_empty.dart';

class SmartSelectChoices<T> extends StatelessWidget {

  final List<SmartSelectOption<T>> items;
  final SmartSelectChoiceType type;
  final SmartSelectChoiceConfig<T> config;
  final String query;

  SmartSelectChoices({
    Key key,
    @required this.items,
    @required this.type,
    @required this.config,
    @required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: config.style.padding,
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: config.style.inactiveColor ?? Colors.black54,
        ),
        child: Scrollbar(
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: config.glowingOverscrollIndicatorColor,
              child: Builder(
                builder: (context) {
                  return items.length > 0
                    ? _isGrouped == true
                      ? SmartSelectChoicesGrouped<T>(_groupKeys, items, type, config)
                      : SmartSelectChoicesList<T>(items, type, config)
                    : config.emptyBuilder?.call(query) ?? SmartSelectChoicesEmpty();
                },
              )
            ),
          ),
        ),
      ),
    );
  }

  // return a list of group keys
  List<String> get _groupKeys {
    Set groups = Set();
    items.forEach((SmartSelectOption<T> item) => groups.add(item.group));
    return groups.toList().cast<String>();
  }

  bool get _isGrouped {
    return config.isGrouped && _groupKeys != null && _groupKeys.isNotEmpty;
  }
}

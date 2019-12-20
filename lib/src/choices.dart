import 'package:flutter/material.dart';
import './model/choice_config.dart';
import './model/option_item.dart';
import './choices_grouped.dart';
import './choices_list.dart';
import './choices_empty.dart';

class SmartSelectChoices extends StatelessWidget {

  final List<SmartSelectOptionItem> items;
  final SmartSelectChoiceConfig config;
  final bool useConfirmation;
  final bool isMultiChoice;
  final bool isGrouped;
  final String query;

  SmartSelectChoices({
    Key key,
    @required this.items,
    @required this.config,
    @required this.useConfirmation,
    @required this.isMultiChoice,
    @required this.isGrouped,
    this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      // contentPadding: EdgeInsets.symmetric(
      //   horizontal: isMultiChoice ? 25.0 : 10
      // ),
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
                    ? isGrouped == true
                      ? SmartSelectChoicesGrouped(useConfirmation, isMultiChoice, items, config)
                      : SmartSelectChoicesList(useConfirmation, isMultiChoice, items, config)
                    : config.emptyBuilder?.call(query) ?? SmartSelectChoicesEmpty();
                },
              )
            ),
          ),
        ),
      ),
    );
  }
}

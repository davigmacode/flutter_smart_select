import 'package:flutter/material.dart';
import './model/option.dart';
import './model/choice_config.dart';
import './choices_item.dart';

class SmartSelectChoicesList<T> extends StatelessWidget {

  final List<SmartSelectOption<T>> items;
  final SmartSelectChoiceType type;
  final SmartSelectChoiceConfig<T> config;

  SmartSelectChoicesList(
    this.items,
    this.type,
    this.config,
    { Key key }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return config.useWrap || type == SmartSelectChoiceType.chips
      ? _listWrap()
      : config.useDivider
        ? _listSeparated()
        : _listDefault();
  }

  Widget _listWrap() {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Container(
        width: double.infinity,
        padding: config.padding ?? EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        child: Wrap(
          spacing: config.spacing ?? 12.0, // gap between adjacent chips
          runSpacing: config.runSpacing ?? 0.0, // gap between lines
          children: List<Widget>.generate(
            items.length,
            (i) => ChoicesItem<T>(items[i], type, config),
          ).toList(),
        ),
      ),
    );
  }

  Widget _listDefault() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: config.padding ?? EdgeInsets.symmetric(vertical: 10.0),
      itemCount: items.length,
      itemBuilder: (context, i) => ChoicesItem<T>(items[i], type, config),
    );
  }

  Widget _listSeparated() {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: config.padding ?? EdgeInsets.symmetric(vertical: 10.0),
      itemCount: items.length,
      itemBuilder: (context, i) => ChoicesItem<T>(items[i], type, config),
      separatorBuilder: config.dividerBuilder ?? _dividerBuilderDefault,
    );
  }

  Widget _dividerBuilderDefault(BuildContext context, int index) {
    return Divider();
  }
}

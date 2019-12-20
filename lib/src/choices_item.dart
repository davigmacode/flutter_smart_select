import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './model/state_selected.dart';
import './model/option_item.dart';
import './model/choice_theme.dart';
import './model/choice_config.dart';
import './utils.dart' as utils;

class ChoicesItem extends StatelessWidget {

  final bool useConfirmation;
  final bool isMultiChoice;
  final SmartSelectOptionItem data;
  final SmartSelectChoiceConfig config;

  ChoicesItem(
    this.useConfirmation,
    this.isMultiChoice,
    this.data,
    this.config,
    { Key key }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // build title widget
    final Widget title = data.title != null
      ? config.titleBuilder != null
        ? config.titleBuilder(context, data)
        : Text(
            data.title,
            style: config.style.titleStyle,
          )
      : null;

    // build subtitle widget
    final Widget subtitle = data.subtitle != null
      ? config.subtitleBuilder != null
        ? config.subtitleBuilder(context, data)
        : Text(
            data.subtitle,
            style: config.style.subtitleStyle,
          )
      : null;

    // build secondary/avatar widget
    final Widget secondary = config.secondaryBuilder?.call(context, data);

    // return widget
    return Consumer<SmartSelectStateSelected>(
      builder: (context, state, _) {
        final bool isSelected = state.contains(data.value, isMultiChoice);

        // build onSelect callback
        final SmartSelectChoiceOnSelect onSelect = (dynamic value, [bool checked = true]) {
          state.select(value, checked, () {
            if (isMultiChoice != true) {
              // Pop filtering status
              bool isFiltering = utils.getStateFilter(context).activated;
              if (isFiltering) Navigator.pop(context);
              // Pop navigator with confirmed return value
              if (!useConfirmation) Navigator.pop(context, true);
            }
          });
        };

        // when null, get the default choice type
        SmartSelectChoiceType choiceType = config.type == null
          ? isMultiChoice
            ? SmartSelectChoiceType.checkboxes
            : SmartSelectChoiceType.radios
          : config.type;

        if (config.builder == null) {
          if (isMultiChoice == true) {
            return MultiChoicesItem(
              title: title,
              subtitle: subtitle,
              secondary: secondary,
              choiceType: choiceType,
              theme: config.style,
              onSelect: onSelect,
              checked: isSelected,
              value: data.value
            );
          } else {
            return SingleChoicesItem(
              title: title,
              subtitle: subtitle,
              secondary: secondary,
              choiceType: choiceType,
              theme: config.style,
              onSelect: onSelect,
              checked: isSelected,
              groupValue: state.value,
              value: data.value
            );
          }
        } else {
          return config.builder(data, isSelected, onSelect);
        }
      }
    );
  }
}

class SingleChoicesItem extends StatelessWidget {

  final Widget title;
  final Widget subtitle;
  final Widget secondary;
  final SmartSelectChoiceType choiceType;
  final SmartSelectChoiceStyle theme;
  final SmartSelectChoiceOnSelect onSelect;
  final bool checked;
  final dynamic groupValue;
  final dynamic value;

   SingleChoicesItem({
    Key key,
    this.title,
    this.subtitle,
    this.secondary,
    this.choiceType,
    this.theme,
    this.onSelect,
    this.checked,
    this.groupValue,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (choiceType == SmartSelectChoiceType.radios) {
      return RadioListTile(
        title: title,
        subtitle: subtitle,
        secondary: secondary,
        activeColor: theme.activeColor ?? Colors.black54,
        onChanged: (val) => onSelect(val, true),
        groupValue: groupValue,
        value: value,
      );
    } else if (choiceType == SmartSelectChoiceType.chips) {
      return ChoiceChip(
        label: title,
        avatar: secondary,
        backgroundColor: theme.activeTrackColor ?? Colors.transparent,
        shape: StadiumBorder(
          side: BorderSide(
            color: theme.inactiveColor ?? Colors.black12,
          ),
        ),
        selectedColor: theme.activeColor ?? Colors.blueGrey[50],
        onSelected: (_) => onSelect(value, true),
        selected: checked,
      );
    } else {
      return ListTile(
        leading: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
        title: Text(
          'Unsupported choice type',
          style: TextStyle(color: Colors.red),
        ),
      );
    }
  }
}

class MultiChoicesItem extends StatelessWidget {

  final Widget title;
  final Widget subtitle;
  final Widget secondary;
  final SmartSelectChoiceType choiceType;
  final SmartSelectChoiceStyle theme;
  final SmartSelectChoiceOnSelect onSelect;
  final bool checked;
  final dynamic value;

   MultiChoicesItem({
    Key key,
    this.title,
    this.subtitle,
    this.secondary,
    this.choiceType,
    this.theme,
    this.onSelect,
    this.checked,
    this.value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (choiceType == SmartSelectChoiceType.checkboxes) {
      return CheckboxListTile(
        title: title,
        subtitle: subtitle,
        secondary: secondary,
        checkColor: theme.checkColor ?? Colors.white,
        activeColor: theme.activeColor ?? Colors.black54,
        onChanged: (selected) => onSelect(value, selected),
        value: checked,
      );
    } else if (choiceType == SmartSelectChoiceType.switches) {
      return SwitchListTile(
        title: title,
        subtitle: subtitle,
        secondary: secondary,
        activeColor: theme.activeColor ?? Colors.black38,
        activeThumbImage: theme.activeThumbImage,
        activeTrackColor: theme.activeTrackColor,
        inactiveThumbColor: theme.inactiveThumbColor,
        inactiveThumbImage: theme.inactiveThumbImage,
        inactiveTrackColor: theme.inactiveTrackColor,
        onChanged: (selected) => onSelect(value, selected),
        value: checked,
      );
    } else if (choiceType == SmartSelectChoiceType.chips) {
      return FilterChip(
        label: title,
        avatar: secondary,
        backgroundColor: theme.inactiveTrackColor ?? Colors.transparent,
        shape: StadiumBorder(
          side: BorderSide(
            color: theme.inactiveColor ?? Colors.black12,
          ),
        ),
        checkmarkColor: theme.checkColor,
        selectedColor: theme.activeColor ?? Colors.blueGrey[50],
        onSelected: (selected) => onSelect(value, selected),
        selected: checked,
      );
    } else {
      return ListTile(
        leading: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
        title: Text(
          'Unsupported choice type',
          style: TextStyle(color: Colors.red),
        ),
      );
    }
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider, Consumer;
import './model/state_selected.dart';
import './model/state_filter.dart';
import './model/option.dart';
import './model/choice_theme.dart';
import './model/choice_config.dart';

class ChoicesItem<T> extends StatelessWidget {

  final SmartSelectOption<T> data;
  final SmartSelectChoiceType type;
  final SmartSelectChoiceConfig<T> config;

  ChoicesItem(
    this.data,
    this.type,
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
    return Consumer<SmartSelectStateSelected<T>>(
      builder: (context, state, _) {
        final bool isSelected = state.contains(data.value);

        // build onSelect callback
        final SmartSelectChoiceOnSelect<T> onSelect = (T value, [bool checked = true]) {
          state.select(value, checked, () {
            if (state.isMultiChoice != true) {
              // Pop filtering status
              bool isFiltering = Provider.of<SmartSelectStateFilter>(context, listen: false).activated;
              if (isFiltering) Navigator.pop(context);
              // Pop navigator with confirmed return value
              if (!state.useConfirmation) Navigator.pop(context, true);
            }
          });
        };

        // when null, get the default choice type
        SmartSelectChoiceType choiceType = type == null
          ? state.isMultiChoice
            ? SmartSelectChoiceType.checkboxes
            : SmartSelectChoiceType.radios
          : type;

        if (config.builder == null) {
          if (state.isMultiChoice == true) {
            return MultiChoicesItem<T>(
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
            return SingleChoicesItem<T>(
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

class SingleChoicesItem<T> extends StatelessWidget {

  final Widget title;
  final Widget subtitle;
  final Widget secondary;
  final SmartSelectChoiceType choiceType;
  final SmartSelectChoiceStyle theme;
  final SmartSelectChoiceOnSelect<T> onSelect;
  final bool checked;
  final T groupValue;
  final T value;

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
        shape: StadiumBorder(
          side: BorderSide(
            color: theme.inactiveColor ?? Colors.black12,
          ),
        ),
        backgroundColor: theme.activeTrackColor ?? Colors.transparent,
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

class MultiChoicesItem<T> extends StatelessWidget {

  final Widget title;
  final Widget subtitle;
  final Widget secondary;
  final SmartSelectChoiceType choiceType;
  final SmartSelectChoiceStyle theme;
  final SmartSelectChoiceOnSelect<T> onSelect;
  final bool checked;
  final T value;

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
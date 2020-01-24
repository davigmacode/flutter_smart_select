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
    // get style
    final SmartSelectChoiceStyle style = config.style;

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

        // build onSelect callback if option enabled
        final SmartSelectChoiceOnSelect<T> onSelect = data.disabled == true
          ? null
          : (T value, [bool checked = true]) {
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

        Widget choiceWidget;

        if (config.builder == null) {
          if (state.isMultiChoice == true) {
            if (choiceType == SmartSelectChoiceType.checkboxes) {
              choiceWidget = CheckboxListTile(
                title: title,
                subtitle: subtitle,
                secondary: secondary,
                checkColor: style.checkColor ?? Colors.white,
                activeColor: style.activeColor ?? Colors.black54,
                onChanged: onSelect != null
                  ? (selected) => onSelect(data.value, selected)
                  : null,
                value: isSelected,
              );
            } else if (choiceType == SmartSelectChoiceType.switches) {
              choiceWidget = SwitchListTile(
                title: title,
                subtitle: subtitle,
                secondary: secondary,
                activeColor: style.activeColor ?? Colors.black38,
                activeThumbImage: style.activeThumbImage,
                activeTrackColor: style.activeTrackColor,
                inactiveThumbColor: style.inactiveThumbColor,
                inactiveThumbImage: style.inactiveThumbImage,
                inactiveTrackColor: style.inactiveTrackColor,
                onChanged: onSelect != null
                  ? (selected) => onSelect(data.value, selected)
                  : null,
                value: isSelected,
              );
            } else if (choiceType == SmartSelectChoiceType.chips) {
              choiceWidget = FilterChip(
                label: title,
                avatar: secondary,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: style.inactiveColor ?? Colors.black12,
                  ),
                ),
                showCheckmark: config.useCheckmark,
                checkmarkColor: style.checkColor,
                selectedColor: style.activeColor ?? Colors.blueGrey[50],
                backgroundColor: style.inactiveTrackColor ?? Colors.transparent,
                onSelected: onSelect != null
                  ? (selected) => onSelect(data.value, selected)
                  : null,
                selected: isSelected,
              );
            }
          } else {
            if (choiceType == SmartSelectChoiceType.radios) {
              choiceWidget = RadioListTile(
                title: title,
                subtitle: subtitle,
                secondary: secondary,
                activeColor: style.activeColor ?? Colors.black54,
                onChanged: onSelect != null ? (val) => onSelect(val, true) : null,
                groupValue: state.value,
                value: data.value,
              );
            } else if (choiceType == SmartSelectChoiceType.chips) {
              choiceWidget = FilterChip(
                label: title,
                avatar: secondary,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: style.inactiveColor ?? Colors.black12,
                  ),
                ),
                showCheckmark: config.useCheckmark,
                checkmarkColor: style.checkColor,
                selectedColor: style.activeColor ?? Colors.blueGrey[50],
                backgroundColor: style.inactiveTrackColor ?? Colors.transparent,
                onSelected: onSelect != null ? (_) => onSelect(data.value, true) : null,
                selected: isSelected,
              );
            }
          }
        } else {
          choiceWidget = config.builder(data, isSelected, onSelect);
        }

        return choiceWidget;
      }
    );
  }
}
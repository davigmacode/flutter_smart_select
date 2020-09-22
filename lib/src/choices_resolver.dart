import 'package:flutter/material.dart';
import 'model/builder.dart';
import 'model/choice_config.dart';
import 'model/choice_theme.dart';
import 'model/choice_item.dart';
import 'text.dart';

class S2ChoiceResolver<T> {

  final bool isMultiChoice;
  final S2ChoiceType type;
  final S2ChoiceStyle style;
  final S2Builder<T> builder;

  S2ChoiceResolver({
    @required this.isMultiChoice,
    @required this.type,
    @required this.style,
    @required this.builder,
  });

  S2ChoiceBuilder<T> get choiceBuilder {
    return builder.choice ?? defaultChoiceBuilder;
  }

  S2ChoiceBuilder<T> get defaultChoiceBuilder {
    return type == S2ChoiceType.checkboxes
      ? checkboxBuilder
      : type == S2ChoiceType.switches
        ? switchBuilder
        : type == S2ChoiceType.chips
          ? chipBuilder
          : type == S2ChoiceType.radios
            ? radioBuilder
            : null;
  }

  S2ChoiceBuilder<T> get radioBuilder => (
    BuildContext context,
    S2Choice<T> choice,
    String searchText,
  ) => RadioListTile(
        title: getTitle(context, choice, searchText),
        subtitle: getSubtitle(context, choice, searchText),
        secondary: getSecondary(context, choice, searchText),
        activeColor: style.activeColor,
        controlAffinity: ListTileControlAffinity.values[style.control?.index ?? 2],
        onChanged: choice.disabled != true ? (val) => choice.select(true) : null,
        groupValue: choice.selected == true ? choice.value : null,
        value: choice.value,
      );

  S2ChoiceBuilder<T> get switchBuilder => (
    BuildContext context,
    S2Choice<T> choice,
    String searchText,
  ) => SwitchListTile(
        title: getTitle(context, choice, searchText),
        subtitle: getSubtitle(context, choice, searchText),
        secondary: getSecondary(context, choice, searchText),
        activeColor: style.activeAccentColor ?? style.activeColor,
        activeTrackColor: style.activeColor?.withAlpha(0x80),
        inactiveThumbColor: style.accentColor,
        inactiveTrackColor: style.color?.withAlpha(0x80),
        onChanged: choice.disabled != true
          ? (selected) => choice.select(selected)
          : null,
        value: choice.selected,
      );

  S2ChoiceBuilder<T> get checkboxBuilder => (
    BuildContext context,
    S2Choice<T> choice,
    String searchText,
  ) => CheckboxListTile(
        title: getTitle(context, choice, searchText),
        subtitle: getSubtitle(context, choice, searchText),
        secondary: getSecondary(context, choice, searchText),
        activeColor: style.activeColor,
        controlAffinity: ListTileControlAffinity.values[style.control?.index ?? 2],
        onChanged: choice.disabled != true
          ? (selected) => choice.select(selected)
          : null,
        value: choice.selected,
      );

  S2ChoiceBuilder<T> get chipBuilder => (
    BuildContext context,
    S2Choice<T> choice,
    String searchText,
  ) {
    final bool isDark = choice.selected
      ? style.activeBrightness == Brightness.dark
      : style.brightness == Brightness.dark;

    final Color textColor = isDark
      ? Colors.white
      : choice.selected ? style.activeColor : style.color;

    final Color borderColor = isDark
      ? Colors.transparent
      : choice.selected
        ? (style.activeAccentColor ?? style.activeColor)?.withOpacity(style.activeBorderOpacity ?? .2)
        : (style.accentColor ?? style.color)?.withOpacity(style.borderOpacity ?? .2);

    final Color checkmarkColor = isDark
      ? textColor
      : style.activeColor;

    final Color backgroundColor = isDark
      ? style.color
      : Colors.transparent;

    final Color selectedBackgroundColor = isDark
      ? style.activeColor
      : Colors.transparent;

    return FilterChip(
      label: getTitle(context, choice, searchText),
      avatar: getSecondary(context, choice, searchText),
      shape: StadiumBorder(
        side: BorderSide(color: borderColor),
      ),
      labelStyle: TextStyle(
        color: textColor
      ),
      clipBehavior: style.clipBehavior ?? Clip.none,
      showCheckmark: style.showCheckmark ?? isMultiChoice ? true : false,
      checkmarkColor: checkmarkColor,
      shadowColor: style.color,
      selectedShadowColor: style.activeColor,
      backgroundColor: backgroundColor,
      selectedColor: selectedBackgroundColor,
      onSelected: choice.disabled != true
        ? (selected) => choice.select(selected)
        : null,
      selected: choice.selected,
    );
  };

  // build title widget
  Widget getTitle(BuildContext context, S2Choice<T> choice, String searchText) {
    return choice.title != null
    ? builder.choiceTitle != null
      ? builder.choiceTitle(context, choice, searchText)
      : S2Text(
          text: choice.title,
          style: style.titleStyle,
          highlight: searchText,
          highlightColor: style.highlightColor ?? Colors.yellow.withOpacity(.7),
        )
    : null;
  }

  // build subtitle widget
  Widget getSubtitle(BuildContext context, S2Choice<T> choice, String searchText) {
    return choice.subtitle != null
      ? builder.choiceSubtitle != null
        ? builder.choiceSubtitle(context, choice, searchText)
        : S2Text(
            text: choice.subtitle,
            style: style.subtitleStyle,
            highlight: searchText,
            highlightColor: style.highlightColor ?? Colors.yellow.withOpacity(.7),
          )
      : null;
  }

  // build secondary/avatar widget
  Widget getSecondary(BuildContext context, S2Choice<T> choice, String searchText) {
    return builder.choiceSecondary?.call(context, choice, searchText);
  }
}
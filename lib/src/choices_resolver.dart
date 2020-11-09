import 'package:flutter/material.dart';
import 'model/builder.dart';
import 'model/choice_config.dart';
import 'model/choice_theme.dart';
import 'model/choice_item.dart';
import 'text.dart';

/// resolve the choice builder based on choice type
class S2ChoiceResolver<T> {

  /// whether single or multiple choice
  final bool isMultiChoice;

  /// the choice type
  final S2ChoiceType type;

  /// the collection of available builder widget
  final S2Builder<T> builder;

  /// default constructor
  S2ChoiceResolver({
    @required this.isMultiChoice,
    @required this.type,
    @required this.builder,
  });

  /// get default brightness for chips widget
  Brightness get defaultBrightness => isMultiChoice == true
    ? Brightness.light
    : Brightness.dark;

  /// get the choice builder
  S2ChoiceBuilder<T> get choiceBuilder {
    return builder.choice ?? defaultChoiceBuilder;
  }

  /// get correct builder based on choice type
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

  /// get radio builder
  S2ChoiceBuilder<T> get radioBuilder => (
    BuildContext context,
    S2Choice<T> choice,
    String searchText,
  ) => RadioListTile(
        title: getTitle(context, choice, searchText),
        subtitle: getSubtitle(context, choice, searchText),
        secondary: getSecondary(context, choice, searchText),
        activeColor: choice.activeStyle.color,
        controlAffinity: ListTileControlAffinity.values[choice.effectiveStyle.control?.index ?? 2],
        onChanged: choice.disabled != true ? (val) => choice.select(true) : null,
        groupValue: choice.selected == true ? choice.value : null,
        value: choice.value,
      );

  /// get switch builder
  S2ChoiceBuilder<T> get switchBuilder => (
    BuildContext context,
    S2Choice<T> choice,
    String searchText,
  ) => SwitchListTile(
        title: getTitle(context, choice, searchText),
        subtitle: getSubtitle(context, choice, searchText),
        secondary: getSecondary(context, choice, searchText),
        activeColor: choice.activeStyle.accentColor ?? choice.activeStyle.color,
        activeTrackColor: choice.activeStyle.color?.withAlpha(0x80),
        inactiveThumbColor: choice.style.accentColor,
        inactiveTrackColor: choice.style.color?.withAlpha(0x80),
        contentPadding: choice.effectiveStyle.padding,
        controlAffinity: ListTileControlAffinity.values[choice.effectiveStyle.control?.index ?? 2],
        onChanged: choice.disabled != true
          ? (selected) => choice.select(selected)
          : null,
        value: choice.selected,
      );

  /// get checkbox builder
  S2ChoiceBuilder<T> get checkboxBuilder => (
    BuildContext context,
    S2Choice<T> choice,
    String searchText,
  ) => CheckboxListTile(
        title: getTitle(context, choice, searchText),
        subtitle: getSubtitle(context, choice, searchText),
        secondary: getSecondary(context, choice, searchText),
        activeColor: choice.activeStyle.color,
        contentPadding: choice.effectiveStyle.padding,
        controlAffinity: ListTileControlAffinity.values[choice.effectiveStyle.control?.index ?? 2],
        onChanged: choice.disabled != true
          ? (selected) => choice.select(selected)
          : null,
        value: choice.selected,
      );

  /// get chip builder
  S2ChoiceBuilder<T> get chipBuilder => (
    BuildContext context,
    S2Choice<T> choice,
    String searchText,
  ) {
    final S2ChoiceStyle effectiveStyle = choice.effectiveStyle;
    final Brightness effectiveBrightness = effectiveStyle.brightness ?? defaultBrightness;
    final isDark = effectiveBrightness == Brightness.dark;

    final Color textColor = isDark == true
      ? Colors.white
      : effectiveStyle?.color ?? (choice.selected == true
        ? Theme.of(context).primaryColor
        : Theme.of(context).unselectedWidgetColor);

    final Color borderColor = isDark == true
      ? Colors.transparent
      : (effectiveStyle?.accentColor ?? textColor)?.withOpacity(effectiveStyle?.borderOpacity ?? .2);

    final Color checkmarkColor = textColor;

    final Color backgroundColor = isDark == true
      ? choice.style?.color ?? Theme.of(context).unselectedWidgetColor
      : Colors.transparent;

    final Color selectedBackgroundColor = isDark == true
      ? choice.activeStyle?.color ?? Theme.of(context).primaryColor
      : Colors.transparent;

    return Padding(
      padding: effectiveStyle?.margin ?? const EdgeInsets.all(0),
      child: RawChip(
        padding: effectiveStyle?.padding ?? const EdgeInsets.all(4),
        label: getTitle(context, choice, searchText),
        labelStyle: TextStyle(color: textColor).merge(effectiveStyle?.titleStyle),
        avatar: getSecondary(context, choice, searchText),
        shape: StadiumBorder(
          side: BorderSide(color: borderColor),
        ),
        clipBehavior: choice.style?.clipBehavior ?? Clip.none,
        showCheckmark: choice.effectiveStyle?.showCheckmark ?? isMultiChoice,
        checkmarkColor: checkmarkColor,
        shadowColor: choice.style?.color,
        selectedShadowColor: choice.activeStyle?.color,
        backgroundColor: backgroundColor,
        selectedColor: selectedBackgroundColor,
        isEnabled: choice.disabled != true,
        onSelected: (selected) => choice.select(selected),
        selected: choice.selected,
      ),
    );
  };

  /// build title widget
  Widget getTitle(BuildContext context, S2Choice<T> choice, String searchText) {
    return choice.title != null
    ? builder.choiceTitle != null
      ? builder.choiceTitle(context, choice, searchText)
      : S2Text(
          text: choice.title,
          style: choice.effectiveStyle.titleStyle,
          highlight: searchText,
          highlightColor: choice.effectiveStyle.highlightColor,
        )
    : null;
  }

  /// build subtitle widget
  Widget getSubtitle(BuildContext context, S2Choice<T> choice, String searchText) {
    return choice.subtitle != null
      ? builder.choiceSubtitle != null
        ? builder.choiceSubtitle(context, choice, searchText)
        : S2Text(
            text: choice.subtitle,
            style: choice.effectiveStyle.subtitleStyle,
            highlight: searchText,
            highlightColor: choice.effectiveStyle.highlightColor,
          )
      : null;
  }

  /// build secondary/avatar widget
  Widget getSecondary(BuildContext context, S2Choice<T> choice, String searchText) {
    return builder.choiceSecondary?.call(context, choice, searchText);
  }
}
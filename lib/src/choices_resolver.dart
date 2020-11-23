import 'package:flutter/material.dart';
import 'model/builder.dart';
import 'model/choice_config.dart';
import 'model/choice_theme.dart';
import 'model/choice_item.dart';
import 'chip_theme.dart';
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
  ) => RadioListTile<T>(
        key: ValueKey(choice.value),
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
        key: ValueKey(choice.value),
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
        key: ValueKey(choice.value),
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

    return S2ChipTheme(
      color: effectiveStyle.color,
      outlined: effectiveStyle.outlined,
      raised: effectiveStyle.raised,
      elevation: effectiveStyle.elevation,
      opacity: effectiveStyle.elevation,
      shape: effectiveStyle.shape,
      labelStyle: effectiveStyle.titleStyle,
      selected: choice.selected,
      child: Padding(
        padding: effectiveStyle?.margin ?? const EdgeInsets.all(0),
        child: RawChip(
          key: ValueKey(choice.value),
          padding: effectiveStyle?.padding ?? const EdgeInsets.all(4),
          label: getTitle(context, choice, searchText),
          avatar: getSecondary(context, choice, searchText),
          clipBehavior: effectiveStyle?.clipBehavior ?? Clip.none,
          showCheckmark: effectiveStyle?.showCheckmark ?? isMultiChoice,
          isEnabled: choice.disabled != true,
          onSelected: (selected) => choice.select(selected),
          selected: choice.selected,
        ),
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
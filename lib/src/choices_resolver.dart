import 'package:flutter/material.dart';
import 'model/builder.dart';
import 'model/choice_config.dart';
import 'model/choice_theme.dart';
import 'model/choice_item.dart';
// import 'utils/color.dart';
import 'chip_theme.dart';
import 'widget.dart';

/// resolve the choice builder based on choice type
abstract class S2ChoiceResolver<T> {

  // /// whether single or multiple choice
  // final bool isMultiChoice;

  // /// the choice type
  // final S2ChoiceType type;

  // final S2ChoiceBuilder<T> titleBuilder;
  // final S2ChoiceBuilder<T> subtitleBuilder;
  // final S2ChoiceBuilder<T> secondaryBuilder;

  // /// default constructor
  // S2ChoiceResolver({
  //   @required this.isMultiChoice,
  //   @required this.type,
  //   @required this.titleBuilder,
  //   @required this.secondaryBuilder,
  //   @required this.subtitleBuilder,
  // });

  /// get correct builder based on choice type
  static S2ComplexWidgetBuilder<A, S2Choice<T>> choiceBuilder<A extends S2State, T>(S2ChoiceType type) {
    return type == S2ChoiceType.checkboxes
      ? checkboxBuilder
      : type == S2ChoiceType.switches
        ? switchBuilder
        : type == S2ChoiceType.chips
          ? chipBuilder
          : type == S2ChoiceType.radios
            ? radioBuilder
            : type == S2ChoiceType.cards
              ? cardBuilder
              : null;
  }

  /// get radio builder
  static Widget radioBuilder<A extends S2State, T>(
    BuildContext context,
    A state,
    S2Choice<T> choice,
  ) => RadioListTile<T>(
        key: ValueKey(choice.value),
        title: state.choiceTitle(context, state, choice),
        subtitle: state.choiceSubtitle(context, state, choice),
        secondary: state.choiceSecondary(context, state, choice),
        activeColor: choice.activeStyle.color,
        controlAffinity: ListTileControlAffinity.values[choice.effectiveStyle.control?.index ?? 2],
        onChanged: choice.disabled != true ? (val) => choice.select(true) : null,
        groupValue: choice.selected == true ? choice.value : null,
        value: choice.value,
      );

  /// get switch builder
  static Widget switchBuilder<A extends S2State, T>(
    BuildContext context,
    A state,
    S2Choice<T> choice,
  ) => SwitchListTile(
        key: ValueKey(choice.value),
        title: state.choiceTitle(context, state, choice),
        subtitle: state.choiceSubtitle(context, state, choice),
        secondary: state.choiceSecondary(context, state, choice),
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
  static Widget checkboxBuilder<A extends S2State, T>(
    BuildContext context,
    A state,
    S2Choice<T> choice,
  ) => CheckboxListTile(
        key: ValueKey(choice.value),
        title: state.choiceTitle(context, state, choice),
        subtitle: state.choiceSubtitle(context, state, choice),
        secondary: state.choiceSecondary(context, state, choice),
        activeColor: choice.activeStyle.color,
        contentPadding: choice.effectiveStyle.padding,
        controlAffinity: ListTileControlAffinity.values[choice.effectiveStyle.control?.index ?? 2],
        onChanged: choice.disabled != true
          ? (selected) => choice.select(selected)
          : null,
        value: choice.selected,
      );

  /// get chip builder
  static Widget chipBuilder<A extends S2State, T>(
    BuildContext context,
    A state,
    S2Choice<T> choice,
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
          label: state.choiceTitle(context, state, choice),
          avatar: state.choiceSecondary(context, state, choice),
          clipBehavior: effectiveStyle?.clipBehavior ?? Clip.none,
          showCheckmark: effectiveStyle?.showCheckmark ?? state.isMultiChoice,
          isEnabled: choice.disabled != true,
          onSelected: (selected) => choice.select(selected),
          selected: choice.selected,
        ),
      ),
    );
  }

  /// get chip builder
  static Widget cardBuilder<A extends S2State, T>(
    BuildContext context,
    A state,
    S2Choice<T> choice,
  ) {
    // final Color backgroundColor = choice.selected
    //   ? choice.activeStyle.color ?? state.theme.primaryColor
    //   : choice.style.color ?? state.theme.cardColor;
    // final Brightness backgroundBrightness = estimateBrightnessForColor(backgroundColor);
    // final Color textColor = backgroundBrightness == Brightness.dark
    //   ? Colors.white
    //   : Colors.black;

    return Card(
      elevation: choice.effectiveStyle.elevation,
      margin: choice.effectiveStyle.margin,
      // margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      color: choice.selected
        ? choice.activeStyle.color ?? state.theme.primaryColor
        : choice.style.color ?? state.theme.cardColor,
      child: InkWell(
        onTap: () => choice.select(true),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              state.choiceSecondary(context, state, choice),
              SizedBox(height: choice.effectiveStyle.spacing),
              state.choiceTitle(context, state, choice),
            ]..removeWhere((e) => e == null),
          ),
        ),
      ),
    );
  }
}
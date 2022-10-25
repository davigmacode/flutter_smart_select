import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';

/// State for Multiple Choice
class S2MultiState<T> extends S2State<T> {
  /// State of the selected choice(s)

  /// State of choice(s) selection in the modal
  @override
  S2MultiSelection<T>? selection;

  @override
  void onChange() {
    selected.choice = selection?.choice;
    widget.multiOnChange?.call(selected);
  }

  @override
  void onSelect(S2Choice<T> choice) {
    widget.multiOnSelect?.call(this, choice);
  }

  @override
  void onModalOpen() {
    widget.multiOnModalOpen?.call(this);
  }

  @override
  void onModalClose(bool confirmed) {
    widget.multiOnModalClose?.call(this, confirmed);
    super.onModalClose(confirmed);
  }

  @override
  Future<bool>? onModalWillOpen() {
    return widget.multiOnModalWillOpen?.call(this);
  }

  @override
  Future<bool> onModalWillClose() {
    return widget.multiOnModalWillClose?.call(this) ?? defaultModalWillClose();
  }

  @override
  S2MultiBuilder<T>? get builder {
    return widget.multiBuilder;
  }

  @override
  S2Validation<S2MultiChosen<T>>? get validation {
    return widget.multiValidation;
  }

  @override
  S2Validation<S2MultiChosen<T>>? get modalValidation {
    return widget.multiModalValidation ?? validation;
  }

  @override
  void resolveSelected() async {
    if (widget.multiSelected != null) {
      selected
        ..addListener(selectedHandler)
        ..resolve(defaultResolver: (value) async {
          return widget.choiceItems
              ?.where(
                  (S2Choice<T> item) => value?.contains(item.value) ?? false)
              .toList()
              .cast<S2Choice<T>>();
        });
    }
  }

  @override
  void resolveSelection() {
    // set the initial selection
    selection = S2MultiSelection<T>(
      initial: selected.choice,
      validation: modalValidation,
    )
      ..addListener(selectionHandler)
      ..validate();
  }

  @override
  void didUpdateWidget(SmartSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // reset the initial value
    if (oldWidget.multiSelected != widget.multiSelected) resolveSelected();
  }

  @override
  Widget build(BuildContext context) {
    return builder?.tile?.call(context, this) ?? defaultTile;
  }

  @override
  Widget? get customModal {
    return builder?.modal?.call(modalContext, this);
  }

  @override
  Widget? get modalDivider {
    return builder?.modalDivider?.call(modalContext, this);
  }

  @override
  Widget? get modalFooter {
    return builder?.modalFooter?.call(modalContext, this);
  }

  @override
  Widget? get customModalHeader {
    return builder?.modalHeader?.call(modalContext, this);
  }

  @override
  Widget? get customModalFilter {
    return builder?.modalFilter?.call(modalContext, this);
  }

  @override
  Widget? get customModalFilterToggle {
    return builder?.modalFilterToggle?.call(modalContext, this);
  }

  @override
  List<Widget>? get customModalActions {
    return builder?.modalActions?.call(modalContext, this);
  }

  @override
  Widget? get customConfirmButton {
    return builder?.modalConfirm?.call(modalContext, this);
  }

  @override
  Widget? get customChoiceEmpty {
    return builder!.choiceEmpty?.call(modalContext, this);
  }

  @override
  Widget? customGroup(S2Group<T> group) {
    return builder!.group?.call(modalContext, this, group);
  }

  @override
  Widget? customGroupHeader(S2Group<T> group) {
    return builder!.groupHeader?.call(modalContext, this, group);
  }

  @override
  Widget? choiceBuilder(S2Choice<T> choice) {
    return builder!.choice?.call(modalContext, this, choice) ??
        choiceResolver.choiceBuilder?.call(modalContext, choice);
  }

  @override
  Widget? choiceTitle(S2Choice<T> choice) {
    return choice.title != null
        ? builder?.choiceTitle?.call(modalContext, this, choice) ??
            defaultChoiceTitle(choice)
        : null;
  }

  @override
  Widget? choiceSubtitle(S2Choice<T> choice) {
    return choice.subtitle != null
        ? builder?.choiceSubtitle?.call(modalContext, this, choice) ??
            defaultChoiceSubtitle(choice)
        : null;
  }

  @override
  Widget? choiceSecondary(S2Choice<T> choice) {
    return builder?.choiceSecondary?.call(modalContext, this, choice);
  }

  @override
  Widget get choiceSelectorAll {
    return Checkbox(
      activeColor: choiceActiveStyle?.color ?? defaultActiveChoiceStyle.color,
      value: selection!.length == choices!.length
          ? true
          : selection!.length == 0
              ? false
              : null,
      tristate: true,
      onChanged: (value) {
        if (value == true) {
          selection!.merge(choices!.items!);
        } else {
          selection!.clear();
        }
      },
    );
  }

  @override
  Widget choiceSelector(List<S2Choice<T>>? values) {
    return Checkbox(
      activeColor: choiceActiveStyle?.color ?? defaultActiveChoiceStyle.color,
      value: selection!.hasAll(values!)
          ? true
          : selection!.hasAny(values)
              ? null
              : false,
      tristate: true,
      onChanged: (value) {
        if (value == true) {
          selection!.merge(values);
        } else {
          selection!.omit(values);
        }
      },
    );
  }

  @override
  S2MultiSelected<T> get selected => widget.multiSelected!;
}

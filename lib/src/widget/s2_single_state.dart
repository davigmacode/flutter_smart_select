import 'package:awesome_select/awesome_select.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';

/// State for Single Choice
class S2SingleState<T> extends S2State<T> {
  /// State of the selected choice(s)

  /// State of choice(s) selection in the modal
  @override
  S2SingleSelection<T>? selection;

  @override
  void onChange() {
    selected.choice = selection?.choice;
    widget.singleOnChange?.call(selected);
  }

  @override
  void onSelect(S2Choice<T> choice) {
    widget.singleOnSelect?.call(this, choice);
  }

  @override
  void onModalOpen() {
    widget.singleOnModalOpen?.call(this);
  }

  @override
  void onModalClose(bool confirmed) {
    widget.singleOnModalClose?.call(this, confirmed);
    super.onModalClose(confirmed);
  }

  @override
  Future<bool>? onModalWillOpen() {
    return widget.singleOnModalWillOpen?.call(this);
  }

  @override
  Future<bool> onModalWillClose() {
    return widget.singleOnModalWillClose?.call(this) ?? defaultModalWillClose();
  }

  @override
  S2SingleBuilder<T>? get builder {
    return widget.singleBuilder;
  }

  @override
  S2Validation<S2SingleChosen<T>>? get validation {
    return widget.singleValidation;
  }

  @override
  S2Validation<S2SingleChosen<T>>? get modalValidation {
    return widget.singleModalValidation ?? validation;
  }

  @override
  void resolveSelected() async {
    selected
      ..addListener(super.selectedHandler)
      ..resolve(defaultResolver: (value) async {
        return widget.choiceItems?.firstWhereOrNull(
          (item) => item.value == value,
        );
      });
  }

  @override
  void resolveSelection() async {
    // set the initial selection
    selection = S2SingleSelection<T>(
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
    if (oldWidget.singleSelected != widget.singleSelected) resolveSelected();
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
  Widget? get customModalFilter {
    return builder?.modalFilter?.call(modalContext, this);
  }

  @override
  Widget? get customModalFilterToggle {
    return builder?.modalFilterToggle?.call(modalContext, this);
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
  Widget? get choiceSelectorAll => null;

  @override
  Widget? choiceSelector(List<S2Choice<T>>? values) => null;

  @override
  S2SingleSelected<T> get selected => widget.singleSelected!;
}

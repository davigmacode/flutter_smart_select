import 'package:awesome_select/awesome_select.dart';
import 'package:collection/collection.dart' show ListEquality;
import 'package:flutter/material.dart';

import '../choices_empty.dart';
import '../choices_list.dart';
import '../choices_resolver.dart';
import '../modal.dart';
import '../pagination.dart';
import '../state/choices.dart';
import '../state/filter.dart';
import '../text_error.dart';
import '../utils/debouncer.dart';

/// Smart Select State
abstract class S2State<T> extends State<SmartSelect<T>> {
  /// State of the selected choice(s)
  S2Selected<T> get selected;

  /// State of choice(s) selection in the modal
  covariant S2Selection<T>? selection;

  /// State of the choice items
  S2Choices<T>? choices;

  /// State of the filter operation
  S2Filter? filter;

  /// Context of the modal
  late BuildContext modalContext;

  /// State setter of the modal
  StateSetter? modalSetState;

  /// Returns the validation function to validate the [selected] choice
  get validation;

  /// Returns the validation function to validate the [selection] made in the modal, if `null` fallback to [validation]
  get modalValidation;

  /// Debouncer used in search text on changed
  final Debouncer debouncer = Debouncer();

  /// Called when the modal closed and [selection] has confirmed
  void onChange();

  /// Called when selection has made
  void onSelect(S2Choice<T> choice);

  /// Called when modal opened
  void onModalOpen();

  /// Called when modal closed
  void onModalClose(bool confirmed) {
    // dispose everything
    selection?.removeListener(selectionHandler);
    filter?.removeListener(_filterHandler);
    selection?.dispose();
    filter?.dispose();
  }

  /// Called when modal opened
  Future<bool>? onModalWillOpen();

  /// Called when modal closed
  Future<bool> onModalWillClose();

  Future<bool> defaultModalWillClose() async {
    modalErrorShake();
    return selection!.isValid;
  }

  /// Returns the builders collection
  get builder;

  /// The [choices] listener handler
  void _choicesHandler() => modalSetState?.call(() {});

  /// The [filter] listener handler
  void _filterHandler() {
    modalSetState?.call(() {
      choices!.reload(query: filter!.value);
    });
  }

  /// The [selection] listener handler
  void selectionHandler() => modalSetState?.call(() {});

  /// The [selected] listener handler
  void selectedHandler() => setState.call(() {});

  /// Returns `true` if the widget is multiple choice
  bool get isMultiChoice => widget.isMultiChoice == true;

  /// Returns `true` if the widget is single choice
  bool get isSingleChoice => !isMultiChoice;

  /// Returns [ThemeData] from the widget context
  ThemeData get theme => Theme.of(context);

  /// Returns the default style for unselected choice
  S2ChoiceStyle get defaultChoiceStyle {
    return S2ChoiceStyle(
      titleStyle: const TextStyle(),
      subtitleStyle: const TextStyle(),
      control: S2ChoiceControl.platform,
      highlightColor: theme.highlightColor.withOpacity(.7),
    );
  }

  /// Returns the default style for selected choice
  S2ChoiceStyle get defaultActiveChoiceStyle => defaultChoiceStyle;

  /// Returns the choice config
  S2ChoiceConfig get choiceConfig => widget.choiceConfig;

  /// Returns the choice style
  S2ChoiceStyle? get choiceStyle => choiceConfig.style;

  /// Returns the active choice style
  S2ChoiceStyle? get choiceActiveStyle => choiceConfig.activeStyle;

  /// Returns the group config
  S2GroupConfig get groupConfig {
    return widget.groupConfig.copyWith(
      headerStyle: S2GroupHeaderStyle(
        backgroundColor: theme.cardColor,
        padding: widget.groupConfig.useSelector == true
            ? const EdgeInsets.fromLTRB(16, 0, 12, 0)
            : const EdgeInsets.symmetric(horizontal: 16.0),
      ).merge(widget.groupConfig.headerStyle),
    );
  }

  /// Returns the modal config
  S2ModalConfig get modalConfig {
    return widget.modalConfig.copyWith(
      headerStyle: S2ModalHeaderStyle(
        backgroundColor:
            widget.modalConfig.isFullPage != true ? theme.cardColor : null,
        textStyle: widget.modalConfig.isFullPage != true
            ? theme.textTheme.headline6
            : theme.primaryTextTheme.headline6,
        iconTheme:
            widget.modalConfig.isFullPage != true ? theme.iconTheme : null,
        errorStyle: const TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w500,
        ),
      ).merge(widget.modalConfig.headerStyle),
    );
  }

  /// Returns the modal style
  S2ModalStyle get modalStyle => modalConfig.style;

  /// Returns the modal header style
  S2ModalHeaderStyle get modalHeaderStyle => modalConfig.headerStyle;

  /// Returns the text used as title in trigger tile
  String? get title => widget.title ?? modalConfig.title;

  /// Returns [title] in `Text` widget
  Widget get titleWidget => Text(title!);

  /// Returns the modal widget
  Widget get modal {
    return S2Modal(
      key: ValueKey(modalConfig.type),
      onReady: onModalOpen,
      builder: (context, setState) {
        modalContext = context;
        modalSetState = setState;
        return GestureDetector(
          onVerticalDragEnd: filter?.activated == true ? (info) {} : null,
          child: customModal ?? defaultModal,
        );
      },
    );
  }

  /// Returns the default modal widget
  Widget get defaultModal {
    return WillPopScope(
      onWillPop: onModalWillClose,
      child: modalConfig.isFullPage == true
          ? Scaffold(
              backgroundColor: modalConfig.style.backgroundColor,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: modalHeader!,
              ),
              body: SafeArea(
                maintainBottomViewPadding: true,
                child: modalBody,
              ),
            )
          : modalBody,
    );
  }

  /// Returns the custom modal widget
  Widget? get customModal;

  /// Returns the modal body widget
  Widget get modalBody {
    final modalHeaderFn = modalHeader;
    final modalDividerWidget = modalDivider;
    final modalFooterWidget = modalFooter;

    final widgets = <Widget>[];
    if (!modalConfig.isFullPage && modalHeaderFn != null) {
      widgets.add(modalHeaderFn);
    }
    if (modalDividerWidget != null) {
      widgets.add(modalDividerWidget);
    }
    widgets.add(
      Flexible(
        fit: modalConfig.isFullPage == true ? FlexFit.tight : FlexFit.loose,
        child: choiceList,
      ),
    );
    if (modalDividerWidget != null) {
      widgets.add(modalDividerWidget);
    }
    if (modalFooterWidget != null) {
      widgets.add(modalFooterWidget);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: widgets,
    );
  }

  /// Returns the modal divider widget
  Widget? get modalDivider;

  /// Returns the modal footer widget
  Widget? get modalFooter;

  /// Returns the modal title widget
  Widget get modalTitle {
    String title = modalConfig.title ?? widget.title ?? widget.placeholder!;
    return Container(child: Text(title, style: modalHeaderStyle.textStyle));
  }

  void modalErrorShake() {
    if (selection!.isNotValid) {
      modalErrorController.shake();
    }
  }

  S2TextErrorController modalErrorController = S2TextErrorController();

  /// Returns the modal error widget
  Widget get modalError {
    modalErrorController.visibility(selection!.isNotValid);
    return S2TextError(
      controller: modalErrorController,
      child: Text(
        selection!.error,
        style: modalHeaderStyle.errorStyle,
      ),
    );
  }

  /// Returns the modal filter widget
  Widget get modalFilter {
    return customModalFilter ?? defaultModalFilter;
  }

  /// Returns the custom modal filter widget
  Widget? get customModalFilter;

  /// Returns the default modal filter widget
  Widget get defaultModalFilter {
    return TextField(
      autofocus: true,
      controller: filter!.ctrl,
      style: modalHeaderStyle.textStyle,
      cursorColor: modalConfig.isFullPage
          ? Colors.white
          : theme.textSelectionTheme.cursorColor,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration.collapsed(
        hintText: modalConfig.filterHint ?? 'Search on $title',
        hintStyle: modalHeaderStyle.textStyle,
      ),
      textAlign: modalConfig.headerStyle.centerTitle == true
          ? TextAlign.center
          : TextAlign.start,
      onSubmitted: modalConfig.filterAuto ? null : filter!.apply,
      onChanged: modalConfig.filterAuto
          ? (query) {
              debouncer.run(
                () => filter!.apply(query),
                delay: modalConfig.filterDelay,
              );
            }
          : null,
    );
  }

  /// Returns the widget to show/hide modal filter
  Widget? get modalFilterToggle {
    return modalConfig.useFilter
        ? customModalFilterToggle ?? defaultModalFilterToggle
        : null;
  }

  /// Returns the custom widget to show/hide modal filter
  Widget? get customModalFilterToggle;

  /// Returns the default widget to show/hide modal filter
  Widget get defaultModalFilterToggle {
    return !filter!.activated
        ? IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => filter!.show(modalContext),
          )
        : IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => filter!.hide(modalContext),
          );
  }

  /// Returns the confirm button widget
  Widget get confirmButton {
    return customConfirmButton ?? defaultConfirmButton;
  }

  /// Returns the custom confirm button widget
  Widget? get customConfirmButton;

  /// Returns the default confirm button widget
  Widget get defaultConfirmButton {
    final VoidCallback? onPressed =
        selection!.isValid ? () => closeModal(confirmed: true) : null;

    if (modalConfig.confirmLabel != null) {
      if (modalConfig.confirmIcon != null) {
        return Center(
          child: Padding(
            padding: modalConfig.confirmMargin ??
                const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: TextButton.icon(
              icon: modalConfig.confirmIcon!,
              label: modalConfig.confirmLabel!,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color?>(
                  modalConfig.confirmIsDark ? modalConfig.confirmColor : null,
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(
                      color: modalConfig.confirmIsLight
                          ? modalConfig.confirmColor
                          : Colors.white),
                ),
              ),
              onPressed: onPressed,
            ),
          ),
        );
      } else {
        return Center(
          child: Padding(
            padding: modalConfig.confirmMargin ??
                const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color?>(
                    modalConfig.confirmIsDark
                        ? modalConfig.confirmColor ?? Colors.blueGrey
                        : null),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(
                      color: modalConfig.confirmIsLight
                          ? modalConfig.confirmColor
                          : Colors.white),
                ),
              ),
              onPressed: onPressed,
              child: modalConfig.confirmLabel!,
            ),
          ),
        );
      }
    } else {
      return Padding(
        padding: modalConfig.confirmMargin ?? const EdgeInsets.all(0),
        child: IconButton(
          icon:
              modalConfig.confirmIcon ?? const Icon(Icons.check_circle_outline),
          color: modalConfig.confirmColor,
          onPressed: onPressed,
        ),
      );
    }
  }

  /// Returns the modal header widget
  Widget? get modalHeader {
    return modalConfig.useHeader == true
        ? customModalHeader ?? defaultModalHeader
        : null;
  }

  /// Returns the custom modal header
  Widget? get customModalHeader;

  /// Returns the default modal header widget
  Widget get defaultModalHeader {
    final bool isFiltering = filter?.activated == true;
    return AppBar(
      primary: true,
      shape: modalHeaderStyle.shape,
      elevation: modalHeaderStyle.elevation,
      backgroundColor: modalHeaderStyle.backgroundColor,
      actionsIconTheme: modalHeaderStyle.actionsIconTheme,
      iconTheme: modalHeaderStyle.iconTheme,
      centerTitle: modalHeaderStyle.centerTitle,
      automaticallyImplyLeading: modalConfig.isFullPage || isFiltering,
      leading: isFiltering ? const Icon(Icons.search) : null,
      title: isFiltering
          ? modalFilter
          : Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                modalTitle,
                modalError,
              ],
            ),
      actions: modalActions,
    );
  }

  /// Returns the modal action widgets
  List<Widget> get modalActions {
    return (customModalActions ?? defaultModalActions);
  }

  /// Returns the custom modal actions widgets
  List<Widget>? get customModalActions;

  /// Returns the default modal actions widgets
  List<Widget> get defaultModalActions {
    final actions = <Widget>[];
    if (modalFilterToggle != null) {
      actions.add(modalFilterToggle!);
    }
    if (modalConfig.useConfirm && !filter!.activated) {
      actions.add(confirmButton);
    }
    return actions;
  }

  /// Returns the choices selector widget
  Widget? get choiceSelectorAll;

  /// Function to create toggle selector checkbox widget
  Widget? choiceSelector(List<S2Choice<T>>? values);

  /// Returns the choice item builder from resolver by it's type
  Widget? choiceBuilder(S2Choice<T> choice);

  /// Returns the choice title widget
  Widget? choiceTitle(S2Choice<T> choice);

  /// Returns the choice subtitle widget
  Widget? choiceSubtitle(S2Choice<T> choice);

  /// Returns the secondary/avatar widget
  Widget? choiceSecondary(S2Choice<T> choice);

  /// Returns the default choice title widget
  Widget defaultChoiceTitle(S2Choice<T> choice) {
    return S2Text(
      text: choice.title,
      style: choice.effectiveStyle!.titleStyle,
      highlight: filter?.value,
      highlightColor: choice.effectiveStyle!.highlightColor,
    );
  }

  /// Returns the default choice subtitle widget
  Widget defaultChoiceSubtitle(S2Choice<T> choice) {
    return S2Text(
      text: choice.subtitle,
      style: choice.effectiveStyle!.subtitleStyle,
      highlight: filter?.value,
      highlightColor: choice.effectiveStyle!.highlightColor,
    );
  }

  /// Returns the default choice builder by its type
  S2ChoiceResolver<T> get choiceResolver {
    return S2ChoiceResolver(
      isMultiChoice: isMultiChoice,
      type: choiceConfig.type,
      titleBuilder: choiceTitle,
      secondaryBuilder: choiceSecondary,
      subtitleBuilder: choiceSubtitle,
    );
  }

  /// Returns the choice item builder by it's current state
  S2ChoiceListBuilder<T> get choiceListBuilder {
    return (S2Choice<T> choice) {
      return choiceBuilder(
        choice.copyWith(
          selected: selection!.has(choice),
          select: ([selected = true]) {
            // set temporary value
            selection!.select(choice, selected: selected!);
            // call on choice select callback
            if (modalConfig.useConfirm == true) onSelect(choice);
            // only for single choice
            if (isSingleChoice) {
              // hide filter bar
              if (filter?.activated == true) filter?.hide(modalContext);
              // confirm the value and close modal
              if (!modalConfig.useConfirm) closeModal(confirmed: true);
            }
          },
          style: defaultChoiceStyle.merge(choiceStyle).merge(choice.style),
          activeStyle: defaultActiveChoiceStyle
              .merge(choiceStyle)
              .merge(choice.style)
              .merge(choiceActiveStyle)
              .merge(choice.activeStyle),
        ),
      );
    };
  }

  /// Returns the choice items widget
  Widget get choiceList {
    return choices!.isInitializing && choices!.isAsync
        ? choiceProgress
        : choices!.isNotEmpty
            ? ListTileTheme(
                contentPadding: choiceConfig.style?.padding,
                child: Builder(
                  builder: (_) {
                    // return grouped choices if the configuration meet the requirement
                    if (groupConfig.enabled) {
                      final List<S2Group<T>>? groups =
                          choices!.groupItems(groupConfig);
                      if (groups != null) {
                        // appendable and reloadable choices are incompatible with grouped choices
                        return groupedChoices(groups);
                      }
                    }

                    return S2Pagination(
                      reloadable: choices!.isAsync,
                      appendable: choiceConfig.pageLimit != null,
                      onReload: () => choices!.reload(query: filter?.value),
                      onAppend: () => choices!.append(query: filter?.value),
                      child: ungroupedChoices(choices!.items),
                    );
                  },
                ),
              )
            : choiceEmpty;
  }

  /// Returns the ungrouped choice items widget
  Widget ungroupedChoices(List<S2Choice<T>>? choiceList) {
    return S2ChoicesList<T>(
      itemLength:
          choices!.isAppending ? choiceList!.length + 1 : choiceList!.length,
      itemBuilder: (context, i) {
        return choices!.isAppending && i == choiceList.length
            ? const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(),
                ),
              )
            : choiceListBuilder(choiceList[i])!;
      },
      dividerBuilder: builder.choiceDivider,
      config: choiceConfig,
    );
  }

  /// Returns the grouped choice items widget
  Widget groupedChoices(List<S2Group<T>> groups) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (_, int i) {
          return customGroup(groups[i]) ?? defaultGroup(groups[i]);
        },
      ),
    );
  }

  /// Returns the default grouped choices widget
  Widget defaultGroup(S2Group<T> group) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        groupHeader(group),
        groupChoices(group),
      ],
    );
  }

  /// Returns the custom grouped choices widget
  Widget? customGroup(S2Group<T> group) {
    return builder.group?.call(modalContext, this, group);
  }

  /// Returns the group choices widget
  Widget groupChoices(S2Group<T> group) {
    return S2ChoicesList<T>(
      itemLength: group.choices!.length,
      itemBuilder: (context, i) => choiceListBuilder(group.choices![i])!,
      dividerBuilder: builder.choiceDivider,
      config: choiceConfig,
    );
  }

  /// Returns the group header widget
  Widget groupHeader(S2Group<T> group) {
    return customGroupHeader(group) ?? defaultGroupHeader(group);
  }

  /// Returns the custom group header widget
  Widget? customGroupHeader(S2Group<T> group);

  /// Returns the default group header widget
  Widget defaultGroupHeader(S2Group<T> group) {
    return S2GroupHeader(
      style: group.headerStyle,
      title: S2Text(
        text: group.name,
        highlight: filter?.value,
        style: group.headerStyle!.textStyle,
        highlightColor:
            group.headerStyle!.highlightColor ?? const Color(0xFFFFF176),
      ),
      trailing: groupConfig.useSelector == true
          ? choiceSelector(group.choices) ?? groupCounter(group)
          : groupConfig.useCounter == true
              ? groupCounter(group)
              : null,
    );
  }

  /// Returns the group counter widget
  Widget groupCounter(S2Group<T> group) {
    return Text(
      group.count.toString(),
      style: group.headerStyle!.textStyle,
    );
  }

  /// Returns the indicator widget indicates the [choices] is processing
  Widget get choiceProgress {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: modalConfig.isPopupDialog ? 100 : double.infinity,
      ),
      child: const Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  /// Returns the choice empty widget
  Widget get choiceEmpty {
    return customChoiceEmpty ?? defaultChoiceEmpty;
  }

  /// Returns the custom empty choice widget
  Widget? get customChoiceEmpty;

  /// Returns the default choice empty widget
  Widget get defaultChoiceEmpty {
    return const S2ChoicesEmpty();
  }

  /// Show the modal by type
  Future<bool?> _showModalByType() async {
    bool? confirmed = false;
    switch (modalConfig.type) {
      case S2ModalType.fullPage:
        confirmed = await (Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => modal),
        ));
        break;
      case S2ModalType.bottomSheet:
        confirmed = await (showModalBottomSheet(
          context: context,
          shape: modalStyle.shape,
          clipBehavior: modalStyle.clipBehavior ?? Clip.none,
          backgroundColor: modalStyle.backgroundColor,
          elevation: modalStyle.elevation,
          isDismissible: modalConfig.barrierDismissible,
          barrierColor: modalConfig.barrierColor,
          enableDrag: modalConfig.enableDrag,
          isScrollControlled: true,
          builder: (_) {
            final MediaQueryData mediaQuery =
                MediaQueryData.fromWindow(WidgetsBinding.instance.window);
            final double topObstructions = mediaQuery.viewPadding.top;
            final double bottomObstructions = mediaQuery.viewPadding.bottom;
            final double keyboardHeight = mediaQuery.viewInsets.bottom;
            final double deviceHeight = mediaQuery.size.height;
            final bool isKeyboardOpen = keyboardHeight > 0;
            final double maxHeightFactor =
                isKeyboardOpen ? 1 : modalConfig.maxHeightFactor;
            final double modalHeight =
                (deviceHeight * maxHeightFactor) + keyboardHeight;
            final bool isFullHeight = modalHeight >= deviceHeight;
            return Container(
              padding: EdgeInsets.only(
                top: isFullHeight ? topObstructions : 0,
                bottom: keyboardHeight + bottomObstructions,
              ),
              constraints: BoxConstraints(
                maxHeight: isFullHeight ? double.infinity : modalHeight,
              ),
              child: modal,
            );
          },
        ));
        break;
      case S2ModalType.popupDialog:
        confirmed = await (showDialog(
          context: context,
          useSafeArea: true,
          barrierDismissible: modalConfig.barrierDismissible,
          barrierColor: modalConfig.barrierColor,
          builder: (_) => Dialog(
            shape: modalStyle.shape,
            clipBehavior: modalStyle.clipBehavior ?? Clip.antiAlias,
            backgroundColor: modalStyle.backgroundColor,
            elevation: modalStyle.elevation,
            child: modal,
          ),
        ));
        break;
    }
    return confirmed;
  }

  /// Returns the default trigger tile widget
  Widget get defaultTile {
    return S2Tile<T>.fromState(this);
  }

  /// Function to close the choice modal
  void closeModal({bool confirmed = true}) {
    // pop the navigation
    if (confirmed == true) {
      // will call the onWillPop
      Navigator.maybePop(context, true);
    } else {
      // no need to call the onWillPop
      Navigator.pop(context, false);
    }
  }

  /// Function to show the choice modal
  void showModal() async {
    // call on modal will open callback
    // and prevent open modal if return value is not `true`
    final bool willOpen = await onModalWillOpen() ?? true;
    if (willOpen != true) return;

    // initialize the selection choice(s)
    resolveSelection();

    // initialize filter
    initializeFilter();

    // initial load the choice items
    choices!.initialize();

    // show modal by type and return confirmed value
    final bool confirmed = await _showModalByType() ?? false;

    // call on modal close callback
    onModalClose(confirmed);

    // dont return value if modal need confirmation and not confirmed
    if (modalConfig.useConfirm == true && confirmed != true) return;

    // return value
    if (selection!.choice != null) {
      // return state to onChange callback
      onChange();
    }
  }

  /// Initiate the [selected] choice
  void resolveSelected();

  /// Function to resolve the selected
  void resolveSelection();

  /// Function to resolve the choices
  void resolveChoices() {
    // initialize choices
    choices?.dispose();
    choices = S2Choices<T>(
      items: widget.choiceItems,
      loader: widget.choiceLoader,
      limit: choiceConfig.pageLimit,
      delay: choiceConfig.delay,
    )..addListener(_choicesHandler);
  }

  /// Function to initialize filter
  void initializeFilter() {
    filter = S2Filter()..addListener(_filterHandler);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    // initialize the selected choice(s)
    resolveSelected();

    // initialize choices
    resolveChoices();
  }

  @override
  void didUpdateWidget(SmartSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!const ListEquality()
        .equals(oldWidget.choiceItems, widget.choiceItems)) {
      resolveChoices();
    }
  }

  @override
  void dispose() {
    // dispose everything
    choices?.removeListener(_choicesHandler);
    selected.removeListener(selectedHandler);
    choices?.dispose();
    selected.dispose();
    super.dispose();
  }
}

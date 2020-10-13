import 'package:flutter/material.dart';
import './model/builder.dart';
import './model/modal_theme.dart';
import './model/modal_config.dart';
import './model/choice_theme.dart';
import './model/choice_config.dart';
import './model/choice_item.dart';
import './state/filter.dart';
import './state/changes.dart';
import './choices.dart';
import './choices_resolver.dart';
import './tile/tile.dart';
import './utils/debouncer.dart';
import './choices_empty.dart';

/// SmartSelect allows you to easily convert your usual form select or dropdown
/// into dynamic page, popup dialog, or sliding bottom sheet with various choices input
/// such as radio, checkbox, switch, chips, or even custom input.
class SmartSelect<T> extends StatefulWidget {

  /// The primary content of the widget.
  /// Used in trigger widget and header option
  final String title;

  /// The text displayed when the value is null
  final String placeholder;

  /// List of choice item
  final List<S2Choice<T>> choiceItems;

  /// Choice configuration
  final S2ChoiceConfig choiceConfig;

  /// Modal configuration
  final S2ModalConfig modalConfig;

  /// Whether show the options list
  /// as single choice or multiple choice
  final bool isMultiChoice;

  /// The current value of the single choice widget.
  final T singleValue;

  /// The current value of the multi choice widget.
  final List<T> multiValue;

  /// Called when single choice value changed
  final ValueChanged<S2SingleState<T>> singleOnChange;

  /// Called when multiple choice value changed
  final ValueChanged<S2MultiState<T>> multiOnChange;

  /// Builder collection of single choice widget
  final S2SingleBuilder<T> singleBuilder;

  /// Builder collection of multiple choice widget
  final S2MultiBuilder<T> multiBuilder;

  /// Modal validation of single choice widget
  final ValidationCallback<T> singleModalValidation;

  /// Modal validation of multiple choice widget
  final ValidationCallback<List<T>> multiModalValidation;

  /// Default constructor
  SmartSelect({
    Key key,
    this.title,
    this.placeholder,
    this.isMultiChoice,
    this.singleValue,
    this.singleOnChange,
    this.singleModalValidation,
    this.singleBuilder,
    this.multiValue,
    this.multiOnChange,
    this.multiModalValidation,
    this.multiBuilder,
    this.modalConfig = const S2ModalConfig(),
    this.choiceConfig = const S2ChoiceConfig(),
    this.choiceItems,
  }) :
    assert(isMultiChoice != null),
    assert(title != null || modalConfig?.title != null, 'title and modalConfig.title must not be both null'),
    assert(
      (isMultiChoice && multiOnChange != null && multiBuilder != null) || (!isMultiChoice && singleOnChange != null && singleBuilder != null)
      , isMultiChoice ? 'multiValue, multiOnChange, and multiBuilder must be not null in multiple choice' : 'singleValue, singleOnChange, and singleBuilder must be not null in single choice'
    ),
    assert(
      (isMultiChoice && choiceConfig.type != S2ChoiceType.radios) || (!isMultiChoice && choiceConfig.type != S2ChoiceType.checkboxes),
      isMultiChoice ? 'multiple choice can\'t use S2ChoiceType.radios' : 'Single choice can\'t use S2ChoiceType.checkboxes'
    ),
    assert(choiceItems != null, '`choiceItems` must not be null'),
    super(key: key);

  /// Constructor for single choice
  factory SmartSelect.single({
    /// Widget key
    Key key,

    /// The primary content of the widget.
    /// Used in trigger widget and header option
    String title,

    /// The text displayed when the value is null
    String placeholder = 'Select one',

    /// The current value of the single choice widget.
    @required T value,

    /// Called when single choice value changed
    @required ValueChanged<S2SingleState<T>> onChange,

    /// Modal validation of single choice widget
    ValidationCallback<T> modalValidation,

    /// List of choice item
    List<S2Choice<T>> choiceItems,

    /// Builder collection of single choice widget
    S2SingleBuilder<T> builder,

    /// Builder for custom tile widget
    /// shortcut to [builder.tileBuilder]
    S2WidgetBuilder<S2SingleState<T>> tileBuilder,

    /// Builder for custom modal widget
    /// shortcut to [builder.modalBuilder]
    S2WidgetBuilder<S2SingleState<T>> modalBuilder,

    /// Builder for custom modal header widget
    /// shortcut to [builder.modalHeaderBuilder]
    S2WidgetBuilder<S2SingleState<T>> modalHeaderBuilder,

    /// Builder for custom modal actions widget
    /// shortcut to [builder.modalActionsBuilder]
    S2ListWidgetBuilder<S2SingleState<T>> modalActionsBuilder,

    /// Builder for custom modal confirm action widget
    /// shortcut to [builder.modalConfirmBuilder]
    S2WidgetBuilder<S2SingleState<T>> modalConfirmBuilder,

    /// Builder for divider widget between header, body, and footer modal
    /// shortcut to [builder.modalDividerBuilder]
    S2WidgetBuilder<S2SingleState<T>> modalDividerBuilder,

    /// Builder for custom footer widget
    /// shortcut to [builder.modalFooterBuilder]
    S2WidgetBuilder<S2SingleState<T>> modalFooterBuilder,

    /// Builder for modal filter widget
    /// shortcut to [builder.modalFilterBuilder]
    S2WidgetBuilder<S2Filter> modalFilterBuilder,

    /// Builder for modal filter toggle widget
    /// shortcut to [builder.modalFilterToggleBuilder]
    S2WidgetBuilder<S2Filter> modalFilterToggleBuilder,

    /// Builder for each custom choices item widget
    /// shortcut to [builder.choiceBuilder]
    S2ChoiceBuilder<T> choiceBuilder,

    /// Builder for each custom choices item title widget
    /// shortcut to [builder.choiceTitleBuilder]
    S2ChoiceBuilder<T> choiceTitleBuilder,

    /// Builder for each custom choices item subtitle widget
    /// shortcut to [builder.choiceSubtitleBuilder]
    S2ChoiceBuilder<T> choiceSubtitleBuilder,

    /// Builder for each custom choices item secondary widget
    /// shortcut to [builder.choiceSecondaryBuilder]
    S2ChoiceBuilder<T> choiceSecondaryBuilder,

    /// Builder for custom divider widget between choices item
    /// shortcut to [builder.choiceDividerBuilder]
    IndexedWidgetBuilder choiceDividerBuilder,

    /// Builder for custom empty display
    /// shortcut to [builder.choiceEmptyBuilder]
    S2WidgetBuilder<String> choiceEmptyBuilder,

    /// A widget builder for custom choices group
    /// shortcut to [builder.choiceGroupBuilder]
    S2ChoiceGroupBuilder choiceGroupBuilder,

    /// A widget builder for custom header choices group
    /// shortcut to [builder.choiceHeaderBuilder]
    S2ChoiceHeaderBuilder choiceHeaderBuilder,

    /// choice configuration
    S2ChoiceConfig choiceConfig,

    /// configure choice style
    /// shortcut to [choiceConfig.style]
    S2ChoiceStyle choiceStyle,

    /// configure choices group header style
    /// shortcut to [choiceConfig.headerStyle]
    S2ChoiceHeaderStyle choiceHeaderStyle,

    /// choice widget type
    /// shortcut to [choiceConfig.type]
    S2ChoiceType choiceType,

    /// choice layout to display items
    /// shortcut to [choiceConfig.layout]
    S2ChoiceLayout choiceLayout,

    /// choice list scroll direction
    /// currently only support when
    /// [layout] is [S2ChoiceLayout.wrap]
    /// shortcut to [choiceConfig.direction]
    Axis choiceDirection,

    /// Whether the choices list is grouped
    /// shortcut to [choiceConfig.isGrouped]
    bool choiceGrouped,

    /// Whether the choices item use divider or not
    /// shortcut to [choiceConfig.useDivider]
    bool choiceDivider,

    /// For grid choice layout
    /// shortcut to [choiceConfig.gridDelegate]
    SliverGridDelegate choiceGrid,

    /// Modal configuration
    S2ModalConfig modalConfig,

    /// Configure modal style
    /// shortcut to [modalConfig.style]
    S2ModalStyle modalStyle,

    /// Configure modal header style
    /// shortcut to [modalConfig.headerStyle]
    S2ModalHeaderStyle modalHeaderStyle,

    /// Modal type to display choices
    /// shortcut to [modalConfig.type]
    S2ModalType modalType,

    /// Use different title with the trigger widget title
    /// shortcut to [modalConfig.title]
    String modalTitle,

    /// Whether the option list need to confirm
    /// to return the changed value
    /// shortcut to [modalConfig.useConfirm]
    bool modalConfirm,

    /// Whether the options list modal use header or not
    /// shortcut to [modalConfig.useHeader]
    bool modalHeader,

    /// Whether the option list is filterable or not
    /// shortcut to [modalConfig.useFilter]
    bool modalFilter,

    /// Whether the filter is autocomplete or need confirmation
    /// shortcut to [modalConfig.filterAuto]
    bool modalFilterAuto,

    /// Custom searchbar hint
    /// shortcut to [modalConfig.filterHint]
    String modalFilterHint,
  }) {
    S2ModalConfig defaultModalConfig = const S2ModalConfig();
    S2ChoiceConfig defaultChoiceConfig = const S2ChoiceConfig(type: S2ChoiceType.radios);
    return SmartSelect<T>(
      key: key,
      title: title,
      placeholder: placeholder,
      choiceItems: choiceItems,
      isMultiChoice: false,
      multiValue: null,
      multiOnChange: null,
      multiBuilder: null,
      singleValue: value,
      singleOnChange: onChange,
      singleModalValidation: modalValidation,
      singleBuilder: S2SingleBuilder<T>().merge(builder).copyWith(
        tile: tileBuilder,
        modal: modalBuilder,
        modalHeader: modalHeaderBuilder,
        modalActions: modalActionsBuilder,
        modalConfirm: modalConfirmBuilder,
        modalDivider: modalDividerBuilder,
        modalFooter: modalFooterBuilder,
        modalFilter: modalFilterBuilder,
        modalFilterToggle: modalFilterToggleBuilder,
        choice: choiceBuilder,
        choiceTitle: choiceTitleBuilder,
        choiceSubtitle: choiceSubtitleBuilder,
        choiceSecondary: choiceSecondaryBuilder,
        choiceDivider: choiceDividerBuilder,
        choiceEmpty: choiceEmptyBuilder,
        choiceGroup: choiceGroupBuilder,
        choiceHeader: choiceHeaderBuilder,
      ),
      choiceConfig: defaultChoiceConfig.merge(choiceConfig).copyWith(
        type: choiceType,
        layout: choiceLayout,
        direction: choiceDirection,
        gridDelegate: choiceGrid,
        isGrouped: choiceGrouped,
        useDivider: choiceDivider,
        style: choiceStyle,
        headerStyle: choiceHeaderStyle,
      ),
      modalConfig: defaultModalConfig.merge(modalConfig).copyWith(
        type: modalType,
        title: modalTitle,
        filterHint: modalFilterHint,
        filterAuto: modalFilterAuto,
        useFilter: modalFilter,
        useHeader: modalHeader,
        useConfirm: modalConfirm,
        style: modalStyle,
        headerStyle: modalHeaderStyle,
      ),
    );
  }

  /// Constructor for multiple choice
  factory SmartSelect.multiple({
    /// Widget key
    Key key,

    /// The primary content of the widget.
    /// Used in trigger widget and header option
    String title,

    /// The text displayed when the value is null
    String placeholder = 'Select one or more',

    /// The current value of the multi choice widget.
    @required List<T> value,

    /// Called when multiple choice value changed
    @required ValueChanged<S2MultiState<T>> onChange,

    /// Modal validation of multiple choice widget
    ValidationCallback<List<T>> modalValidation,

    /// List of choice item
    List<S2Choice<T>> choiceItems,

    /// Builder collection of single choice widget
    S2MultiBuilder<T> builder,

    /// Builder for custom tile widget
    /// shortcut to [builder.tileBuilder]
    S2WidgetBuilder<S2MultiState<T>> tileBuilder,

    /// Builder for custom modal widget
    /// shortcut to [builder.modalBuilder]
    S2WidgetBuilder<S2MultiState<T>> modalBuilder,

    /// Builder for custom modal header widget
    /// shortcut to [builder.modalHeaderBuilder]
    S2WidgetBuilder<S2MultiState<T>> modalHeaderBuilder,

    /// Builder for custom modal actions widget
    /// shortcut to [builder.modalActionsBuilder]
    S2ListWidgetBuilder<S2MultiState<T>> modalActionsBuilder,

    /// Builder for custom modal confirm action widget
    /// shortcut to [builder.modalConfirmBuilder]
    S2WidgetBuilder<S2MultiState<T>> modalConfirmBuilder,

    /// Builder for divider widget between header, body, and footer modal
    /// shortcut to [builder.modalDividerBuilder]
    S2WidgetBuilder<S2MultiState<T>> modalDividerBuilder,

    /// Builder for custom footer widget
    /// shortcut to [builder.modalFooterBuilder]
    S2WidgetBuilder<S2MultiState<T>> modalFooterBuilder,

    /// Builder for modal filter widget
    /// shortcut to [builder.modalFilterBuilder]
    S2WidgetBuilder<S2Filter> modalFilterBuilder,

    /// Builder for modal filter toggle widget
    /// shortcut to [builder.modalFilterToggleBuilder]
    S2WidgetBuilder<S2Filter> modalFilterToggleBuilder,

    /// Builder for each custom choices item widget
    /// shortcut to [builder.choiceBuilder]
    S2ChoiceBuilder<T> choiceBuilder,

    /// Builder for each custom choices item title widget
    /// shortcut to [builder.choiceTitleBuilder]
    S2ChoiceBuilder<T> choiceTitleBuilder,

    /// Builder for each custom choices item subtitle widget
    /// shortcut to [builder.choiceSubtitleBuilder]
    S2ChoiceBuilder<T> choiceSubtitleBuilder,

    /// Builder for each custom choices item secondary widget
    /// shortcut to [builder.choiceSecondaryBuilder]
    S2ChoiceBuilder<T> choiceSecondaryBuilder,

    /// Builder for custom divider widget between choices item
    /// shortcut to [builder.choiceDividerBuilder]
    IndexedWidgetBuilder choiceDividerBuilder,

    /// Builder for custom empty display
    /// shortcut to [builder.choiceEmptyBuilder]
    S2WidgetBuilder<String> choiceEmptyBuilder,

    /// A widget builder for custom choices group
    /// shortcut to [builder.choiceGroupBuilder]
    S2ChoiceGroupBuilder choiceGroupBuilder,

    /// A widget builder for custom header choices group
    /// shortcut to [builder.choiceHeaderBuilder]
    S2ChoiceHeaderBuilder choiceHeaderBuilder,

    /// choice configuration
    S2ChoiceConfig choiceConfig,

    /// configure choice style
    /// shortcut to [choiceConfig.style]
    S2ChoiceStyle choiceStyle,

    /// configure choices group header style
    /// shortcut to [choiceConfig.headerStyle]
    S2ChoiceHeaderStyle choiceHeaderStyle,

    /// choice widget type
    /// shortcut to [choiceConfig.type]
    S2ChoiceType choiceType,

    /// choice layout to display items
    /// shortcut to [choiceConfig.layout]
    S2ChoiceLayout choiceLayout,

    /// choice list scroll direction
    /// currently only support when
    /// [layout] is [S2ChoiceLayout.wrap]
    /// shortcut to [choiceConfig.direction]
    Axis choiceDirection,

    /// Whether the choices list is grouped
    /// shortcut to [choiceConfig.isGrouped]
    bool choiceGrouped,

    /// Whether the choices item use divider or not
    /// shortcut to [choiceConfig.useDivider]
    bool choiceDivider,

    /// For grid choice layout
    /// shortcut to [choiceConfig.gridDelegate]
    SliverGridDelegate choiceGrid,

    /// Modal configuration
    S2ModalConfig modalConfig,

    /// Configure modal style
    /// shortcut to [modalConfig.style]
    S2ModalStyle modalStyle,

    /// Configure modal header style
    /// shortcut to [modalConfig.headerStyle]
    S2ModalHeaderStyle modalHeaderStyle,

    /// Modal type to display choices
    /// shortcut to [modalConfig.type]
    S2ModalType modalType,

    /// Use different title with the trigger widget title
    /// shortcut to [modalConfig.title]
    String modalTitle,

    /// Whether the option list need to confirm
    /// to return the changed value
    /// shortcut to [modalConfig.useConfirm]
    bool modalConfirm,

    /// Whether the options list modal use header or not
    /// shortcut to [modalConfig.useHeader]
    bool modalHeader,

    /// Whether the option list is filterable or not
    /// shortcut to [modalConfig.useFilter]
    bool modalFilter,

    /// Whether the filter is autocomplete or need confirmation
    /// shortcut to [modalConfig.filterAuto]
    bool modalFilterAuto,

    /// Custom searchbar hint
    /// shortcut to [modalConfig.filterHint]
    String modalFilterHint,
  }) {
    S2ModalConfig defaultModalConfig = const S2ModalConfig();
    S2ChoiceConfig defaultChoiceConfig = const S2ChoiceConfig(type: S2ChoiceType.checkboxes);
    return SmartSelect<T>(
      key: key,
      title: title,
      placeholder: placeholder,
      choiceItems: choiceItems,
      isMultiChoice: true,
      singleValue: null,
      singleOnChange: null,
      singleBuilder: null,
      multiValue: value,
      multiOnChange: onChange,
      multiModalValidation: modalValidation,
      multiBuilder: S2MultiBuilder<T>().merge(builder).copyWith(
        tile: tileBuilder,
        modal: modalBuilder,
        modalHeader: modalHeaderBuilder,
        modalActions: modalActionsBuilder,
        modalConfirm: modalConfirmBuilder,
        modalDivider: modalDividerBuilder,
        modalFooter: modalFooterBuilder,
        modalFilter: modalFilterBuilder,
        modalFilterToggle: modalFilterToggleBuilder,
        choice: choiceBuilder,
        choiceTitle: choiceTitleBuilder,
        choiceSubtitle: choiceSubtitleBuilder,
        choiceSecondary: choiceSecondaryBuilder,
        choiceDivider: choiceDividerBuilder,
        choiceEmpty: choiceEmptyBuilder,
        choiceGroup: choiceGroupBuilder,
        choiceHeader: choiceHeaderBuilder,
      ),
      choiceConfig: defaultChoiceConfig.merge(choiceConfig).copyWith(
        type: choiceType,
        layout: choiceLayout,
        direction: choiceDirection,
        gridDelegate: choiceGrid,
        isGrouped: choiceGrouped,
        useDivider: choiceDivider,
        style: choiceStyle,
        headerStyle: choiceHeaderStyle,
      ),
      modalConfig: defaultModalConfig.merge(modalConfig).copyWith(
        type: modalType,
        title: modalTitle,
        filterHint: modalFilterHint,
        filterAuto: modalFilterAuto,
        useFilter: modalFilter,
        useHeader: modalHeader,
        useConfirm: modalConfirm,
        style: modalStyle,
        headerStyle: modalHeaderStyle,
      ),
    );
  }

  @override
  S2State<T> createState() {
    return isMultiChoice
      ? S2MultiState<T>()
      : S2SingleState<T>();
  }
}

/// Smart Select State
abstract class S2State<T> extends State<SmartSelect<T>> {
  /// filter state
  S2Filter filter;

  /// value changes state
  covariant S2Changes<T> changes;

  /// modal build context
  BuildContext modalContext;

  /// get final modal validation
  get modalValidation;

  /// debouncer used in search text on changed
  final Debouncer debouncer = Debouncer();

  /// final value
  covariant var value;

  /// return an object or array of object
  /// that represent the value
  get valueObject;

  /// return a string or array of string
  /// that represent the value
  get valueTitle;

  /// return a string that can be used as display
  /// when value is null it will display placeholder
  String get valueDisplay;

  /// return a [Text] widget from [valueDisplay]
  Widget get valueWidget => Text(valueDisplay);

  /// Called when single choice value changed
  get onChange;

  /// get collection of builder
  get builder;

  // filter listener handler
  void _filterHandler() => setState(() {});

  // changes listener handler
  void _changesHandler() => setState(() {});

  /// get theme data
  ThemeData get theme => Theme.of(context);

  /// get choice config
  S2ChoiceConfig get choiceConfig => widget.choiceConfig?.copyWith(
    style: S2ChoiceStyle(
      activeColor: theme.primaryColor,
      color: theme.unselectedWidgetColor,
    ).merge(widget.choiceConfig?.style)
  );

  /// get modal config
  S2ModalConfig get modalConfig => widget.modalConfig?.copyWith(
    headerStyle: widget.modalConfig?.headerStyle?.copyWith(
      textStyle: theme.textTheme.headline6.merge(widget.modalConfig?.headerStyle?.textStyle)
    ),
  );

  // /// get modal config
  // S2ModalConfig get modalConfig {
  //   S2ModalStyle _modalStyle;
  //   if (widget.modalConfig.type == S2ModalType.popupDialog) {
  //     final DialogTheme _dialogTheme = DialogTheme.of(context);
  //     _modalStyle = S2ModalStyle(
  //       backgroundColor: _dialogTheme.backgroundColor ?? Theme.of(context).dialogBackgroundColor,
  //       elevation: _dialogTheme.elevation ?? 24.0,
  //       clipBehavior: Clip.antiAlias,
  //       shape: _dialogTheme.shape ?? const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(4.0))
  //       ),
  //     );
  //   } else if (widget.modalConfig.type == S2ModalType.popupDialog) {
  //     final BottomSheetThemeData _bottomSheetTheme = Theme.of(context).bottomSheetTheme;
  //     _modalStyle = S2ModalStyle(
  //       backgroundColor: _bottomSheetTheme.backgroundColor,
  //       elevation: _bottomSheetTheme.elevation ?? 0.1,
  //       clipBehavior: _bottomSheetTheme.clipBehavior ?? Clip.none,
  //       shape: _bottomSheetTheme.shape,
  //     );
  //   } else {
  //     _modalStyle = S2ModalStyle();
  //   }

  //   return widget.modalConfig?.copyWith(
  //     style: _modalStyle.merge(widget.modalConfig?.style),
  //     headerStyle: widget.modalConfig?.headerStyle?.copyWith(
  //       textStyle: theme.textTheme.headline6.merge(widget.modalConfig?.headerStyle?.textStyle)
  //     ),
  //   );
  // }

  /// get choice style
  S2ChoiceStyle get choiceStyle => choiceConfig?.style;

  /// get modal style
  S2ModalStyle get modalStyle => modalConfig?.style;

  /// get modal header style
  S2ModalHeaderStyle get modalHeaderStyle => modalConfig?.headerStyle;

  /// get primary title
  String get title => widget.title ?? modalConfig?.title;

  /// get primary title widget
  Widget get titleWidget => Text(title);

  /// get modal widget
  Widget get modal {
    return AnimatedBuilder(
      animation: filter,
      builder: (context, _) {
        modalContext = context;
        return AnimatedBuilder(
          animation: changes,
          builder: (context, _) => _customModal ?? defaultModal,
        );
      }
    );
  }

  /// get default modal widget
  Widget get defaultModal {
    return WillPopScope(
      onWillPop: () async => changes.valid,
      child: modalConfig.isFullPage == true
        ? Scaffold(
            backgroundColor: modalConfig.style.backgroundColor,
            appBar: PreferredSize(
              child: modalHeader,
              preferredSize: Size.fromHeight(kToolbarHeight)
            ),
            body: modalBody,
          )
        : SafeArea(child: modalBody),
    );
  }

  /// get custom modal
  Widget get _customModal;

  /// return the modal body
  Widget get modalBody {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        modalConfig.isFullPage != true ? modalHeader : null,
        modalDivider,
        Flexible(
          fit: modalConfig.isFullPage == true ? FlexFit.tight : FlexFit.loose,
          child: choiceItems,
        ),
        modalDivider,
        modalFooter,
      ]..removeWhere((child) => child == null),
    );
  }

  /// get modal divider
  Widget get modalDivider;

  /// get modal footer
  Widget get modalFooter;

  /// build title widget
  Widget get modalTitle {
    String _title = modalConfig?.title ?? widget.title ?? widget.placeholder;
    return Text(_title, style: modalHeaderStyle.textStyle);
  }

  /// build error widget
  Widget get modalError {
    return AnimatedCrossFade(
      firstChild: Container(height: 0.0, width: 0.0),
      secondChild: Text(changes?.error ?? '', style: modalHeaderStyle.errorStyle),
      duration: const Duration(milliseconds: 300),
      firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState: changes.valid ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  /// get filter widget
  Widget get modalFilter {
    return _customModalFilter ?? defaultModalFilter;
  }

  /// get custom filter widget
  Widget get _customModalFilter {
    return builder?.modalFilter?.call(context, filter);
  }

  /// get default filter widget
  Widget get defaultModalFilter {
    return TextField(
      autofocus: true,
      controller: filter.ctrl,
      style: modalHeaderStyle.textStyle,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration.collapsed(
        hintText: modalConfig.filterHint ?? 'Search on $title',
        hintStyle: modalHeaderStyle.textStyle,
      ),
      textAlign: modalConfig?.headerStyle?.centerTitle ?? false
        ? TextAlign.center
        : TextAlign.left,
      onSubmitted: modalConfig.filterAuto ? null : filter.apply,
      onChanged: modalConfig.filterAuto
        ? (query) => debouncer.run(() => filter.apply(query), delay: modalConfig.filterDelay)
        : null,
    );
  }

  /// get widget to show/hide modal filter
  Widget get modalFilterToggle {
    return modalConfig.useFilter
      ? _customModalFilterToggle ?? defaultModalFilterToggle
      : null;
  }

  /// get custom widget to show/hide modal filter
  Widget get _customModalFilterToggle {
    return builder?.modalFilterToggle?.call(context, filter);
  }

  /// get default widget to show/hide modal filter
  Widget get defaultModalFilterToggle {
    return !filter.activated
      ? IconButton(
          icon: Icon(Icons.search),
          onPressed: () => filter.show(modalContext),
        )
      : IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => filter.hide(modalContext),
        );
  }

  /// get confirm button widget
  Widget get confirmButton {
    return _customConfirmButton ?? defaultConfirmButton;
  }

  /// get custom confirm button widget
  Widget get _customConfirmButton;

  /// get default confirm button widget
  Widget get defaultConfirmButton {
    final VoidCallback onPressed = changes.valid
      ? () => closeModal(confirmed: true)
      : null;

    if (modalConfig.confirmLabel != null) {
      if (modalConfig.confirmIcon != null) {
        return Center(
          child: Padding(
            padding: modalConfig.confirmMargin ?? const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: FlatButton.icon(
              icon: modalConfig.confirmIcon,
              label: modalConfig.confirmLabel,
              color: modalConfig.confirmBrightness == Brightness.dark
                ? modalConfig.confirmColor ?? Colors.blueGrey
                : null,
              textColor: modalConfig.confirmBrightness == Brightness.light
                ? modalConfig.confirmColor
                : Colors.white,
              onPressed: onPressed,
            ),
          ),
        );
      } else {
        return Center(
          child: Padding(
            padding: modalConfig.confirmMargin ?? const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: FlatButton(
              child: modalConfig.confirmLabel,
              color: modalConfig.confirmBrightness == Brightness.dark
                ? modalConfig.confirmColor ?? Colors.blueGrey
                : null,
              textColor: modalConfig.confirmBrightness == Brightness.light
                ? modalConfig.confirmColor
                : Colors.white,
              onPressed: onPressed,
            ),
          ),
        );
      }
    } else {
      return Padding(
        padding: modalConfig.confirmMargin ?? const EdgeInsets.all(0),
        child: IconButton(
          icon: modalConfig.confirmIcon ?? Icon(Icons.check_circle_outline),
          color: modalConfig.confirmColor,
          onPressed: onPressed,
        ),
      );
    }
  }

  /// get modal header widget
  Widget get modalHeader {
    return modalConfig.useHeader == true
      ? _customModalHeader ?? defaultModalHeader
      : null;
  }

  /// get custom modal header
  Widget get _customModalHeader;

  /// get default modal header widget
  Widget get defaultModalHeader {
    return AppBar(
      shape: modalHeaderStyle.shape,
      elevation: modalHeaderStyle.elevation,
      brightness: modalHeaderStyle.brightness,
      backgroundColor: modalHeaderStyle.backgroundColor,
      actionsIconTheme: modalHeaderStyle.actionsIconTheme,
      iconTheme: modalHeaderStyle.iconTheme,
      centerTitle: modalHeaderStyle.centerTitle,
      automaticallyImplyLeading: modalConfig.type == S2ModalType.fullPage || filter.activated,
      leading: filter.activated ? Icon(Icons.search) : null,
      title: filter.activated == true
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

  /// get modal action widgets
  List<Widget> get modalActions {
    return (_customModalActions ?? defaultModalActions)..removeWhere((child) => child == null);
  }

  /// get custom modal header
  List<Widget> get _customModalActions;

  /// get default modal header widget
  List<Widget> get defaultModalActions {
    return <Widget>[
      modalFilterToggle,
      modalConfig.useConfirm && !filter.activated ? confirmButton : null,
    ];
  }

  /// get choices selector widget
  Widget get choiceSelector;

  /// get choice item builder
  /// by it's type from resolver
  S2ChoiceBuilder<T> get choiceBuilder {
    return S2ChoiceResolver<T>(
      isMultiChoice: widget.isMultiChoice,
      style: choiceStyle,
      type: choiceConfig.type,
      builder: (builder as S2Builder<T>)
    ).choiceBuilder;
  }

  /// get choice item builder
  /// by it's current state
  S2ChoiceItemBuilder<T> get choiceItemBuilder {
    return (S2Choice<T> choice) {
      return AnimatedBuilder(
        animation: changes,
        builder: (context, _) {
          return choiceBuilder(
            context,
            choice.copyWith(
              selected: changes.contains(choice.value),
              select: ([bool selected = true]) {
                // set temporary value
                changes.commit(choice.value, selected: selected);
                // for single choice check if is filtering and use confirmation
                if (widget.isMultiChoice != true) {
                  // Pop filtering status
                  if (filter.activated)
                    Navigator.pop(context);
                  // Pop navigator with confirmed return value
                  if (!modalConfig.useConfirm)
                    Navigator.pop(context, true);
                }
              },
            ),
            filter.query
          );
        },
      );
    };
  }

  /// build choice items widget
  Widget get choiceItems {
    return ListTileTheme(
      contentPadding: choiceStyle.padding,
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: choiceStyle.color,
        ),
        child: S2Choices<T>(
          itemBuilder: choiceItemBuilder,
          items: widget.choiceItems,
          config: choiceConfig,
          builder: builder,
          query: filter.query
        ),
      ),
    );
  }

  /// get choice empty widget
  Widget get choiceEmpty {
    return builder.choiceEmpty?.call(context, filter.query) ?? defaultChoiceEmpty;
  }

  /// get default choice empty widget
  Widget get defaultChoiceEmpty {
    return const S2ChoicesEmpty();
  }

  // show modal by type
  Future<bool> _showModalByType() async {
    bool confirmed = false;
    switch (modalConfig.type) {
      case S2ModalType.fullPage:
        confirmed = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => modal),
        );
        break;
      case S2ModalType.bottomSheet:
        confirmed = await showModalBottomSheet(
          context: context,
          shape: modalStyle.shape,
          clipBehavior: modalStyle.clipBehavior ?? Clip.none,
          backgroundColor: modalStyle.backgroundColor,
          elevation: modalStyle.elevation,
          isDismissible: modalConfig.barrierDismissible,
          barrierColor: modalConfig.barrierColor,
          enableDrag: modalConfig.enableDrag,
          builder: (_) => modal,
        );
        break;
      case S2ModalType.popupDialog:
        confirmed = await showDialog(
          context: context,
          barrierDismissible: modalConfig.barrierDismissible,
          barrierColor: modalConfig.barrierColor,
          builder: (_) => Dialog(
            shape: modalStyle.shape,
            clipBehavior: modalStyle.clipBehavior ?? Clip.antiAlias,
            backgroundColor: modalStyle.backgroundColor,
            elevation: modalStyle.elevation,
            child: modal,
          ),
        );
        break;
    }
    return confirmed;
  }

  /// get default tile widget
  Widget get defaultTile {
    return S2Tile<T>.fromState(this);
  }

  /// function to close the choice modal
  void closeModal({ bool confirmed = true }) {
    Navigator.pop(context, confirmed);
  }

  /// function to show the choice modal
  void showModal();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    // initialize filter
    filter = S2Filter()..addListener(_filterHandler);
  }

  @override
  void dispose() {
    // dispose everything
    filter?.dispose();
    changes?.dispose();
    super.dispose();
  }

}

/// State for Single Choice
class S2SingleState<T> extends S2State<T> {

  /// value changes state
  @override
  S2SingleChanges<T> changes;

  /// final value
  @override
  T value;

  /// return an object or array of object
  /// that represent the value
  @override
  S2Choice<T> get valueObject {
    return widget.choiceItems?.firstWhere(
      (S2Choice<T> item) => item.value == value,
      orElse: () => null
    );
  }

  /// return a string or array of string
  /// that represent the value
  @override
  String get valueTitle {
    return valueObject != null ? valueObject.title : null;
  }

  /// return a string that can be used as display
  /// when value is null it will display placeholder
  @override
  String get valueDisplay {
    return valueTitle ?? widget.placeholder ?? '';
  }

  /// Called when single choice value changed
  @override
  ValueChanged<S2SingleState<T>> get onChange => widget.singleOnChange;

  /// get collection of builder
  @override
  S2SingleBuilder<T> get builder => widget.singleBuilder;

  /// get final modal validation
  @override
  ValidationCallback<T> get modalValidation => widget.singleModalValidation;

  @override
  initState() {
    super.initState();
    // set initial final value
    setState(() => value = widget.singleValue);
    // set initial cache value
    changes = S2SingleChanges<T>(value, validation: modalValidation)..addListener(_changesHandler);
  }

  @override
  Widget build(BuildContext context) {
    return builder?.tile?.call(context, this) ?? defaultTile;
  }

  /// get custom modal widget
  @override
  Widget get _customModal {
    return builder?.modal?.call(modalContext, this);
  }

  /// get modal leading widget
  @override
  Widget get modalDivider {
    return builder?.modalDivider?.call(modalContext, this);
  }

  /// get modal trailing widget
  @override
  Widget get modalFooter {
    return builder?.modalFooter?.call(modalContext, this);
  }

  /// get custom modal header widget
  @override
  Widget get _customModalHeader {
    return builder?.modalHeader?.call(modalContext, this);
  }

  /// get custom modal header widget
  @override
  List<Widget> get _customModalActions {
    return builder?.modalActions?.call(modalContext, this);
  }

  /// get custom confirm button
  @override
  Widget get _customConfirmButton {
    return builder?.modalConfirm?.call(modalContext, this);
  }

  /// get choices selector widget
  @override
  Widget get choiceSelector => null;

  /// function to show the choice modal
  @override
  void showModal() async {
    // reset cache value
    changes.value = value;

    // show modal by type and return confirmed value
    bool confirmed = await _showModalByType();

    // dont return value if modal need confirmation and not confirmed
    if (modalConfig.useConfirm == true && confirmed != true) return;

    // return value
    if (changes.value != null) {
      // set cache to final value
      setState(() => value = changes.value);
      // return state to onChange callback
      onChange?.call(this);
    }
  }

}

/// State for Multiple Choice
class S2MultiState<T> extends S2State<T> {

  /// value changes state
  @override
  S2MultiChanges<T> changes;

  /// final value
  @override
  List<T> value;

  /// return an object or array of object
  /// that represent the value
  List<S2Choice<T>> get valueObject {
    return widget.choiceItems
      .where((S2Choice<T> item) => value?.contains(item.value) ?? false)
      .toList()
      .cast<S2Choice<T>>();
  }

  /// return a string or array of string
  /// that represent the value
  List<String> get valueTitle {
    return valueObject != null && valueObject.length > 0
      ? valueObject.map((S2Choice<T> item) => item.title).toList()
      : null;
  }

  /// return a string that can be used as display
  /// when value is null it will display placeholder
  @override
  String get valueDisplay {
    return valueTitle?.join(', ') ?? widget.placeholder ?? '';
  }

  /// Called when multiple choice value changed
  @override
  ValueChanged<S2MultiState<T>> get onChange => widget.multiOnChange;

  /// get collection of builder
  @override
  S2MultiBuilder<T> get builder => widget.multiBuilder;

  /// get final modal validation
  @override
  ValidationCallback<List<T>> get modalValidation => widget.multiModalValidation;

  @override
  initState() {
    super.initState();
    // set initial final value
    setState(() => value = widget.multiValue);
    // set initial cache value
    changes = S2MultiChanges<T>(
      value,
      validation: modalValidation,
      selectAll: () {
        changes.value = widget.choiceItems
          .map((S2Choice<T> item) => item.value)
          .toList();
      }
    )..addListener(_changesHandler);
  }

  @override
  Widget build(BuildContext context) {
    return builder?.tile?.call(context, this) ?? defaultTile;
  }

  /// get custom modal widget
  @override
  Widget get _customModal {
    return builder?.modal?.call(modalContext, this);
  }

  /// get modal divider widget
  @override
  Widget get modalDivider {
    return builder?.modalDivider?.call(modalContext, this);
  }

  /// get modal footer widget
  @override
  Widget get modalFooter {
    return builder?.modalFooter?.call(modalContext, this);
  }

  /// get custom modal header widget
  @override
  Widget get _customModalHeader {
    return builder?.modalHeader?.call(modalContext, this);
  }

  /// get custom modal header widget
  @override
  List<Widget> get _customModalActions {
    return builder?.modalActions?.call(modalContext, this);
  }

  /// get custom confirm button
  @override
  Widget get _customConfirmButton {
    return builder?.modalConfirm?.call(modalContext, this);
  }

  /// get choices selector widget
  @override
  Widget get choiceSelector {
    return Checkbox(
      value: changes.length == widget.choiceItems.length
        ? true
        : changes.length == 0
          ? false
          : null,
      tristate: true,
      onChanged: (value) {
        if (value == true) {
          changes.selectAll();
        } else {
          changes.selectNone();
        }
      },
    );
  }

  /// function to show the choice modal
  @override
  void showModal() async {
    // reset cache value
    changes.value = value;

    // show modal by type and return confirmed value
    bool confirmed = await _showModalByType();

    // dont return value if modal need confirmation and not confirmed
    if (modalConfig.useConfirm == true && confirmed != true) {
      // reset cache value
      changes.value = value;
      return;
    }

    // return value
    if (changes.value != null) {
      // set cache to final value
      setState(() => value = changes.value);
      // return state to onChange callback
      onChange?.call(this);
    }
  }

}
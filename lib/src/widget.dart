import 'package:flutter/material.dart';
import './model/builder.dart';
import './model/modal_theme.dart';
import './model/modal_config.dart';
import './model/choice_theme.dart';
import './model/choice_config.dart';
import './model/choice.dart';
import './model/option.dart';
import './state/filter.dart';
import './state/cache.dart';
import './choices.dart';
import './choices_resolver.dart';
import './dialog.dart';
import './tile/default_tile.dart';
import './utils/debouncer.dart';

/// SmartSelect allows you to easily convert your usual form select or dropdown
/// into dynamic page, popup dialog, or sliding bottom sheet with various choices input
/// such as radio, checkbox, switch, chips, or even custom input.
class SmartSelect<T> extends StatefulWidget {

  /// The primary content of the widget.
  /// Used in trigger widget and header option
  final String title;

  /// The text displayed when the value is null
  final String placeholder;

  /// List of option item
  final List<S2Option<T>> options;

  /// Choice configuration
  final S2ChoiceConfig choiceConfig;

  /// Modal configuration
  final S2ModalConfig modalConfig;

  /// Whether show the options list
  /// as single choice or multiple choice
  final bool isMultiChoice;

  /// The current value of the single choicewidget.
  final T singleValue;

  /// The current value of the multi choice widget.
  final List<T> multiValue;

  /// Called when single choice value changed
  final ValueChanged<S2SingleState<T>> singleOnChange;

  /// Called when multiple choice value changed
  final ValueChanged<S2MultiState<T>> multiOnChange;

  /// Builder for single choice trigger widget
  final S2SingleBuilder<T> singleBuilder;

  /// Builder for multiple choice trigger widget
  final S2MultiBuilder<T> multiBuilder;

  /// Default constructor
  SmartSelect({
    Key key,
    this.title,
    this.placeholder,
    this.options,
    this.isMultiChoice,
    this.singleValue,
    this.singleOnChange,
    this.singleBuilder,
    this.multiValue,
    this.multiOnChange,
    this.multiBuilder,
    this.modalConfig = const S2ModalConfig(),
    this.choiceConfig = const S2ChoiceConfig(),
  }) :
    assert(isMultiChoice != null),
    assert(title != null || modalConfig?.title != null, 'title and modalConfig.title must not be both null'),
    assert(
      (isMultiChoice && multiOnChange != null && multiBuilder != null) || (!isMultiChoice && singleOnChange != null && singleBuilder != null)
      , isMultiChoice ? 'multiValue, multiOnChange, and multiBuilder must be not null in multiple choice' : 'singleValue, singleOnChange, and singleBuilder must be not null in single choice'
    ),
    assert(
      (isMultiChoice && (choiceConfig.type == S2ChoiceType.checkboxes || choiceConfig.type == S2ChoiceType.switches || choiceConfig.type == S2ChoiceType.chips)) || (!isMultiChoice && (choiceConfig.type == S2ChoiceType.radios || choiceConfig.type == S2ChoiceType.chips)),
      isMultiChoice ? 'multiple choice only support SmartSelectChoiceType.checkboxes, SmartSelectChoiceType.switches and SmartSelectChoiceType.chips' : 'Single choice only support SmartSelectChoiceType.radios and SmartSelectChoiceType.chips'
    ),
    super(key: key);

  /// Constructor for single choice
  factory SmartSelect.single({
    Key key,
    String title,
    String placeholder = 'Select one',
    @required T value,
    @required List<S2Option<T>> options,
    @required ValueChanged<S2SingleState<T>> onChange,
    S2WidgetBuilder<S2SingleState<T>> tileBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalHeaderBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalConfirmBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalDividerBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalFooterBuilder,
    S2WidgetBuilder<S2Filter> modalFilterBuilder,
    S2WidgetBuilder<S2Filter> modalFilterToggleBuilder,
    S2ChoiceItemBuilder<T> choiceBuilder,
    S2ChoiceItemBuilder<T> choiceTitleBuilder,
    S2ChoiceItemBuilder<T> choiceSubtitleBuilder,
    S2ChoiceItemBuilder<T> choiceSecondaryBuilder,
    IndexedWidgetBuilder choiceDividerBuilder,
    S2WidgetBuilder<String> choiceEmptyBuilder,
    S2GroupBuilder groupBuilder,
    S2GroupHeaderBuilder groupHeaderBuilder,
    S2SingleBuilder<T> builder,
    S2ChoiceStyle choiceStyle,
    S2ChoiceHeaderStyle choiceHeaderStyle,
    S2ChoiceConfig choiceConfig,
    S2ChoiceType choiceType,
    S2ChoiceLayout choiceLayout,
    Axis choiceDirection,
    bool choiceGrouped,
    bool choiceDivider,
    SliverGridDelegate choiceGrid,
    S2ModalConfig modalConfig,
    S2ModalStyle modalStyle,
    S2ModalHeaderStyle modalHeaderStyle,
    S2ModalType modalType,
    bool modalHeader,
    bool modalConfirmation,
    bool modalFilter,
    bool modalFilterAuto,
    String modalFilterHint,
    String modalTitle,
  }) {
    S2ModalConfig defaultModalConfig = const S2ModalConfig();
    S2ChoiceConfig defaultChoiceConfig = const S2ChoiceConfig(type: S2ChoiceType.radios);
    return SmartSelect<T>(
      key: key,
      title: title,
      placeholder: placeholder,
      options: options,
      isMultiChoice: false,
      multiValue: null,
      multiOnChange: null,
      multiBuilder: null,
      singleValue: value,
      singleOnChange: onChange,
      singleBuilder: S2SingleBuilder<T>().merge(builder).copyWith(
        tileBuilder: tileBuilder,
        modalBuilder: modalBuilder,
        modalHeaderBuilder: modalHeaderBuilder,
        modalConfirmBuilder: modalConfirmBuilder,
        modalDividerBuilder: modalDividerBuilder,
        modalFooterBuilder: modalFooterBuilder,
        modalFilterBuilder: modalFilterBuilder,
        modalFilterToggleBuilder: modalFilterToggleBuilder,
        choiceBuilder: choiceBuilder,
        choiceTitleBuilder: choiceTitleBuilder,
        choiceSubtitleBuilder: choiceSubtitleBuilder,
        choiceSecondaryBuilder: choiceSecondaryBuilder,
        choiceDividerBuilder: choiceDividerBuilder,
        choiceEmptyBuilder: choiceEmptyBuilder,
        groupBuilder: groupBuilder,
        groupHeaderBuilder: groupHeaderBuilder,
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
        useConfirmation: modalConfirmation,
        style: modalStyle,
        headerStyle: modalHeaderStyle,
      ),
    );
  }

  /// Constructor for multiple choice
  factory SmartSelect.multiple({
    Key key,
    String title,
    String placeholder = 'Select one or more',
    @required List<T> value,
    @required List<S2Option<T>> options,
    @required ValueChanged<S2MultiState<T>> onChange,
    S2WidgetBuilder<S2MultiState<T>> tileBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalHeaderBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalConfirmBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalDividerBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalFooterBuilder,
    S2WidgetBuilder<S2Filter> modalFilterBuilder,
    S2WidgetBuilder<S2Filter> modalFilterToggleBuilder,
    S2ChoiceItemBuilder<T> choiceBuilder,
    S2ChoiceItemBuilder<T> choiceTitleBuilder,
    S2ChoiceItemBuilder<T> choiceSubtitleBuilder,
    S2ChoiceItemBuilder<T> choiceSecondaryBuilder,
    IndexedWidgetBuilder choiceDividerBuilder,
    S2WidgetBuilder<String> choiceEmptyBuilder,
    S2GroupBuilder groupBuilder,
    S2GroupHeaderBuilder groupHeaderBuilder,
    S2MultiBuilder<T> builder,
    S2ChoiceConfig choiceConfig,
    S2ChoiceStyle choiceStyle,
    S2ChoiceHeaderStyle choiceHeaderStyle,
    S2ChoiceType choiceType,
    S2ChoiceLayout choiceLayout,
    Axis choiceDirection,
    bool choiceGrouped,
    bool choiceDivider,
    SliverGridDelegate choiceGrid,
    S2ModalConfig modalConfig,
    S2ModalStyle modalStyle,
    S2ModalHeaderStyle modalHeaderStyle,
    S2ModalType modalType,
    bool modalHeader,
    bool modalConfirmation,
    bool modalFilter,
    bool modalFilterAuto,
    String modalFilterHint,
    String modalTitle,
  }) {
    S2ModalConfig defaultModalConfig = const S2ModalConfig();
    S2ChoiceConfig defaultChoiceConfig = const S2ChoiceConfig(type: S2ChoiceType.checkboxes);
    return SmartSelect<T>(
      key: key,
      title: title,
      placeholder: placeholder,
      options: options,
      isMultiChoice: true,
      singleValue: null,
      singleOnChange: null,
      singleBuilder: null,
      multiValue: value,
      multiOnChange: onChange,
      multiBuilder: S2MultiBuilder<T>().merge(builder).copyWith(
        tileBuilder: tileBuilder,
        modalBuilder: modalBuilder,
        modalHeaderBuilder: modalHeaderBuilder,
        modalConfirmBuilder: modalConfirmBuilder,
        modalDividerBuilder: modalDividerBuilder,
        modalFooterBuilder: modalFooterBuilder,
        modalFilterBuilder: modalFilterBuilder,
        modalFilterToggleBuilder: modalFilterToggleBuilder,
        choiceBuilder: choiceBuilder,
        choiceTitleBuilder: choiceTitleBuilder,
        choiceSubtitleBuilder: choiceSubtitleBuilder,
        choiceSecondaryBuilder: choiceSecondaryBuilder,
        choiceDividerBuilder: choiceDividerBuilder,
        choiceEmptyBuilder: choiceEmptyBuilder,
        groupBuilder: groupBuilder,
        groupHeaderBuilder: groupHeaderBuilder,
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
        useConfirmation: modalConfirmation,
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

abstract class S2State<T> extends State<SmartSelect<T>> {
  /// filter state
  S2Filter filter;

  /// temporary value
  S2Cache<T> cache;

  /// modal build context
  BuildContext modalContext;

  /// debouncer used in search text on changed
  final Debouncer debouncer = Debouncer();

  /// return an object or array of object
  /// that represent the value
  get valueObject;

  /// return a string or array of string
  /// that represent the value
  get valueTitle;

  /// return a string that can be used as display
  /// when value is null it will display placeholder
  String get valueDisplay;

  /// Called when single choice value changed
  get onChange;

  /// get collection of builder
  get builder;

  // filter listener handler
  void _filterHandler() => setState(() {});

  // cache listener handler
  void _cacheHandler() => setState(() {});

  /// get theme data
  ThemeData get theme => Theme.of(context);

  /// get choice config
  S2ChoiceConfig get choiceConfig => widget.choiceConfig.copyWith(
    style: S2ChoiceStyle(
      activeColor: theme.primaryColor,
      color: theme.unselectedWidgetColor,
    ).merge(widget.choiceConfig?.style)
  );

  /// get modal config
  S2ModalConfig get modalConfig => widget.modalConfig?.copyWith(
    headerStyle: widget.modalConfig?.headerStyle?.copyWith(
      textStyle: theme.textTheme.title.merge(widget.modalConfig?.headerStyle?.textStyle)
    ),
  );

  /// get choice style
  S2ChoiceStyle get choiceStyle => choiceConfig?.style;

  /// get modal style
  S2ModalStyle get modalStyle => modalConfig?.style;

  /// get modal header style
  S2ModalHeaderStyle get modalHeaderStyle => modalConfig?.headerStyle;

  /// get primary title
  String get title => widget.title ?? modalConfig?.title;

  Widget get modal {
    return AnimatedBuilder(
      animation: filter,
      builder: (context, _) {
        modalContext = context;
        return _customModal != null
          ? AnimatedBuilder(
              animation: cache,
              builder: (context, _) => _customModal,
            )
          : defaultModal;
      }
    );
  }

  // get default modal widget
  Widget get defaultModal {
    return _S2Modal(
      config: modalConfig,
      choices: choiceItems,
      header: AnimatedBuilder(
        animation: cache,
        builder: (context, _) => modalHeader ?? Container(),
      ),
      divider: AnimatedBuilder(
        animation: cache,
        builder: (context, _) => modalDivider ?? Container(),
      ),
      footer: AnimatedBuilder(
        animation: cache,
        builder: (context, _) => modalFooter ?? Container(),
      ),
    );
  }

  /// get custom modal
  Widget get _customModal;

  /// get modal divider
  Widget get modalDivider;

  /// get modal footer
  Widget get modalFooter;

  /// build title widget
  Widget get modalTitle {
    String title = modalConfig?.title ?? widget.title ?? widget.placeholder;
    return Text(title, style: modalHeaderStyle.textStyle);
  }

  /// get filter widget
  Widget get modalFilter {
    return _customModalFilter ?? defaultModalFilter;
  }

  /// get custom filter widget
  Widget get _customModalFilter {
    return builder?.modalFilterBuilder?.call(context, filter);
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
        ? (query) => debouncer.run(() => filter.apply(query))
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
    return builder?.modalFilterToggleBuilder?.call(context, filter);
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
    return modalConfig.useConfirmation && !filter.activated
      ? _customConfirmButton ?? defaultConfirmButton
      : null;
  }

  /// get custom confirm button widget
  Widget get _customConfirmButton;

  /// get default confirm button widget
  Widget get defaultConfirmButton {
    return IconButton(
      icon: Icon(Icons.check_circle_outline),
      onPressed: () => closeModal(confirmed: true),
    );
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
      title: filter.activated == true ? modalFilter : modalTitle,
      actions: <Widget>[
        modalFilterToggle,
        confirmButton,
      ]..removeWhere((child) => child == null),
    );
  }

  /// build choice builder from resolver
  S2ChoiceItemBuilder<T> get choiceBuilder {
    return S2ChoiceResolver<T>(
      isMultiChoice: widget.isMultiChoice,
      style: choiceStyle,
      type: choiceConfig.type,
      builder: (builder as S2Builder<T>)
    ).choiceBuilder;
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
          query: filter.query,
          config: choiceConfig,
          builder: (builder as S2Builder<T>),
          items: widget.options,
          itemBuilder: (S2Option<T> option) {
            return AnimatedBuilder(
              animation: cache,
              builder: (context, _) {
                return choiceBuilder(
                  context,
                  S2Choice<T>(
                    data: option,
                    selected: cache.contains(option.value),
                    select: ([bool checked = true]) {
                      // set temporary value
                      cache.select(option.value, checked);
                      // for single choice check if is filtering and use confirmation
                      if (widget.isMultiChoice != true) {
                        // Pop filtering status
                        if (filter.activated)
                          Navigator.pop(context);
                        // Pop navigator with confirmed return value
                        if (!modalConfig.useConfirmation)
                          Navigator.pop(context, true);
                      }
                    },
                  ),
                  filter.query
                );
              },
            );
          },
        ),
      ),
    );
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
          clipBehavior: modalStyle.clipBehavior,
          backgroundColor: modalStyle.backgroundColor,
          elevation: modalStyle.elevation,
          builder: (_) => modal,
        );
        break;
      case S2ModalType.popupDialog:
        confirmed = await showDialog(
          context: context,
          builder: (_) => S2Dialog(
            shape: modalStyle.shape,
            clipBehavior: modalStyle.clipBehavior,
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
    return S2Tile.fromState(this);
  }

  /// call back to close the choice modal
  void closeModal({ bool confirmed = true }) {
    Navigator.pop(context, confirmed);
  }

  /// call back to show the choice modal
  void showModal();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  initState() {
    super.initState();
    filter = S2Filter()..addListener(_filterHandler);
  }

  @override
  dispose() {
    // dispose everything
    filter?.dispose();
    cache?.dispose();
    super.dispose();
  }

}

class S2SingleState<T> extends S2State<T> {

  /// final value
  T value;

  /// return an object or array of object
  /// that represent the value
  @override
  S2Option<T> get valueObject {
    return widget.options.firstWhere(
      (S2Option<T> item) => item.value == value,
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

  @override
  initState() {
    super.initState();
    // set initial final value
    setState(() => value = widget.singleValue);
    // set initial cache value
    cache = S2SingleCache<T>(value)..addListener(_cacheHandler);
  }

  @override
  Widget build(BuildContext context) {
    return builder?.tileBuilder?.call(context, this) ?? defaultTile;
  }

  /// get custom modal widget
  @override
  Widget get _customModal {
    return builder?.modalBuilder?.call(modalContext, this);
  }

  /// get modal leading widget
  @override
  Widget get modalDivider {
    return builder?.modalDividerBuilder?.call(modalContext, this);
  }

  /// get modal trailing widget
  @override
  Widget get modalFooter {
    return builder?.modalFooterBuilder?.call(modalContext, this);
  }

  /// get custom modal header widget
  @override
  Widget get _customModalHeader {
    return builder?.modalHeaderBuilder?.call(modalContext, this);
  }

  /// get custom confirm button
  @override
  Widget get _customConfirmButton {
    return builder?.modalConfirmBuilder?.call(modalContext, this);
  }

  @override
  void showModal() async {
    // reset cache value
    (cache as S2SingleCache<T>).value = value;

    // show modal by type and return confirmed value
    bool confirmed = await _showModalByType();

    // dont return value if modal need confirmation and not confirmed
    if (modalConfig.useConfirmation == true && confirmed != true) return;

    // return value
    if ((cache as S2SingleCache<T>).value != null) {
      // set cache to final value
      setState(() => value = (cache as S2SingleCache<T>).value);
      // return state to onChange callback
      onChange?.call(this);
    }
  }

}

class S2MultiState<T> extends S2State<T> {

  /// final value
  List<T> value;

  /// return an object or array of object
  /// that represent the value
  List<S2Option<T>> get valueObject {
    return widget.options.where((S2Option<T> item) => value?.contains(item.value) ?? false).toList().cast<S2Option<T>>();
  }

  /// return a string or array of string
  /// that represent the value
  List<String> get valueTitle {
    return valueObject != null && valueObject.length > 0
      ? valueObject.map((S2Option<T> item) => item.title).toList()
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

  @override
  initState() {
    super.initState();
    // set initial final value
    setState(() => value = widget.multiValue ?? []);
    // set initial cache value
    cache = S2MultiCache<T>(value)..addListener(_cacheHandler);
  }

  @override
  Widget build(BuildContext context) {
    return builder?.tileBuilder?.call(context, this) ?? defaultTile;
  }

  /// get custom modal widget
  @override
  Widget get _customModal {
    return builder?.modalBuilder?.call(modalContext, this);
  }

  /// get modal divider widget
  @override
  Widget get modalDivider {
    return builder?.modalDividerBuilder?.call(modalContext, this);
  }

  /// get modal footer widget
  @override
  Widget get modalFooter {
    return builder?.modalFooterBuilder?.call(modalContext, this);
  }

  /// get custom modal header widget
  @override
  Widget get _customModalHeader {
    return builder?.modalHeaderBuilder?.call(modalContext, this);
  }

  /// get custom confirm button
  @override
  Widget get _customConfirmButton {
    return builder?.modalConfirmBuilder?.call(modalContext, this);
  }

  @override
  void showModal() async {
    // reset cache value
    (cache as S2MultiCache<T>).value = value;

    // show modal by type and return confirmed value
    bool confirmed = await _showModalByType();

    // dont return value if modal need confirmation and not confirmed
    if (modalConfig.useConfirmation == true && confirmed != true) {
      // reset cache value
      (cache as S2MultiCache<T>).value = value;
      return;
    }

    // return value
    if ((cache as S2MultiCache<T>).value != null) {
      // set cache to final value
      setState(() => value = (cache as S2MultiCache<T>).value);
      // return state to onChange callback
      onChange?.call(this);
    }
  }

}

class _S2Modal extends StatelessWidget {

  final S2ModalConfig config;
  final Widget header;
  final Widget choices;
  final Widget divider;
  final Widget footer;

  _S2Modal({
    Key key,
    @required this.config,
    @required this.header,
    @required this.choices,
    @required this.divider,
    @required this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_isFullPage == true) {
      return Scaffold(
        backgroundColor: config.style.backgroundColor,
        appBar: PreferredSize(
          child: header,
          preferredSize: Size.fromHeight(kToolbarHeight)
        ),
        body: _modalBody,
      );
    } else {
      return _modalBody;
    }
  }

  bool get _isFullPage {
    return config.type == S2ModalType.fullPage;
  }

  Widget get _modalBody {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _isFullPage != true ? header : null,
          divider,
          Flexible(
            fit: FlexFit.loose,
            child: choices,
          ),
          divider,
          footer,
        ]..removeWhere((child) => child == null),
      ),
    );
  }
}
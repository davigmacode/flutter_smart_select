import 'dart:ui';
import 'package:flutter/material.dart';
import './model/builder.dart';
import './model/modal_theme.dart';
import './model/modal_config.dart';
import './model/choice_theme.dart';
import './model/choice_config.dart';
import './model/choice_item.dart';
import './model/group_data.dart';
import './model/group_config.dart';
import './model/group_style.dart';
import './model/group_sort.dart';
import './model/choices.dart';
import './state/filter.dart';
import './state/changes.dart';
import './choices_resolver.dart';
import './tile/tile.dart';
import './utils/debouncer.dart';
import './group_header.dart';
import './choices_list.dart';
import './choices_empty.dart';
import './stateful_builder.dart';
import './text.dart';

typedef void TwoValueChanged<A, B>(A firstValue, B secondValue);

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

  /// Group configuration
  final S2GroupConfig groupConfig;

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

  /// Called when single choice selection changed
  final TwoValueChanged<S2SingleState<T>, S2Choice<T>> singleOnSelect;

  /// Called when single choice modal opened
  final ValueChanged<S2SingleState<T>> singleOnModalOpen;

  /// Called when single choice modal closed
  final TwoValueChanged<S2SingleState<T>, bool> singleOnModalClose;

  /// Called when multiple choice value changed
  final ValueChanged<S2MultiState<T>> multiOnChange;

  /// Called when multiple choice selection changed
  final TwoValueChanged<S2MultiState<T>, S2Choice<T>> multiOnSelect;

  /// Called when multiple choice modal open
  final ValueChanged<S2MultiState<T>> multiOnModalOpen;

  /// Called when multiple choice modal closed
  final TwoValueChanged<S2MultiState<T>, bool> multiOnModalClose;

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
    this.singleOnModalOpen,
    this.singleOnSelect,
    this.singleOnModalClose,
    this.singleModalValidation,
    this.singleBuilder,
    this.multiValue,
    this.multiOnChange,
    this.multiOnModalOpen,
    this.multiOnSelect,
    this.multiOnModalClose,
    this.multiModalValidation,
    this.multiBuilder,
    this.modalConfig = const S2ModalConfig(),
    this.choiceConfig = const S2ChoiceConfig(),
    this.groupConfig = const S2GroupConfig(),
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
  ///
  /// The [title] argument is primary content of the widget.
  /// Used in trigger widget and header option
  ///
  /// The [placeholder] argument is text to display when the value is null
  ///
  /// The [value] argument is current value of the single choice widget.
  ///
  /// The [onChange] called when single choice value changed
  ///
  /// The [modalValidation] is validation function to validate the changes value
  ///
  /// The [choiceItems] is [List] of [S2Choice] item
  ///
  /// The [builder] is collection of builder for single choice widget
  ///
  /// The [tileBuilder] is shortcut to [builder.tile]
  /// a widget builder to customize tile widget
  ///
  /// The [modalBuilder] is shortcut to [builder.modal]
  /// a widget builder to customize modal widget
  ///
  /// The [modalHeaderBuilder] is shortcut to [builder.modalHeader]
  /// a widget builder to customize modal header widget
  ///
  /// The [modalActionsBuilder] is shortcut to [builder.modalActions]
  /// a widget builder to customize modal actions widget
  ///
  /// The [modalConfirmBuilder] is shortcut to [builder.modalConfirm]
  /// a widget builder to customize modal confirm action widget
  ///
  /// The [modalDividerBuilder] is shortcut to [builder.modalDivider]
  /// a widget builder to customize divider widget between header, body, and footer modal
  ///
  /// The [modalFooterBuilder] is shortcut to [builder.modalFooter]
  /// a widget builder to customize footer widget
  ///
  /// The [modalFilterBuilder] is shortcut to [builder.modalFilter]
  /// a widget builder to customize filter widget
  ///
  /// The [modalFilterToggleBuilder] is shortcut to [builder.modalFilterToggle]
  /// a widget builder to customize filter toggle widget
  ///
  /// The [choiceBuilder] is shortcut to [builder.choice]
  /// a widget builder to customize each choice item widget
  ///
  /// The [choiceTitleBuilder] is shortcut to [builder.choiceTitle]
  /// a widget builder to customize each choice item title widget
  ///
  /// The [choiceSubtitleBuilder] is shortcut to [builder.choiceSubtitle]
  /// a widget builder to customize choice item subtitle widget
  ///
  /// The [choiceSecondaryBuilder] is shortcut to [builder.choiceSecondary]
  /// a widget builder to customize choice item secondary widget
  ///
  /// The [choiceDividerBuilder] is shortcut to [builder.choiceDivider]
  /// a widget builder to customize divider widget between choices item
  ///
  /// The [choiceEmptyBuilder] is shortcut to [builder.choiceEmpty]
  /// a widget builder to customize empty display widget
  ///
  /// The [choiceGroupBuilder] is shortcut to [builder.choiceGroup]
  /// a widget builder to customize choices group widget
  ///
  /// The [choiceHeaderBuilder] is shortcut to [builder.choiceHeader]
  /// a widget builder to customize header widget on grouped choices
  ///
  /// The [choiceConfig] is a configuration to customize choice widget
  ///
  /// The [choiceStyle] is shortcut to [choiceConfig.style]
  /// a configuration for styling unselected choice widget
  ///
  /// The [choiceActiveStyle] is shortcut to [choiceConfig.activeStyle]
  /// a configuration for styling selected choice widget
  ///
  /// The [choiceHeaderStyle] is shortcut to [choiceConfig.headerStyle]
  /// a configuration for styling header widget of grouped choices
  ///
  /// The [choiceType] is shortcut to [choiceConfig.type]
  /// widget type to display the choice items
  ///
  /// The [choiceLayout] is shortcut to [choiceConfig.layout]
  /// layout to display the choice items
  ///
  /// The [choiceDirection] is shortcut to [choiceConfig.direction]
  /// scroll direction of the choice items. Currently only support when [choiceLayout] or [choiceConfig.layout] is [S2ChoiceLayout.wrap]
  ///
  /// The [choiceGrouped] is shortcut to [choiceConfig.isGrouped]
  /// whether the choice items is grouped or not, based on [S2Choice.group] value
  ///
  /// The [choiceDivider] is shortcut to [choiceConfig.useDivider]
  /// whether the choice items use divider or not
  ///
  /// The [choiceGrid] is shortcut to [choiceConfig.gridDelegate]
  /// a delegate that controls the layout of the children within the [GridView] when [choiceLayout] is [S2ChoiceLayout.grid].
  ///
  /// Then [modalConfig] is configuration to customize behavior of the choices modal
  ///
  /// The [modalStyle] is shortcut to [modalConfig.style]
  /// a configuration for styling modal widget
  ///
  /// The [modalHeaderStyle] is shortcut to [modalConfig.headerStyle]
  /// a configuration for styling header of the modal widget
  ///
  /// The [modalType] is shortcut to [modalConfig.type]
  /// modal type to display the choice items
  ///
  /// The [modalTitle] is shortcut to [modalConfig.title]
  /// used to override [title] in the modal widget
  ///
  /// The [modalConfirm] is shortcut to [modalConfig.useConfirm]
  /// Whether the modal need to confirm before returning the changed value
  ///
  /// The [modalHeader] is shortcut to [modalConfig.useHeader]
  /// Whether the modal use header or not
  ///
  /// The [modalFilter] is shortcut to [modalConfig.useFilter]
  /// Whether the choice items in the modal is filterable or not
  ///
  /// The [modalFilterAuto] shortcut to [modalConfig.filterAuto]
  /// Whether the filter is autocomplete or need to confirm with filter button
  ///
  /// The [modalFilterHint] is shortcut to [modalConfig.filterHint]
  /// [String] to display as hint in searchbar
  factory SmartSelect.single({
    Key key,
    String title,
    String placeholder = 'Select one',
    @required T value,
    @required ValueChanged<S2SingleState<T>> onChange,
    TwoValueChanged<S2SingleState<T>, S2Choice<T>> onSelect,
    ValueChanged<S2SingleState<T>> onModalOpen,
    TwoValueChanged<S2SingleState<T>, bool> onModalClose,
    ValidationCallback<T> modalValidation,
    List<S2Choice<T>> choiceItems,
    S2SingleBuilder<T> builder,
    S2WidgetBuilder<S2SingleState<T>> tileBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalHeaderBuilder,
    S2ListWidgetBuilder<S2SingleState<T>> modalActionsBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalConfirmBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalDividerBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalFooterBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalFilterBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalFilterToggleBuilder,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>> choiceBuilder,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>> choiceTitleBuilder,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>> choiceSubtitleBuilder,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>> choiceSecondaryBuilder,
    IndexedWidgetBuilder choiceDividerBuilder,
    S2WidgetBuilder<S2SingleState<T>> choiceEmptyBuilder,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Group<T>> groupBuilder,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Group<T>> groupHeaderBuilder,
    S2ChoiceConfig choiceConfig,
    S2ChoiceStyle choiceStyle,
    S2ChoiceStyle choiceActiveStyle,
    S2ChoiceType choiceType,
    S2ChoiceLayout choiceLayout,
    Axis choiceDirection,
    bool choiceGrouped,
    bool choiceDivider,
    SliverGridDelegate choiceGrid,
    S2GroupConfig groupConfig,
    bool groupEnabled,
    bool groupSelector,
    bool groupCounter,
    S2GroupSort groupSortBy,
    S2GroupHeaderStyle groupHeaderStyle,
    S2ModalConfig modalConfig,
    S2ModalStyle modalStyle,
    S2ModalHeaderStyle modalHeaderStyle,
    S2ModalType modalType,
    String modalTitle,
    bool modalConfirm,
    bool modalHeader,
    bool modalFilter,
    bool modalFilterAuto,
    String modalFilterHint,
  }) {
    S2ChoiceConfig defaultChoiceConfig = const S2ChoiceConfig(type: S2ChoiceType.radios);
    S2GroupConfig defaultGroupConfig = const S2GroupConfig();
    S2ModalConfig defaultModalConfig = const S2ModalConfig();
    return SmartSelect<T>(
      key: key,
      title: title,
      placeholder: placeholder,
      choiceItems: choiceItems,
      isMultiChoice: false,
      singleValue: value,
      singleOnChange: onChange,
      singleOnSelect: onSelect,
      singleOnModalOpen: onModalOpen,
      singleOnModalClose: onModalClose,
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
        group: groupBuilder,
        groupHeader: groupHeaderBuilder,
      ),
      choiceConfig: defaultChoiceConfig.merge(choiceConfig).copyWith(
        type: choiceType,
        layout: choiceLayout,
        direction: choiceDirection,
        gridDelegate: choiceGrid,
        useDivider: choiceDivider,
        style: choiceStyle,
        activeStyle: choiceActiveStyle,
      ),
      groupConfig: defaultGroupConfig.merge(groupConfig).copyWith(
        enabled: groupEnabled ?? choiceGrouped,
        useSelector: groupSelector,
        useCounter: groupCounter,
        sortBy: groupSortBy,
        headerStyle: groupHeaderStyle,
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
  ///
  /// The [title] argument is primary content of the widget.
  /// Used in trigger widget and header option
  ///
  /// The [placeholder] argument is text to display when the value is null
  ///
  /// The [value] argument is current value of the multiple choice widget.
  ///
  /// The [onChange] called when multiple choice value changed
  ///
  /// The [modalValidation] is validation function to validate the changes value
  ///
  /// The [choiceItems] is [List] of [S2Choice] item
  ///
  /// The [builder] is collection of builder for multiple choice widget
  ///
  /// The [tileBuilder] is shortcut to [builder.tile]
  /// a widget builder to customize tile widget
  ///
  /// The [modalBuilder] is shortcut to [builder.modal]
  /// a widget builder to customize modal widget
  ///
  /// The [modalHeaderBuilder] is shortcut to [builder.modalHeader]
  /// a widget builder to customize modal header widget
  ///
  /// The [modalActionsBuilder] is shortcut to [builder.modalActions]
  /// a widget builder to customize modal actions widget
  ///
  /// The [modalConfirmBuilder] is shortcut to [builder.modalConfirm]
  /// a widget builder to customize modal confirm action widget
  ///
  /// The [modalDividerBuilder] is shortcut to [builder.modalDivider]
  /// a widget builder to customize divider widget between header, body, and footer modal
  ///
  /// The [modalFooterBuilder] is shortcut to [builder.modalFooter]
  /// a widget builder to customize footer widget
  ///
  /// The [modalFilterBuilder] is shortcut to [builder.modalFilter]
  /// a widget builder to customize filter widget
  ///
  /// The [modalFilterToggleBuilder] is shortcut to [builder.modalFilterToggle]
  /// a widget builder to customize filter toggle widget
  ///
  /// The [choiceBuilder] is shortcut to [builder.choice]
  /// a widget builder to customize each choice item widget
  ///
  /// The [choiceTitleBuilder] is shortcut to [builder.choiceTitle]
  /// a widget builder to customize each choice item title widget
  ///
  /// The [choiceSubtitleBuilder] is shortcut to [builder.choiceSubtitle]
  /// a widget builder to customize choice item subtitle widget
  ///
  /// The [choiceSecondaryBuilder] is shortcut to [builder.choiceSecondary]
  /// a widget builder to customize choice item secondary widget
  ///
  /// The [choiceDividerBuilder] is shortcut to [builder.choiceDivider]
  /// a widget builder to customize divider widget between choices item
  ///
  /// The [choiceEmptyBuilder] is shortcut to [builder.choiceEmpty]
  /// a widget builder to customize empty display widget
  ///
  /// The [choiceGroupBuilder] is shortcut to [builder.choiceGroup]
  /// a widget builder to customize choices group widget
  ///
  /// The [choiceHeaderBuilder] is shortcut to [builder.choiceHeader]
  /// a widget builder to customize header widget on grouped choices
  ///
  /// The [choiceConfig] is a configuration to customize choice widget
  ///
  /// The [choiceStyle] is shortcut to [choiceConfig.style]
  /// a configuration for styling unselected choice widget
  ///
  /// The [choiceActiveStyle] is shortcut to [choiceConfig.activeStyle]
  /// a configuration for styling selected choice widget
  ///
  /// The [choiceHeaderStyle] is shortcut to [choiceConfig.headerStyle]
  /// a configuration for styling header widget of grouped choices
  ///
  /// The [choiceType] is shortcut to [choiceConfig.type]
  /// widget type to display the choice items
  ///
  /// The [choiceLayout] is shortcut to [choiceConfig.layout]
  /// layout to display the choice items
  ///
  /// The [choiceDirection] is shortcut to [choiceConfig.direction]
  /// scroll direction of the choice items. Currently only support when [choiceLayout] or [choiceConfig.layout] is [S2ChoiceLayout.wrap]
  ///
  /// The [choiceGrouped] is shortcut to [choiceConfig.isGrouped]
  /// whether the choice items is grouped or not, based on [S2Choice.group] value
  ///
  /// The [choiceDivider] is shortcut to [choiceConfig.useDivider]
  /// whether the choice items use divider or not
  ///
  /// The [choiceGrid] is shortcut to [choiceConfig.gridDelegate]
  /// a delegate that controls the layout of the children within the [GridView] when [choiceLayout] is [S2ChoiceLayout.grid].
  ///
  /// Then [modalConfig] is configuration to customize behavior of the choices modal
  ///
  /// The [modalStyle] is shortcut to [modalConfig.style]
  /// a configuration for styling modal widget
  ///
  /// The [modalHeaderStyle] is shortcut to [modalConfig.headerStyle]
  /// a configuration for styling header of the modal widget
  ///
  /// The [modalType] is shortcut to [modalConfig.type]
  /// modal type to display the choice items
  ///
  /// The [modalTitle] is shortcut to [modalConfig.title]
  /// used to override [title] in the modal widget
  ///
  /// The [modalConfirm] is shortcut to [modalConfig.useConfirm]
  /// Whether the modal need to confirm before returning the changed value
  ///
  /// The [modalHeader] is shortcut to [modalConfig.useHeader]
  /// Whether the modal use header or not
  ///
  /// The [modalFilter] is shortcut to [modalConfig.useFilter]
  /// Whether the choice items in the modal is filterable or not
  ///
  /// The [modalFilterAuto] shortcut to [modalConfig.filterAuto]
  /// Whether the filter is autocomplete or need to confirm with filter button
  ///
  /// The [modalFilterHint] is shortcut to [modalConfig.filterHint]
  /// [String] to display as hint in searchbar
  factory SmartSelect.multiple({
    Key key,
    String title,
    String placeholder = 'Select one or more',
    @required List<T> value,
    @required ValueChanged<S2MultiState<T>> onChange,
    TwoValueChanged<S2MultiState<T>, S2Choice<T>> onSelect,
    ValueChanged<S2MultiState<T>> onModalOpen,
    TwoValueChanged<S2MultiState<T>, bool> onModalClose,
    ValidationCallback<List<T>> modalValidation,
    List<S2Choice<T>> choiceItems,
    S2MultiBuilder<T> builder,
    S2WidgetBuilder<S2MultiState<T>> tileBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalHeaderBuilder,
    S2ListWidgetBuilder<S2MultiState<T>> modalActionsBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalConfirmBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalDividerBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalFooterBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalFilterBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalFilterToggleBuilder,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>> choiceBuilder,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>> choiceTitleBuilder,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>> choiceSubtitleBuilder,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>> choiceSecondaryBuilder,
    IndexedWidgetBuilder choiceDividerBuilder,
    S2WidgetBuilder<S2MultiState<T>> choiceEmptyBuilder,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Group<T>> groupBuilder,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Group<T>> groupHeaderBuilder,
    S2ChoiceConfig choiceConfig,
    S2ChoiceStyle choiceStyle,
    S2ChoiceStyle choiceActiveStyle,
    S2ChoiceType choiceType,
    S2ChoiceLayout choiceLayout,
    Axis choiceDirection,
    bool choiceGrouped,
    bool choiceDivider,
    SliverGridDelegate choiceGrid,
    S2GroupConfig groupConfig,
    bool groupEnabled,
    bool groupSelector,
    bool groupCounter,
    S2GroupSort groupSortBy,
    S2GroupHeaderStyle groupHeaderStyle,
    S2ModalConfig modalConfig,
    S2ModalStyle modalStyle,
    S2ModalHeaderStyle modalHeaderStyle,
    S2ModalType modalType,
    String modalTitle,
    bool modalConfirm,
    bool modalHeader,
    bool modalFilter,
    bool modalFilterAuto,
    String modalFilterHint,
  }) {
    S2ChoiceConfig defaultChoiceConfig = const S2ChoiceConfig(type: S2ChoiceType.checkboxes);
    S2ModalConfig defaultModalConfig = const S2ModalConfig();
    S2GroupConfig defaultGroupConfig = const S2GroupConfig();
    return SmartSelect<T>(
      key: key,
      title: title,
      placeholder: placeholder,
      choiceItems: choiceItems,
      isMultiChoice: true,
      multiValue: value,
      multiOnChange: onChange,
      multiOnSelect: onSelect,
      multiOnModalOpen: onModalOpen,
      multiOnModalClose: onModalClose,
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
        group: groupBuilder,
        groupHeader: groupHeaderBuilder,
      ),
      choiceConfig: defaultChoiceConfig.merge(choiceConfig).copyWith(
        type: choiceType,
        layout: choiceLayout,
        direction: choiceDirection,
        gridDelegate: choiceGrid,
        useDivider: choiceDivider,
        style: choiceStyle,
        activeStyle: choiceActiveStyle,
      ),
      groupConfig: defaultGroupConfig.merge(groupConfig).copyWith(
        enabled: groupEnabled ?? choiceGrouped,
        useSelector: groupSelector,
        useCounter: groupCounter,
        sortBy: groupSortBy,
        headerStyle: groupHeaderStyle,
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

  /// modal state setter
  StateSetter modalSetState;

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

  /// Called when choice value changed
  get onChange;

  /// Called when selection has made
  get onSelect;

  /// Called when modal opened
  get onModalOpen;

  /// Called when modal closed
  get onModalClose;

  /// get collection of builder
  get builder;

  // filter listener handler
  void _filterHandler() => modalSetState?.call(() {});

  // changes listener handler
  void _changesHandler() => modalSetState?.call(() {});

  /// Indicates the widget is multiple choice
  bool get isMultiChoice => widget.isMultiChoice == true;

  /// Indicates the widget is single choice
  bool get isSingleChoice => !isMultiChoice;

  /// get theme data
  ThemeData get theme => Theme.of(context);

  /// default style for unselected choice
  S2ChoiceStyle get defaultChoiceStyle => S2ChoiceStyle(
    titleStyle: const TextStyle(),
    subtitleStyle: const TextStyle(),
    control: S2ChoiceControl.platform,
    highlightColor: theme.highlightColor.withOpacity(.7)
  );

  /// default style for selected choice
  S2ChoiceStyle get defaultActiveChoiceStyle => defaultChoiceStyle;

  /// get choice config
  S2ChoiceConfig get choiceConfig => widget.choiceConfig;

  /// get choice style
  S2ChoiceStyle get choiceStyle => choiceConfig?.style;

  /// get active choice style
  S2ChoiceStyle get choiceActiveStyle => choiceConfig?.activeStyle;

  /// get choice config
  S2GroupConfig get groupConfig => widget.groupConfig?.copyWith(
    headerStyle: S2GroupHeaderStyle(
      backgroundColor: theme.cardColor,
      padding: widget.groupConfig.useSelector == true
        ? const EdgeInsets.fromLTRB(16, 0, 12, 0)
        : const EdgeInsets.symmetric(horizontal: 16.0)
    ).merge(widget.groupConfig?.headerStyle)
  );

  /// get modal config
  S2ModalConfig get modalConfig => widget.modalConfig?.copyWith(
    headerStyle: S2ModalHeaderStyle(
      backgroundColor: widget.modalConfig?.isFullPage != true
        ? theme.cardColor
        : null,
      textStyle: widget.modalConfig?.isFullPage != true
        ? theme.textTheme.headline6
        : theme.primaryTextTheme.headline6,
      iconTheme: widget.modalConfig?.isFullPage != true
        ? theme.iconTheme
        : null,
    ).merge(widget.modalConfig?.headerStyle)
  );

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
    return S2StatefulBuilder(
      builder: (_, StateSetter setState) {
        modalContext = context;
        modalSetState = setState;
        return _customModal ?? defaultModal;
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
            body: SafeArea(
              maintainBottomViewPadding: true,
              child: modalBody
            ),
          )
        : modalBody,
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
      secondChild: Text(changes?.error ?? '', style: modalHeaderStyle.errorStyle.copyWith(color: theme.errorColor)),
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
  Widget get _customModalFilter;

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
      textAlign: modalConfig?.headerStyle?.centerTitle == true
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
  Widget get _customModalFilterToggle;

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
                ? modalConfig.confirmColor
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
      primary: true,
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
  Widget get choiceSelectorAll;

  /// function to create toggle selector checkbox widget
  Widget choiceSelector(List<T> values);

  /// get choice item builder
  /// by it's type from resolver
  get choiceBuilder;

  /// get choice title widget
  Widget choiceTitle(BuildContext context, S2State<T> state, S2Choice<T> choice);

  /// get choice subtitle widget
  Widget choiceSubtitle(BuildContext context, S2State<T> state, S2Choice<T> choice);

  /// build secondary/avatar widget
  Widget choiceSecondary(BuildContext context, S2State<T> state, S2Choice<T> choice);

  /// get default choice title widget
  Widget defaultChoiceTitle(S2Choice<T> choice) {
    return S2Text(
      text: choice.title,
      style: choice.effectiveStyle.titleStyle,
      highlight: filter.query,
      highlightColor: choice.effectiveStyle.highlightColor,
    );
  }

  /// get default choice subtitle widget
  Widget defaultChoiceSubtitle(S2Choice<T> choice) {
    return S2Text(
      text: choice.subtitle,
      style: choice.effectiveStyle.subtitleStyle,
      highlight: filter.query,
      highlightColor: choice.effectiveStyle.highlightColor,
    );
  }

  /// get choice item builder
  /// by it's current state
  S2ChoiceItemBuilder<T> get choiceItemBuilder;

  /// build choice items widget
  Widget get choiceItems {
    final S2Choices<T> choices = S2Choices<T>(
      items: widget.choiceItems,
      query: filter.query,
      groupConfig: groupConfig
    );
    return choices.filteredItems.length > 0
      ? ListTileTheme(
          contentPadding: choiceConfig.style?.padding,
          child: choices.isGrouped == true
            ? groupedChoices(choices.groups)
            : S2ChoicesList<T>(
                items: choices.filteredItems,
                itemBuilder: choiceItemBuilder,
                config: choiceConfig,
                builder: builder,
              ),
        )
      : choiceEmpty;
  }

  /// get grouped choices widget
  Widget groupedChoices(List<S2Group<T>> groups) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (_, int i) {
          return _customGroup(groups[i]) ?? defaultGroup(groups[i]);
        },
      ),
    );
  }

  /// get default grouped choices widget
  Widget defaultGroup(S2Group<T> group) {
    final Widget _groupHeader = groupHeader(group);
    final Widget _groupChoices = groupChoices(group);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _groupHeader,
        _groupChoices,
      ],
    );
  }

  /// get custom grouped choices widget
  Widget _customGroup(S2Group<T> group) {
    return builder.group?.call(modalContext, this, group);
  }

  /// get group choices widget
  Widget groupChoices(S2Group<T> group) {
    return S2ChoicesList<T>(
      config: choiceConfig,
      builder: builder,
      items: group.choices,
      itemBuilder: choiceItemBuilder,
    );
  }

  /// get group header widget
  Widget groupHeader(S2Group<T> group) {
    return _customGroupHeader(group) ?? defaultGroupHeader(group);
  }

  /// get custom group header widget
  Widget _customGroupHeader(S2Group<T> group);

  /// get default group header widget
  Widget defaultGroupHeader(S2Group<T> group) {
    return S2GroupHeader(
      style: group.headerStyle,
      title: S2Text(
        text: group.name,
        highlight: filter.query,
        style: group.headerStyle.textStyle,
        highlightColor: group.headerStyle.highlightColor ?? const Color(0xFFFFF176),
      ),
      trailing: groupConfig.useSelector == true
        ? choiceSelector(group.values) ?? groupCounter(group)
        : groupConfig.useCounter == true
          ? groupCounter(group)
          : null,
    );
  }

  /// get group counter widget
  Widget groupCounter(S2Group<T> group) {
    return Text(
      group.count.toString(),
      style: group.headerStyle.textStyle,
    );
  }

  /// get choice empty widget
  Widget get choiceEmpty {
    return _customChoiceEmpty ?? defaultChoiceEmpty;
  }

  /// get custom empty choice widget
  Widget get _customChoiceEmpty;

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
          isScrollControlled: true,
          builder: (_) {
            final MediaQueryData mediaQuery = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
            final double topObstructions = mediaQuery.viewPadding.top;
            final double bottomObstructions = mediaQuery.viewPadding.bottom;
            final double keyboardHeight = mediaQuery.viewInsets.bottom;
            final double deviceHeight = mediaQuery.size.height;
            final bool isKeyboardOpen = keyboardHeight > 0;
            final double maxHeightFactor = isKeyboardOpen ? 1 : modalConfig.maxHeightFactor;
            final double modalHeight = (deviceHeight * maxHeightFactor) + keyboardHeight;
            final bool isFullHeight = modalHeight >= deviceHeight;
            return Container(
              padding: EdgeInsets.only(
                top: isFullHeight ? topObstructions : 0,
                bottom: keyboardHeight + bottomObstructions
              ),
              constraints: BoxConstraints(
                maxHeight: isFullHeight ? double.infinity : modalHeight
              ),
              child: modal,
            );
          },
        );
        break;
      case S2ModalType.popupDialog:
        confirmed = await showDialog(
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

  /// function to set the initial value
  void initValue();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    // set the initial value
    initValue();

    // initialize filter
    filter = S2Filter()..addListener(_filterHandler);
  }

  @override
  void dispose() {
    // dispose everything
    filter?.removeListener(_filterHandler);
    changes?.removeListener(_changesHandler);
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

  /// Called when selection has made
  @override
  TwoValueChanged<S2SingleState<T>, S2Choice<T>> get onSelect => widget.singleOnSelect;

  /// Called when open the modal
  @override
  ValueChanged<S2SingleState<T>> get onModalOpen => widget.singleOnModalOpen;

  /// Called when close the modal
  @override
  TwoValueChanged<S2SingleState<T>, bool> get onModalClose => widget.singleOnModalClose;

  /// get collection of builder
  @override
  S2SingleBuilder<T> get builder => widget.singleBuilder;

  /// get final modal validation
  @override
  ValidationCallback<T> get modalValidation => widget.singleModalValidation;

  @override
  void initValue() {
    // set initial final value
    setState(() => value = widget.singleValue);
    // set initial cache value
    changes = S2SingleChanges<T>(value, validation: modalValidation)..addListener(_changesHandler);
  }

  @override
  void didUpdateWidget(SmartSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // reset the initial value
    if (oldWidget.singleValue != widget.singleValue) initValue();
  }

  @override
  Widget build(BuildContext context) {
    return builder?.tile?.call(context, this) ?? defaultTile;
  }

  // /// get modal widget
  // @override
  // Widget get modal {
  //   return S2StatefulBuilder(
  //     builder: (_, StateSetter setState) {
  //       return S2StateProvider<S2SingleState<T>>(
  //         state: this,
  //         child: Builder(
  //           builder: (BuildContext context) {
  //             modalContext = context;
  //             modalSetState = setState;
  //             return _customModal ?? defaultModal;
  //           }
  //         ),
  //       );
  //     }
  //   );
  // }

  /// get custom modal widget
  @override
  Widget get _customModal {
    return builder?.modal?.call(modalContext, this);
  }

  /// get custom filter widget
  @override
  Widget get _customModalFilter {
    return builder?.modalFilter?.call(modalContext, this);
  }

  /// get custom widget to show/hide modal filter
  @override
  Widget get _customModalFilterToggle {
    return builder?.modalFilterToggle?.call(modalContext, this);
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

  /// get custom empty choice widget
  @override
  Widget get _customChoiceEmpty {
    return builder.choiceEmpty?.call(modalContext, this);
  }

  /// get custom grouped choices widget
  @override
  Widget _customGroup(S2Group<T> group) {
    return builder.group?.call(modalContext, this, group);
  }

  /// get custom group header widget
  @override
  Widget _customGroupHeader(S2Group<T> group) {
    return builder.groupHeader?.call(modalContext, this, group);
  }

  /// get choice item builder
  /// by it's current state
  S2ChoiceItemBuilder<T> get choiceItemBuilder {
    return (S2Choice<T> choice) => choiceBuilder(
      modalContext,
      this,
      choice.copyWith(
        selected: changes.contains(choice.value),
        select: ([bool selected = true]) {
          // set temporary value
          changes.commit(choice.value, selected: selected);
          // call the modal on change callback
          onSelect?.call(this, choice);
          // hide filter bar
          if (filter.activated)
            filter.hide(context);
          // confirm the value and close modal
          if (!modalConfig.useConfirm)
            closeModal(confirmed: true);
        },
        style: defaultChoiceStyle
          .merge(choiceStyle)
          .merge(choice.style),
        activeStyle: defaultActiveChoiceStyle
          .merge(choiceStyle)
          .merge(choice.style)
          .merge(choiceActiveStyle)
          .merge(choice.activeStyle)
      )
    );
  }

  /// get choice item builder
  /// by it's type from resolver
  @override
  S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>> get choiceBuilder {
    return builder.choice ?? S2ChoiceResolver.choiceBuilder<S2SingleState<T>, T>(choiceConfig.type);
  }

  /// get choice title widget
  @override
  Widget choiceTitle(BuildContext context, covariant S2SingleState<T> state, S2Choice<T> choice) {
    return choice.title != null
      ? builder?.choiceTitle?.call(context, state, choice)
        ?? defaultChoiceTitle(choice)
      : null;
  }

  /// get choice subtitle widget
  @override
  Widget choiceSubtitle(BuildContext context, covariant S2SingleState<T> state, S2Choice<T> choice) {
    return choice.subtitle != null
      ? builder?.choiceSubtitle?.call(context, state, choice)
        ?? defaultChoiceSubtitle(choice)
      : null;
  }

  /// build secondary/avatar widget
  @override
  Widget choiceSecondary(BuildContext context, covariant S2SingleState<T> state, S2Choice<T> choice) {
    return builder?.choiceSecondary?.call(context, state, choice);
  }

  /// get choices selector widget
  @override
  Widget get choiceSelectorAll => null;

  /// function to create toggle selector checkbox widget
  @override
  Widget choiceSelector(List<T> values) => null;

  /// function to close the choice modal
  @override
  void closeModal({ bool confirmed = true }) {
    onModalClose?.call(this, confirmed);
    super.closeModal(confirmed: confirmed);
  }

  /// function to show the choice modal
  @override
  void showModal() async {
    // call on modal open callback
    onModalOpen?.call(this);

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

  /// Called when modal of multiple choice value changed
  @override
  TwoValueChanged<S2MultiState<T>, S2Choice<T>> get onSelect => widget.multiOnSelect;

  /// Called when open the modal
  @override
  ValueChanged<S2MultiState<T>> get onModalOpen => widget.multiOnModalOpen;

  /// Called when close the modal
  @override
  TwoValueChanged<S2MultiState<T>, bool> get onModalClose => widget.multiOnModalClose;

  /// get collection of builder
  @override
  S2MultiBuilder<T> get builder => widget.multiBuilder;

  /// get final modal validation
  @override
  ValidationCallback<List<T>> get modalValidation => widget.multiModalValidation;

  @override
  void initValue() {
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
  void didUpdateWidget(SmartSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // reset the initial value
    if (oldWidget.multiValue != widget.multiValue) initValue();
  }

  @override
  Widget build(BuildContext context) {
    return builder?.tile?.call(context, this) ?? defaultTile;
  }

  // /// get modal widget
  // @override
  // Widget get modal {
  //   return S2StatefulBuilder(
  //     builder: (_, StateSetter setState) {
  //       return S2StateProvider<S2MultiState<T>>(
  //         state: this,
  //         child: Builder(
  //           builder: (BuildContext context) {
  //             modalContext = context;
  //             modalSetState = setState;
  //             return _customModal ?? defaultModal;
  //           }
  //         ),
  //       );
  //     }
  //   );
  // }

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

  /// get custom filter widget
  @override
  Widget get _customModalFilter {
    return builder?.modalFilter?.call(modalContext, this);
  }

  /// get custom widget to show/hide modal filter
  @override
  Widget get _customModalFilterToggle {
    return builder?.modalFilterToggle?.call(modalContext, this);
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

  /// get custom empty choice widget
  @override
  Widget get _customChoiceEmpty {
    return builder.choiceEmpty?.call(modalContext, this);
  }

  /// get custom grouped choices widget
  @override
  Widget _customGroup(S2Group<T> group) {
    return builder.group?.call(modalContext, this, group);
  }

  /// get custom group header widget
  @override
  Widget _customGroupHeader(S2Group<T> group) {
    return builder.groupHeader?.call(modalContext, this, group);
  }

  /// get choice item builder
  /// by it's current state
  S2ChoiceItemBuilder<T> get choiceItemBuilder {
    return (S2Choice<T> choice) => choiceBuilder(
      modalContext,
      this,
      choice.copyWith(
        selected: changes.contains(choice.value),
        select: ([bool selected = true]) {
          // set temporary value
          changes.commit(choice.value, selected: selected);
          // call the modal on change callback
          onSelect?.call(this, choice);
        },
        style: defaultChoiceStyle
          .merge(choiceStyle)
          .merge(choice.style),
        activeStyle: defaultActiveChoiceStyle
          .merge(choiceStyle)
          .merge(choice.style)
          .merge(choiceActiveStyle)
          .merge(choice.activeStyle)
      )
    );
  }

  /// get choice item builder
  /// by it's type from resolver
  @override
  S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>> get choiceBuilder {
    return builder.choice ?? S2ChoiceResolver.choiceBuilder<S2MultiState<T>, T>(choiceConfig.type);
  }

  /// get choice title widget
  @override
  Widget choiceTitle(BuildContext context, covariant S2MultiState<T> state, S2Choice<T> choice) {
    return choice.title != null
      ? builder?.choiceTitle?.call(context, state, choice)
        ?? defaultChoiceTitle(choice)
      : null;
  }

  /// get choice subtitle widget
  @override
  Widget choiceSubtitle(BuildContext context, covariant S2MultiState<T> state, S2Choice<T> choice) {
    return choice.subtitle != null
      ? builder?.choiceSubtitle?.call(context, state, choice)
        ?? defaultChoiceSubtitle(choice)
      : null;
  }

  /// build secondary/avatar widget
  @override
  Widget choiceSecondary(BuildContext context, covariant S2MultiState<T> state, S2Choice<T> choice) {
    return builder?.choiceSecondary?.call(context, state, choice);
  }

  /// get toggle choices selector all/none widget
  @override
  Widget get choiceSelectorAll {
    return Checkbox(
      activeColor: choiceActiveStyle?.color ?? defaultActiveChoiceStyle.color,
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

  /// function to create toggle selector checkbox widget
  @override
  Widget choiceSelector(List<T> values) {
    final List<T> _changes = List.from(changes.value);
    return Checkbox(
      activeColor: choiceActiveStyle?.color ?? defaultActiveChoiceStyle.color,
      value: values.every((e) => changes.contains(e))
        ? true
        : values.any((e) => changes.contains(e))
          ? null
          : false,
      tristate: true,
      onChanged: (value) {
        if (value == true) {
          changes.value = List.from(_changes)..addAll(values);
        } else {
          changes.value = List.from(_changes)..removeWhere((e) => values.contains(e));
        }
      },
    );
  }

  /// function to close the choice modal
  @override
  void closeModal({ bool confirmed = true }) {
    onModalClose?.call(this, confirmed);
    super.closeModal(confirmed: confirmed);
  }

  /// function to show the choice modal
  @override
  void showModal() async {
    // call on modal open callback
    onModalOpen?.call(this);

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

// class S2StateProvider<T> extends InheritedWidget {
//   final T state;

//   S2StateProvider({
//     Key key,
//     this.state,
//     Widget child,
//   }) : super(key: key, child: child);

//   static T of<T>(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<S2StateProvider<T>>().state;
//   }

//   @override
//   bool updateShouldNotify(S2StateProvider oldWidget) {
//     return oldWidget.state != state;
//   }
// }
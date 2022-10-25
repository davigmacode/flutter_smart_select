import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';

/// SmartSelect allows you to easily convert your usual form select or dropdown
/// into dynamic page, popup dialog, or sliding bottom sheet with various choices input
/// such as radio, checkbox, switch, chips, or even custom input.
class SmartSelect<T> extends StatefulWidget {
  /// The primary content of the widget.
  /// Used in trigger widget and header option
  final String? title;

  /// The text displayed when the value is null
  final String? placeholder;

  /// List of choice item
  final List<S2Choice<T>>? choiceItems;

  /// The function to load the choice items
  final S2ChoiceLoader<T>? choiceLoader;

  /// Choice configuration
  final S2ChoiceConfig choiceConfig;

  /// Group configuration
  final S2GroupConfig groupConfig;

  /// Modal configuration
  final S2ModalConfig modalConfig;

  /// Whether show the choice items
  /// as single choice or multiple choice
  final bool isMultiChoice;

  /// Initial selected choice
  final S2SingleSelected<T>? singleSelected;

  /// A function used to validate the selected choice
  final S2Validation<S2SingleChosen<T>>? singleValidation;

  /// Modal validation of single choice widget
  final S2Validation<S2SingleChosen<T>>? singleModalValidation;

  /// Called when value changed in single choice widget
  final ValueChanged<S2SingleSelected<T>>? singleOnChange;

  /// Called when selection has been made in single choice widget
  final S2ChoiceSelect<S2SingleState<T>, S2Choice<T>>? singleOnSelect;

  /// Called when modal opened in single choice widget
  final S2ModalOpen<S2SingleState<T>>? singleOnModalOpen;

  /// Called when modal closed in single choice widget
  final S2ModalClose<S2SingleState<T>>? singleOnModalClose;

  /// Called when modal will close in single choice widget
  final S2ModalWillOpen<S2SingleState<T>>? singleOnModalWillOpen;

  /// Called when modal will close in single choice widget
  final S2ModalWillClose<S2SingleState<T>>? singleOnModalWillClose;

  /// Builder collection of single choice widget
  final S2SingleBuilder<T>? singleBuilder;

  /// Initial selected choices
  final S2MultiSelected<T>? multiSelected;

  /// A function used to validate the selected choices
  final S2Validation<S2MultiChosen<T>>? multiValidation;

  /// Modal validation of multiple choice widget
  final S2Validation<S2MultiChosen<T>>? multiModalValidation;

  /// Called when value changed in multiple choice widget
  final ValueChanged<S2MultiSelected<T>>? multiOnChange;

  /// Called when selection has been made in multiple choice widget
  final S2ChoiceSelect<S2MultiState<T>, S2Choice<T>>? multiOnSelect;

  /// Called when modal open in multiple choice widget
  final S2ModalOpen<S2MultiState<T>>? multiOnModalOpen;

  /// Called when modal closed in multiple choice widget
  final S2ModalClose<S2MultiState<T>>? multiOnModalClose;

  /// Called when modal will close in single choice widget
  final S2ModalWillOpen<S2MultiState<T>>? multiOnModalWillOpen;

  /// Called when modal will close in single choice widget
  final S2ModalWillClose<S2MultiState<T>>? multiOnModalWillClose;

  /// Builder collection of multiple choice widget
  final S2MultiBuilder<T>? multiBuilder;

  /// Default constructor
  SmartSelect({
    Key? key,
    this.title,
    this.placeholder,
    required this.isMultiChoice,
    this.singleSelected,
    this.singleValidation,
    this.singleModalValidation,
    this.singleOnChange,
    this.singleOnSelect,
    this.singleOnModalOpen,
    this.singleOnModalClose,
    this.singleOnModalWillOpen,
    this.singleOnModalWillClose,
    this.singleBuilder,
    this.multiSelected,
    this.multiValidation,
    this.multiModalValidation,
    this.multiOnChange,
    this.multiOnSelect,
    this.multiOnModalOpen,
    this.multiOnModalClose,
    this.multiOnModalWillOpen,
    this.multiOnModalWillClose,
    this.multiBuilder,
    this.modalConfig = const S2ModalConfig(),
    this.choiceConfig = const S2ChoiceConfig(),
    this.groupConfig = const S2GroupConfig(),
    this.choiceItems,
    this.choiceLoader,
  })  : assert(
          title != null || modalConfig.title != null,
          'title and modalConfig.title must not be both null',
        ),
        assert(
          (isMultiChoice && multiOnChange != null && multiBuilder != null) ||
              (!isMultiChoice &&
                  singleOnChange != null &&
                  singleBuilder != null),
          isMultiChoice
              ? 'multiValue, multiOnChange, and multiBuilder must be not null in multiple choice'
              : 'singleValue, singleOnChange, and singleBuilder must be not null in single choice',
        ),
        assert(
          (isMultiChoice && choiceConfig.type != S2ChoiceType.radios) ||
              (!isMultiChoice && choiceConfig.type != S2ChoiceType.checkboxes),
          isMultiChoice
              ? 'multiple choice can\'t use S2ChoiceType.radios'
              : 'Single choice can\'t use S2ChoiceType.checkboxes',
        ),
        assert(
          choiceItems != null || choiceLoader != null,
          '`choiceItems` and `choiceLoader` can\'t be both null',
        ),
        super(key: key);

  /// Constructor for single choice
  ///
  /// The [title] argument is text to display in trigger widget and modal header.
  ///
  /// The [placeholder] argument is text to display when there is no selected choice.
  ///
  /// The [selectedValue] argument is current selected value.
  ///
  /// The [selectedChoice] argument is current selected choice.
  ///
  /// The [selectedResolver] is function to resolve [selectedChoice] from [selectedValue]
  ///
  /// The [onChange] called when value changed.
  ///
  /// The [onSelect] called when selection has been made.
  ///
  /// The [onModalOpen] called when modal opened.
  ///
  /// The [onModalClose] called when modal closed.
  ///
  /// The [onModalWillOpen] called when will modal open.
  ///
  /// The [onModalWillClose] called when will modal close.
  ///
  /// The [validation] is function to validate the selected.
  ///
  /// The [modalValidation] is function to validate the choice selection in the modal.
  ///
  /// The [choiceItems] is [List] of [S2Choice] item to generate the choices.
  ///
  /// The [choiceLoader] is function to load the choice items.
  ///
  /// The [builder] is collection of builder for single choice widget.
  ///
  /// The [tileBuilder] is shortcut to [builder.tile],
  /// a widget builder to customize tile widget.
  ///
  /// The [modalBuilder] is shortcut to [builder.modal],
  /// a widget builder to customize modal widget.
  ///
  /// The [modalHeaderBuilder] is shortcut to [builder.modalHeader],
  /// a widget builder to customize modal header widget.
  ///
  /// The [modalActionsBuilder] is shortcut to [builder.modalActions],
  /// a widget builder to customize modal actions widget.
  ///
  /// The [modalConfirmBuilder] is shortcut to [builder.modalConfirm],
  /// a widget builder to customize modal confirm action widget.
  ///
  /// The [modalDividerBuilder] is shortcut to [builder.modalDivider],
  /// a widget builder to customize divider widget between header, body, and footer modal.
  ///
  /// The [modalFooterBuilder] is shortcut to [builder.modalFooter],
  /// a widget builder to customize footer widget.
  ///
  /// The [modalFilterBuilder] is shortcut to [builder.modalFilter],
  /// a widget builder to customize filter widget.
  ///
  /// The [modalFilterToggleBuilder] is shortcut to [builder.modalFilterToggle],
  /// a widget builder to customize filter toggle widget.
  ///
  /// The [choiceBuilder] is shortcut to [builder.choice],
  /// a widget builder to customize each choice item widget.
  ///
  /// The [choiceTitleBuilder] is shortcut to [builder.choiceTitle],
  /// a widget builder to customize each choice item title widget.
  ///
  /// The [choiceSubtitleBuilder] is shortcut to [builder.choiceSubtitle],
  /// a widget builder to customize choice item subtitle widget.
  ///
  /// The [choiceSecondaryBuilder] is shortcut to [builder.choiceSecondary],
  /// a widget builder to customize choice item secondary widget.
  ///
  /// The [choiceDividerBuilder] is shortcut to [builder.choiceDivider],
  /// a widget builder to customize divider widget between choices item.
  ///
  /// The [choiceEmptyBuilder] is shortcut to [builder.choiceEmpty],
  /// a widget builder to customize empty display widget.
  ///
  /// The [choiceGroupBuilder] is shortcut to [builder.choiceGroup],
  /// a widget builder to customize choices group widget.
  ///
  /// The [choiceHeaderBuilder] is shortcut to [builder.choiceHeader],
  /// a widget builder to customize header widget on grouped choices.
  ///
  /// The [choiceConfig] is a configuration to customize choice widget.
  ///
  /// The [choiceStyle] is shortcut to [choiceConfig.style],
  /// a configuration for styling unselected choice widget.
  ///
  /// The [choiceActiveStyle] is shortcut to [choiceConfig.activeStyle],
  /// a configuration for styling selected choice widget.
  ///
  /// The [choiceHeaderStyle] is shortcut to [choiceConfig.headerStyle],
  /// a configuration for styling header widget of grouped choices.
  ///
  /// The [choiceType] is shortcut to [choiceConfig.type],
  /// widget type to display the choice items.
  ///
  /// The [choiceLayout] is shortcut to [choiceConfig.layout],
  /// layout to display the choice items.
  ///
  /// The [choiceDirection] is shortcut to [choiceConfig.direction],
  /// scroll direction of the choice items,
  /// currently only support when [choiceLayout] or [choiceConfig.layout] is [S2ChoiceLayout.wrap].
  ///
  /// The [choiceGrouped] is shortcut to [groupConfig.enabled],
  /// whether the choice items is grouped or not, based on [S2Choice.group] value.
  ///
  /// The [choiceDivider] is shortcut to [choiceConfig.useDivider],
  /// whether the choice items use divider or not.
  ///
  /// The [choiceGrid] is shortcut to [choiceConfig.gridDelegate],
  /// if [choiceLayout] is [S2ChoiceLayout.grid],
  /// a delegate that controls the layout of the children within the [GridView].
  ///
  /// The [choiceGridCount] is shortcut to [choiceConfig.gridCount],
  /// if [choiceLayout] is [S2ChoiceLayout.grid],
  /// the number of children in the cross axis, and ignored if [choiceGrid] is defined,
  ///
  /// The [choiceGridSpacing] is shortcut to [choiceConfig.gridSpacing],
  /// if [choiceLayout] is [S2ChoiceLayout.grid],
  /// fill the [crossAxisSpacing] and [crossAxisSpacing] with single configuration,
  /// and ignored if [choiceGrid] is defined.
  ///
  /// The [choicePageLimit] is shortcut to [choiceConfig.pageLimit],
  /// limit per page to display the choices, defaults to `null`, it means disabled the paging.
  ///
  /// The [choiceDelay] is shortcut to [choiceConfig.delay],
  /// time delay before display the choices.
  ///
  /// The [groupConfig] is a configuration to customize grouped widget.
  ///
  /// The [groupEnabled] is shortcut to [groupConfig.enabled], alterative to [choiceGrouped],
  /// whether the choices list is grouped or not, based on [S2Choice.group].
  ///
  /// The [groupSelector] is shortcut to [groupConfig.useSelector],
  /// if [groupEnabled] is `true`, whether the group header displays the choices selector toggle or not.
  ///
  /// The [groupCounter] is shortcut to [groupConfig.useCounter],
  /// if [groupEnabled] is `true`, whether the group header displays the choices counter or not.
  ///
  /// The [groupSortBy] is shortcut to [groupConfig.sortBy],
  /// if [groupEnabled] is `true`, comparator function to sort the group keys,
  /// and defaults to `null` to disabled the sorting.
  ///
  /// The [groupHeaderStyle] is shortcut to [groupConfig.headerStyle],
  /// if [groupEnabled] is `true`, configure choices group header theme.
  ///
  /// Then [modalConfig] is configuration to customize behavior of the choices modal.
  ///
  /// The [modalStyle] is shortcut to [modalConfig.style],
  /// a configuration for styling modal widget.
  ///
  /// The [modalHeaderStyle] is shortcut to [modalConfig.headerStyle],
  /// a configuration for styling header of the modal widget.
  ///
  /// The [modalType] is shortcut to [modalConfig.type],
  /// modal type to display the choice items.
  ///
  /// The [modalTitle] is shortcut to [modalConfig.title],
  /// used to override [title] in the modal widget.
  ///
  /// The [modalConfirm] is shortcut to [modalConfig.useConfirm],
  /// Whether the modal need to confirm before returning the changed value.
  ///
  /// The [modalHeader] is shortcut to [modalConfig.useHeader],
  /// Whether the modal use header or not.
  ///
  /// The [modalFilter] is shortcut to [modalConfig.useFilter],
  /// Whether the choice items in the modal is filterable or not.
  ///
  /// The [modalFilterAuto] shortcut to [modalConfig.filterAuto],
  /// Whether the filter is autocomplete or need to confirm with filter button.
  ///
  /// The [modalFilterHint] is shortcut to [modalConfig.filterHint],
  /// [String] to display as hint in searchbar.
  factory SmartSelect.single({
    Key? key,
    String? title,
    String placeholder = 'Select one',
    required T selectedValue,
    S2Choice<T>? selectedChoice,
    S2SingleSelectedResolver<T>? selectedResolver,
    ValueChanged<S2SingleSelected<T>>? onChange,
    S2ChoiceSelect<S2SingleState<T>, S2Choice<T>>? onSelect,
    S2ModalOpen<S2SingleState<T>>? onModalOpen,
    S2ModalClose<S2SingleState<T>>? onModalClose,
    S2ModalWillOpen<S2SingleState<T>>? onModalWillOpen,
    S2ModalWillClose<S2SingleState<T>>? onModalWillClose,
    S2Validation<S2SingleChosen<T>>? validation,
    S2Validation<S2SingleChosen<T>>? modalValidation,
    List<S2Choice<T>>? choiceItems,
    S2ChoiceLoader<T>? choiceLoader,
    S2SingleBuilder<T>? builder,
    S2WidgetBuilder<S2SingleState<T>>? tileBuilder,
    S2WidgetBuilder<S2SingleState<T>>? modalBuilder,
    S2WidgetBuilder<S2SingleState<T>>? modalHeaderBuilder,
    S2ListWidgetBuilder<S2SingleState<T>>? modalActionsBuilder,
    S2WidgetBuilder<S2SingleState<T>>? modalConfirmBuilder,
    S2WidgetBuilder<S2SingleState<T>>? modalDividerBuilder,
    S2WidgetBuilder<S2SingleState<T>>? modalFooterBuilder,
    S2WidgetBuilder<S2SingleState<T>>? modalFilterBuilder,
    S2WidgetBuilder<S2SingleState<T>>? modalFilterToggleBuilder,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>>? choiceBuilder,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>>? choiceTitleBuilder,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>>?
        choiceSubtitleBuilder,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>>?
        choiceSecondaryBuilder,
    IndexedWidgetBuilder? choiceDividerBuilder,
    S2WidgetBuilder<S2SingleState<T>>? choiceEmptyBuilder,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Group<T>>? groupBuilder,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Group<T>>? groupHeaderBuilder,
    S2ChoiceConfig? choiceConfig,
    S2ChoiceStyle? choiceStyle,
    S2ChoiceStyle? choiceActiveStyle,
    S2ChoiceType? choiceType,
    S2ChoiceLayout? choiceLayout,
    Axis? choiceDirection,
    bool? choiceGrouped,
    bool? choiceDivider,
    SliverGridDelegate? choiceGrid,
    int? choiceGridCount,
    double? choiceGridSpacing,
    int? choicePageLimit,
    Duration? choiceDelay,
    S2GroupConfig? groupConfig,
    bool? groupEnabled,
    bool? groupSelector,
    bool? groupCounter,
    S2GroupSort? groupSortBy,
    S2GroupHeaderStyle? groupHeaderStyle,
    S2ModalConfig? modalConfig,
    S2ModalStyle? modalStyle,
    S2ModalHeaderStyle? modalHeaderStyle,
    S2ModalType? modalType,
    String? modalTitle,
    bool? modalConfirm,
    bool? modalHeader,
    bool? modalFilter,
    bool? modalFilterAuto,
    String? modalFilterHint,
  }) {
    S2ChoiceConfig defaultChoiceConfig = const S2ChoiceConfig(
      type: S2ChoiceType.radios,
    );
    S2GroupConfig defaultGroupConfig = const S2GroupConfig();
    S2ModalConfig defaultModalConfig = const S2ModalConfig();
    return SmartSelect<T>(
      key: key,
      title: title,
      placeholder: placeholder,
      choiceItems: choiceItems,
      choiceLoader: choiceLoader,
      isMultiChoice: false,
      singleSelected: S2SingleSelected<T>(
        value: selectedValue,
        choice: selectedChoice,
        resolver: selectedResolver,
        validation: validation,
        placeholder: placeholder,
      ),
      singleOnChange: onChange,
      singleOnSelect: onSelect,
      singleOnModalOpen: onModalOpen,
      singleOnModalClose: onModalClose,
      singleOnModalWillOpen: onModalWillOpen,
      singleOnModalWillClose: onModalWillClose,
      singleValidation: validation,
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
            gridCount: choiceGridCount,
            gridSpacing: choiceGridSpacing,
            useDivider: choiceDivider,
            style: choiceStyle,
            activeStyle: choiceActiveStyle,
            pageLimit: choicePageLimit,
            delay: choiceDelay,
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
  /// The [title] argument is text to display in trigger widget and modal header.
  ///
  /// The [placeholder] argument is text to display when there is no selected choice.
  ///
  /// The [selectedValue] argument is current selected value.
  ///
  /// The [selectedChoice] argument is current selected choice.
  ///
  /// The [selectedResolver] is function to resolve [selectedChoice] from [selectedValue]
  ///
  /// The [onChange] called when value changed.
  ///
  /// The [onSelect] called when selection has been made.
  ///
  /// The [onModalOpen] called when modal opened.
  ///
  /// The [onModalClose] called when modal closed.
  ///
  /// The [onModalWillOpen] called when modal will open.
  ///
  /// The [onModalWillClose] called when modal will close.
  ///
  /// The [validation] is function to validate the selected.
  ///
  /// The [modalValidation] is function to validate the choice selection in the modal.
  ///
  /// The [choiceItems] is [List] of [S2Choice] item to generate the choices.
  ///
  /// The [choiceLoader] is function to load the choice items.
  ///
  /// The [builder] is collection of builder for single choice widget.
  ///
  /// The [tileBuilder] is shortcut to [builder.tile],
  /// a widget builder to customize tile widget.
  ///
  /// The [modalBuilder] is shortcut to [builder.modal],
  /// a widget builder to customize modal widget.
  ///
  /// The [modalHeaderBuilder] is shortcut to [builder.modalHeader],
  /// a widget builder to customize modal header widget.
  ///
  /// The [modalActionsBuilder] is shortcut to [builder.modalActions],
  /// a widget builder to customize modal actions widget.
  ///
  /// The [modalConfirmBuilder] is shortcut to [builder.modalConfirm],
  /// a widget builder to customize modal confirm action widget.
  ///
  /// The [modalDividerBuilder] is shortcut to [builder.modalDivider],
  /// a widget builder to customize divider widget between header, body, and footer modal.
  ///
  /// The [modalFooterBuilder] is shortcut to [builder.modalFooter],
  /// a widget builder to customize footer widget.
  ///
  /// The [modalFilterBuilder] is shortcut to [builder.modalFilter],
  /// a widget builder to customize filter widget.
  ///
  /// The [modalFilterToggleBuilder] is shortcut to [builder.modalFilterToggle],
  /// a widget builder to customize filter toggle widget.
  ///
  /// The [choiceBuilder] is shortcut to [builder.choice],
  /// a widget builder to customize each choice item widget.
  ///
  /// The [choiceTitleBuilder] is shortcut to [builder.choiceTitle],
  /// a widget builder to customize each choice item title widget.
  ///
  /// The [choiceSubtitleBuilder] is shortcut to [builder.choiceSubtitle],
  /// a widget builder to customize choice item subtitle widget.
  ///
  /// The [choiceSecondaryBuilder] is shortcut to [builder.choiceSecondary],
  /// a widget builder to customize choice item secondary widget.
  ///
  /// The [choiceDividerBuilder] is shortcut to [builder.choiceDivider],
  /// a widget builder to customize divider widget between choices item.
  ///
  /// The [choiceEmptyBuilder] is shortcut to [builder.choiceEmpty],
  /// a widget builder to customize empty display widget.
  ///
  /// The [choiceGroupBuilder] is shortcut to [builder.choiceGroup],
  /// a widget builder to customize choices group widget.
  ///
  /// The [choiceHeaderBuilder] is shortcut to [builder.choiceHeader],
  /// a widget builder to customize header widget on grouped choices.
  ///
  /// The [choiceConfig] is a configuration to customize choice widget.
  ///
  /// The [choiceStyle] is shortcut to [choiceConfig.style],
  /// a configuration for styling unselected choice widget.
  ///
  /// The [choiceActiveStyle] is shortcut to [choiceConfig.activeStyle],
  /// a configuration for styling selected choice widget.
  ///
  /// The [choiceHeaderStyle] is shortcut to [choiceConfig.headerStyle],
  /// a configuration for styling header widget of grouped choices.
  ///
  /// The [choiceType] is shortcut to [choiceConfig.type],
  /// widget type to display the choice items.
  ///
  /// The [choiceLayout] is shortcut to [choiceConfig.layout],
  /// layout to display the choice items.
  ///
  /// The [choiceDirection] is shortcut to [choiceConfig.direction],
  /// scroll direction of the choice items,
  /// currently only support when [choiceLayout] or [choiceConfig.layout] is [S2ChoiceLayout.wrap].
  ///
  /// The [choiceGrouped] is shortcut to [groupConfig.enabled],
  /// whether the choice items is grouped or not, based on [S2Choice.group] value.
  ///
  /// The [choiceDivider] is shortcut to [choiceConfig.useDivider],
  /// whether the choice items use divider or not.
  ///
  /// The [choiceGrid] is shortcut to [choiceConfig.gridDelegate],
  /// if [choiceLayout] is [S2ChoiceLayout.grid],
  /// a delegate that controls the layout of the children within the [GridView].
  ///
  /// The [choiceGridCount] is shortcut to [choiceConfig.gridCount],
  /// if [choiceLayout] is [S2ChoiceLayout.grid],
  /// the number of children in the cross axis, and ignored if [choiceGrid] is defined,
  ///
  /// The [choiceGridSpacing] is shortcut to [choiceConfig.gridSpacing],
  /// if [choiceLayout] is [S2ChoiceLayout.grid],
  /// fill the [crossAxisSpacing] and [crossAxisSpacing] with single configuration,
  /// and ignored if [choiceGrid] is defined.
  ///
  /// The [choicePageLimit] is shortcut to [choiceConfig.pageLimit],
  /// limit per page to display the choices, defaults to `null`, it means disabled the paging.
  ///
  /// The [choiceDelay] is shortcut to [choiceConfig.delay],
  /// time delay before display the choices.
  ///
  /// The [groupConfig] is a configuration to customize grouped widget.
  ///
  /// The [groupEnabled] is shortcut to [groupConfig.enabled], alterative to [choiceGrouped],
  /// whether the choices list is grouped or not, based on [S2Choice.group].
  ///
  /// The [groupSelector] is shortcut to [groupConfig.useSelector],
  /// if [groupEnabled] is `true`, whether the group header displays the choices selector toggle or not.
  ///
  /// The [groupCounter] is shortcut to [groupConfig.useCounter],
  /// if [groupEnabled] is `true`, whether the group header displays the choices counter or not.
  ///
  /// The [groupSortBy] is shortcut to [groupConfig.sortBy],
  /// if [groupEnabled] is `true`, comparator function to sort the group keys,
  /// and defaults to `null` to disabled the sorting.
  ///
  /// The [groupHeaderStyle] is shortcut to [groupConfig.headerStyle],
  /// if [groupEnabled] is `true`, configure choices group header theme.
  ///
  /// Then [modalConfig] is configuration to customize behavior of the choices modal.
  ///
  /// The [modalStyle] is shortcut to [modalConfig.style],
  /// a configuration for styling modal widget.
  ///
  /// The [modalHeaderStyle] is shortcut to [modalConfig.headerStyle],
  /// a configuration for styling header of the modal widget.
  ///
  /// The [modalType] is shortcut to [modalConfig.type],
  /// modal type to display the choice items.
  ///
  /// The [modalTitle] is shortcut to [modalConfig.title],
  /// used to override [title] in the modal widget.
  ///
  /// The [modalConfirm] is shortcut to [modalConfig.useConfirm],
  /// Whether the modal need to confirm before returning the changed value.
  ///
  /// The [modalHeader] is shortcut to [modalConfig.useHeader],
  /// Whether the modal use header or not.
  ///
  /// The [modalFilter] is shortcut to [modalConfig.useFilter],
  /// Whether the choice items in the modal is filterable or not.
  ///
  /// The [modalFilterAuto] shortcut to [modalConfig.filterAuto],
  /// Whether the filter is autocomplete or need to confirm with filter button.
  ///
  /// The [modalFilterHint] is shortcut to [modalConfig.filterHint],
  /// [String] to display as hint in searchbar.
  factory SmartSelect.multiple({
    Key? key,
    String? title,
    String placeholder = 'Select one or more',
    List<T> selectedValue = const [],
    List<S2Choice<T>>? selectedChoice,
    S2MultiSelectedResolver<T>? selectedResolver,
    ValueChanged<S2MultiSelected<T>>? onChange,
    S2ChoiceSelect<S2MultiState<T>, S2Choice<T>>? onSelect,
    S2ModalOpen<S2MultiState<T>>? onModalOpen,
    S2ModalClose<S2MultiState<T>>? onModalClose,
    S2ModalWillOpen<S2MultiState<T>>? onModalWillOpen,
    S2ModalWillClose<S2MultiState<T>>? onModalWillClose,
    S2Validation<S2MultiChosen<T>>? validation,
    S2Validation<S2MultiChosen<T>>? modalValidation,
    List<S2Choice<T>>? choiceItems,
    S2ChoiceLoader<T>? choiceLoader,
    S2MultiBuilder<T>? builder,
    S2WidgetBuilder<S2MultiState<T>>? tileBuilder,
    S2WidgetBuilder<S2MultiState<T>>? modalBuilder,
    S2WidgetBuilder<S2MultiState<T>>? modalHeaderBuilder,
    S2ListWidgetBuilder<S2MultiState<T>>? modalActionsBuilder,
    S2WidgetBuilder<S2MultiState<T>>? modalConfirmBuilder,
    S2WidgetBuilder<S2MultiState<T>>? modalDividerBuilder,
    S2WidgetBuilder<S2MultiState<T>>? modalFooterBuilder,
    S2WidgetBuilder<S2MultiState<T>>? modalFilterBuilder,
    S2WidgetBuilder<S2MultiState<T>>? modalFilterToggleBuilder,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>>? choiceBuilder,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>>? choiceTitleBuilder,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>>? choiceSubtitleBuilder,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>>?
        choiceSecondaryBuilder,
    IndexedWidgetBuilder? choiceDividerBuilder,
    S2WidgetBuilder<S2MultiState<T>>? choiceEmptyBuilder,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Group<T>>? groupBuilder,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Group<T>>? groupHeaderBuilder,
    S2ChoiceConfig? choiceConfig,
    S2ChoiceStyle? choiceStyle,
    S2ChoiceStyle? choiceActiveStyle,
    S2ChoiceType? choiceType,
    S2ChoiceLayout? choiceLayout,
    Axis? choiceDirection,
    bool? choiceGrouped,
    bool? choiceDivider,
    SliverGridDelegate? choiceGrid,
    int? choiceGridCount,
    double? choiceGridSpacing,
    int? choicePageLimit,
    Duration? choiceDelay,
    S2GroupConfig? groupConfig,
    bool? groupEnabled,
    bool? groupSelector,
    bool? groupCounter,
    S2GroupSort? groupSortBy,
    S2GroupHeaderStyle? groupHeaderStyle,
    S2ModalConfig? modalConfig,
    S2ModalStyle? modalStyle,
    S2ModalHeaderStyle? modalHeaderStyle,
    S2ModalType? modalType,
    String? modalTitle,
    bool? modalConfirm,
    bool? modalHeader,
    bool? modalFilter,
    bool? modalFilterAuto,
    String? modalFilterHint,
  }) {
    S2ChoiceConfig defaultChoiceConfig = const S2ChoiceConfig(
      type: S2ChoiceType.checkboxes,
    );
    S2ModalConfig defaultModalConfig = const S2ModalConfig();
    S2GroupConfig defaultGroupConfig = const S2GroupConfig();
    return SmartSelect<T>(
      key: key,
      title: title,
      placeholder: placeholder,
      choiceItems: choiceItems,
      choiceLoader: choiceLoader,
      isMultiChoice: true,
      multiSelected: S2MultiSelected<T>(
        value: selectedValue,
        choice: selectedChoice,
        resolver: selectedResolver,
        validation: validation,
        placeholder: placeholder,
      ),
      multiOnChange: onChange,
      multiOnSelect: onSelect,
      multiOnModalOpen: onModalOpen,
      multiOnModalClose: onModalClose,
      multiOnModalWillOpen: onModalWillOpen,
      multiOnModalWillClose: onModalWillClose,
      multiValidation: validation,
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
            gridCount: choiceGridCount,
            gridSpacing: choiceGridSpacing,
            useDivider: choiceDivider,
            style: choiceStyle,
            activeStyle: choiceActiveStyle,
            pageLimit: choicePageLimit,
            delay: choiceDelay,
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
    return isMultiChoice ? S2MultiState<T>() : S2SingleState<T>();
  }
}

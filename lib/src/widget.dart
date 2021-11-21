import 'dart:ui';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'model/builder.dart';
import 'model/modal_theme.dart';
import 'model/modal_config.dart';
import 'model/choice_theme.dart';
import 'model/choice_config.dart';
import 'model/choice_item.dart';
import 'model/choice_loader.dart';
import 'model/group_data.dart';
import 'model/group_config.dart';
import 'model/group_style.dart';
import 'model/group_sort.dart';
import 'model/chosen.dart';
import 'state/choices.dart';
import 'state/filter.dart';
// import 'state/selected.dart';
// import 'state/selection.dart';
import 'choices_resolver.dart';
import 'tile/tile.dart';
import 'utils/debouncer.dart';
import 'group_header.dart';
import 'choices_list.dart';
import 'choices_empty.dart';
import 'modal.dart';
import 'pagination.dart';
import 'text.dart';
import 'text_error.dart';

/// Callback for event modal will close
typedef Future<bool> S2ModalWillClose<T>(T state);

/// Callback for event modal will open
typedef Future<bool> S2ModalWillOpen<T>(T state);

/// Callback for event modal opened
typedef void S2ModalOpen<T>(T state);

/// Callback for event modal closed
typedef void S2ModalClose<T>(T state, bool confirmed);

/// Callback for event choice select
typedef void S2ChoiceSelect<A, B>(A state, B choice);

// /// Signature for callbacks that report that an underlying two value has changed.
// typedef void TwoValueChanged<A, B>(A firstValue, B secondValue);

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
  final ValueChanged<S2SingleSelected<T?>>? singleOnChange;

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
  final ValueChanged<S2MultiSelected<T>?>? multiOnChange;

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
    ValueChanged<S2SingleSelected<T?>>? onChange,
    S2ChoiceSelect<S2SingleState<T>, S2Choice<T>>? onSelect,
    S2ModalOpen<S2SingleState<T>>? onModalOpen,
    S2ModalClose<S2SingleState<T>>? onModalClose,
    S2ModalWillOpen<S2SingleState<T>>? onModalWillOpen,
    S2ModalWillClose<S2SingleState<T>>? onModalWillClose,
    S2Validation<S2SingleChosen<T?>>? validation,
    S2Validation<S2SingleChosen<T>>? modalValidation,
    List<S2Choice<T>>? choiceItems,
    S2ChoiceLoader<T>? choiceLoader,
    S2SingleBuilder<T>? builder,
    S2WidgetBuilder<S2SingleState<T?>>? tileBuilder,
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
    List<T>? selectedValue,
    List<S2Choice<T>>? selectedChoice,
    S2MultiSelectedResolver<T>? selectedResolver,
    ValueChanged<S2MultiSelected<T>?>? onChange,
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
    S2WidgetBuilder<S2MultiState<T?>>? tileBuilder,
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

/// Smart Select State
abstract class S2State<T> extends State<SmartSelect<T>> {
  /// State of the selected choice(s)
  covariant S2Selected<T>? selected;

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
    selection?.removeListener(_selectionHandler);
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
  void _selectionHandler() => modalSetState?.call(() {});

  /// The [selected] listener handler
  void _selectedHandler() => setState.call(() {});

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
        errorStyle: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w500,
          color: widget.modalConfig.isFullPage == true
              ? (theme.primaryColorBrightness == Brightness.dark
                  ? Colors.white
                  : theme.errorColor)
              : theme.errorColor,
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
          child: _customModal ?? defaultModal,
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
                child: modalHeader!,
                preferredSize: Size.fromHeight(kToolbarHeight),
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
  Widget? get _customModal;

  /// Returns the modal body widget
  Widget get modalBody {
    final _modalHeader = modalHeader;
    final _modalDivider = modalDivider;
    final _modalFooter = modalFooter;

    final _widgets = <Widget>[];
    if (!modalConfig.isFullPage && _modalHeader != null) {
      _widgets.add(_modalHeader);
    }
    if (_modalDivider != null) {
      _widgets.add(_modalDivider);
    }
    _widgets.add(
      Flexible(
        fit: modalConfig.isFullPage == true ? FlexFit.tight : FlexFit.loose,
        child: choiceList,
      ),
    );
    if (_modalDivider != null) {
      _widgets.add(_modalDivider);
    }
    if (_modalFooter != null) {
      _widgets.add(_modalFooter);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: _widgets,
    );
  }

  /// Returns the modal divider widget
  Widget? get modalDivider;

  /// Returns the modal footer widget
  Widget? get modalFooter;

  /// Returns the modal title widget
  Widget get modalTitle {
    String _title = modalConfig.title ?? widget.title ?? widget.placeholder!;
    return Container(child: Text(_title, style: modalHeaderStyle.textStyle));
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
    return _customModalFilter ?? defaultModalFilter;
  }

  /// Returns the custom modal filter widget
  Widget? get _customModalFilter;

  /// Returns the default modal filter widget
  Widget get defaultModalFilter {
    return TextField(
      autofocus: true,
      controller: filter!.ctrl,
      style: modalHeaderStyle.textStyle,
      cursorColor: modalConfig.isFullPage ? Colors.white : theme.cursorColor,
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
        ? _customModalFilterToggle ?? defaultModalFilterToggle
        : null;
  }

  /// Returns the custom widget to show/hide modal filter
  Widget? get _customModalFilterToggle;

  /// Returns the default widget to show/hide modal filter
  Widget get defaultModalFilterToggle {
    return !filter!.activated
        ? IconButton(
            icon: Icon(Icons.search),
            onPressed: () => filter!.show(modalContext),
          )
        : IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => filter!.hide(modalContext),
          );
  }

  /// Returns the confirm button widget
  Widget get confirmButton {
    return _customConfirmButton ?? defaultConfirmButton;
  }

  /// Returns the custom confirm button widget
  Widget? get _customConfirmButton;

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
            child: FlatButton.icon(
              icon: modalConfig.confirmIcon!,
              label: modalConfig.confirmLabel!,
              color:
                  modalConfig.confirmIsDark ? modalConfig.confirmColor : null,
              textColor: modalConfig.confirmIsLight
                  ? modalConfig.confirmColor
                  : Colors.white,
              onPressed: onPressed,
            ),
          ),
        );
      } else {
        return Center(
          child: Padding(
            padding: modalConfig.confirmMargin ??
                const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: FlatButton(
              child: modalConfig.confirmLabel!,
              color: modalConfig.confirmIsDark
                  ? modalConfig.confirmColor ?? Colors.blueGrey
                  : null,
              textColor: modalConfig.confirmIsLight
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
        ? _customModalHeader ?? defaultModalHeader
        : null;
  }

  /// Returns the custom modal header
  Widget? get _customModalHeader;

  /// Returns the default modal header widget
  Widget get defaultModalHeader {
    final bool isFiltering = filter?.activated == true;
    return AppBar(
      primary: true,
      shape: modalHeaderStyle.shape,
      elevation: modalHeaderStyle.elevation,
      brightness: modalHeaderStyle.brightness,
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
    return (_customModalActions ?? defaultModalActions);
  }

  /// Returns the custom modal actions widgets
  List<Widget>? get _customModalActions;

  /// Returns the default modal actions widgets
  List<Widget> get defaultModalActions {
    final _actions = <Widget>[];
    if (modalFilterToggle != null) {
      _actions.add(modalFilterToggle!);
    }
    if (modalConfig.useConfirm && !filter!.activated) {
      _actions.add(confirmButton);
    }
    return _actions;
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
                      child: ungroupedChoices(choices!.items),
                      reloadable: choices!.isAsync,
                      appendable: choiceConfig.pageLimit != null,
                      onReload: () => choices!.reload(query: filter?.value),
                      onAppend: () => choices!.append(query: filter?.value),
                    );
                  },
                ),
              )
            : choiceEmpty;
  }

  /// Returns the ungrouped choice items widget
  Widget ungroupedChoices(List<S2Choice<T>>? _choices) {
    return S2ChoicesList<T>(
      itemLength:
          choices!.isAppending ? _choices!.length + 1 : _choices!.length,
      itemBuilder: (context, i) {
        return choices!.isAppending && i == _choices.length
            ? Container(
                child: const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : choiceListBuilder(_choices[i])!;
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
          return _customGroup(groups[i]) ?? defaultGroup(groups[i]);
        },
      ),
    );
  }

  /// Returns the default grouped choices widget
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

  /// Returns the custom grouped choices widget
  Widget? _customGroup(S2Group<T> group) {
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
    return _customGroupHeader(group) ?? defaultGroupHeader(group);
  }

  /// Returns the custom group header widget
  Widget? _customGroupHeader(S2Group<T> group);

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
      child: Center(
        child: const SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  /// Returns the choice empty widget
  Widget get choiceEmpty {
    return _customChoiceEmpty ?? defaultChoiceEmpty;
  }

  /// Returns the custom empty choice widget
  Widget? get _customChoiceEmpty;

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
                MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
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
    if (confirmed == true)
      // will call the onWillPop
      Navigator.maybePop(context, true);
    else
      // no need to call the onWillPop
      Navigator.pop(context, false);
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

    // reset the initial choices
    if (oldWidget.choiceItems != widget.choiceItems) resolveChoices();
  }

  @override
  void dispose() {
    // dispose everything
    choices?.removeListener(_choicesHandler);
    selected?.removeListener(_selectedHandler);
    choices?.dispose();
    selected?.dispose();
    super.dispose();
  }
}

/// State for Single Choice
class S2SingleState<T> extends S2State<T> {
  /// State of the selected choice(s)
  @override
  S2SingleSelected<T>? selected;

  /// State of choice(s) selection in the modal
  @override
  S2SingleSelection<T>? selection;

  @override
  void onChange() {
    // set cache to final value
    // setState(() => selected = selected.copyWith(choice: selection.choice));
    selected!.choice = selection!.choice;
    widget.singleOnChange?.call(selected!);
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
  S2SingleBuilder<T?>? get builder {
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
    selected?.dispose();
    if (widget.singleSelected != null) {
      selected = widget.singleSelected!
        ..addListener(_selectedHandler)
        ..resolve(defaultResolver: (value) async {
          return widget.choiceItems?.firstWhereOrNull(
            (item) => item.value == value,
          );
        });
    }
  }

  @override
  void resolveSelection() async {
    // set the initial selection
    selection = S2SingleSelection<T>(
      initial: selected!.choice,
      validation: modalValidation,
    )
      ..addListener(_selectionHandler)
      ..validate();
  }

  @override
  void didUpdateWidget(SmartSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // reset the initial value
    // if (oldWidget.singleSelected != widget.singleSelected) resolveSelected();
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

  @override
  Widget? get _customModal {
    return builder?.modal?.call(modalContext, this);
  }

  @override
  Widget? get _customModalFilter {
    return builder?.modalFilter?.call(modalContext, this);
  }

  @override
  Widget? get _customModalFilterToggle {
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
  Widget? get _customModalHeader {
    return builder?.modalHeader?.call(modalContext, this);
  }

  @override
  List<Widget>? get _customModalActions {
    return builder?.modalActions?.call(modalContext, this);
  }

  @override
  Widget? get _customConfirmButton {
    return builder?.modalConfirm?.call(modalContext, this);
  }

  @override
  Widget? get _customChoiceEmpty {
    return builder!.choiceEmpty?.call(modalContext, this);
  }

  @override
  Widget? _customGroup(S2Group<T?> group) {
    return builder!.group?.call(modalContext, this, group);
  }

  @override
  Widget? _customGroupHeader(S2Group<T?> group) {
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
  Widget? choiceSecondary(S2Choice<T?> choice) {
    return builder?.choiceSecondary?.call(modalContext, this, choice);
  }

  @override
  Widget? get choiceSelectorAll => null;

  @override
  Widget? choiceSelector(List<S2Choice<T?>>? values) => null;
}

/// State for Multiple Choice
class S2MultiState<T> extends S2State<T> {
  /// State of the selected choice(s)
  @override
  S2MultiSelected<T>? selected;

  /// State of choice(s) selection in the modal
  @override
  S2MultiSelection<T>? selection;

  @override
  void onChange() {
    // set cache to final value
    // setState(() => selected = selected.copyWith(choice: selection.choice));
    selected?.choice = selection?.choice;
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
    selected?.dispose();
    if (widget.multiSelected != null) {
      selected = widget.multiSelected!
        ..addListener(_selectedHandler)
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
      initial: selected?.choice,
      validation: modalValidation,
    )
      ..addListener(_selectionHandler)
      ..validate();
  }

  @override
  void didUpdateWidget(SmartSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // reset the initial value
    // if (oldWidget.multiSelected != widget.multiSelected) resolveSelected();
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

  @override
  Widget? get _customModal {
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
  Widget? get _customModalHeader {
    return builder?.modalHeader?.call(modalContext, this);
  }

  @override
  Widget? get _customModalFilter {
    return builder?.modalFilter?.call(modalContext, this);
  }

  @override
  Widget? get _customModalFilterToggle {
    return builder?.modalFilterToggle?.call(modalContext, this);
  }

  @override
  List<Widget>? get _customModalActions {
    return builder?.modalActions?.call(modalContext, this);
  }

  @override
  Widget? get _customConfirmButton {
    return builder?.modalConfirm?.call(modalContext, this);
  }

  @override
  Widget? get _customChoiceEmpty {
    return builder!.choiceEmpty?.call(modalContext, this);
  }

  @override
  Widget? _customGroup(S2Group<T> group) {
    return builder!.group?.call(modalContext, this, group);
  }

  @override
  Widget? _customGroupHeader(S2Group<T> group) {
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
  Widget choiceSelector(List<S2Choice<T>>? choices) {
    return Checkbox(
      activeColor: choiceActiveStyle?.color ?? defaultActiveChoiceStyle.color,
      value: selection!.hasAll(choices!)
          ? true
          : selection!.hasAny(choices)
              ? null
              : false,
      tristate: true,
      onChanged: (value) {
        if (value == true) {
          selection!.merge(choices);
        } else {
          selection!.omit(choices);
        }
      },
    );
  }
}

// class S2StateProvider<T> extends InheritedWidget {
//   final T state;

//   S2StateProvider({
//     Key? key,
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

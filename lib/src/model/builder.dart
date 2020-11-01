import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../state/filter.dart';
import '../widget.dart';
import 'choice_item.dart';
import 'choice_group.dart';

/// A common widget builder
typedef Widget S2WidgetBuilder<T>(
  BuildContext context,
  T value,
);

/// A common list of widget builder
typedef List<Widget> S2ListWidgetBuilder<T>(
  BuildContext context,
  T value,
);

/// A complex builder
// typedef Widget S2ComplexWidgetBuilder<A, B>(
//   BuildContext context,
//   A value,
//   B anotherValue,
// );

/// A builder for choice list item widget
typedef Widget S2ChoiceItemBuilder<T>(S2Choice<T> choice);

/// A widget builder for custom each choices item
typedef Widget S2ChoiceBuilder<T>(
  BuildContext context,
  S2Choice<T> choice,
  String searchText,
);

/// A widget builder for custom choices group
typedef Widget S2ChoiceGroupBuilder(
  BuildContext context,
  Widget header,
  Widget choices,
);

/// A widget builder for custom header choices group
typedef Widget S2ChoiceHeaderBuilder(
  BuildContext context,
  S2ChoiceGroup group,
  String searchText,
);

/// collection of builder
@immutable
class S2Builder<T> with Diagnosticable {
  /// Builder for modal filter
  final S2WidgetBuilder<S2Filter> modalFilter;

  /// Builder for modal filter toggle
  final S2WidgetBuilder<S2Filter> modalFilterToggle;

  /// Builder for each custom choices item
  final S2ChoiceBuilder<T> choice;

  /// Builder for each custom choices item subtitle
  final S2ChoiceBuilder<T> choiceTitle;

  /// Builder for each custom choices item subtitle
  final S2ChoiceBuilder<T> choiceSubtitle;

  /// Builder for each custom choices item secondary
  final S2ChoiceBuilder<T> choiceSecondary;

  /// Builder for custom divider widget between choices item
  final IndexedWidgetBuilder choiceDivider;

  /// Builder for custom empty display
  final S2WidgetBuilder<String> choiceEmpty;

  /// A widget builder for custom choices group
  final S2ChoiceGroupBuilder choiceGroup;

  /// A widget builder for custom header choices group
  final S2ChoiceHeaderBuilder choiceHeader;

  // /// Builder for progress indicator on choice load
  // final WidgetBuilder choiceProgressBuilder;

  // /// Builder for progress indicator on choice load
  // final S2ChoiceBuilder<T> choicePagerBuilder;

  /// default constructor
  const S2Builder({
    this.modalFilter,
    this.modalFilterToggle,
    this.choice,
    this.choiceTitle,
    this.choiceSubtitle,
    this.choiceSecondary,
    this.choiceDivider,
    this.choiceEmpty,
    this.choiceGroup,
    this.choiceHeader,
    // this.choiceProgressBuilder,
    // this.choicePagerBuilder,
  });
}

/// Builder collection of single choice widget
class S2SingleBuilder<T> extends S2Builder<T> {

  /// Builder for custom tile widget
  final S2WidgetBuilder<S2SingleState<T>> tile;

  /// Builder for custom modal widget
  final S2WidgetBuilder<S2SingleState<T>> modal;

  /// Builder for custom modal header widget
  final S2WidgetBuilder<S2SingleState<T>> modalHeader;

  /// Builder for custom modal actions widget
  final S2ListWidgetBuilder<S2SingleState<T>> modalActions;

  /// Builder for modal confirm action widget
  final S2WidgetBuilder<S2SingleState<T>> modalConfirm;

  /// Builder for divider widget between header, body, and footer modal
  final S2WidgetBuilder<S2SingleState<T>> modalDivider;

  /// Builder for modal footer widget
  final S2WidgetBuilder<S2SingleState<T>> modalFooter;

  /// default contructor
  const S2SingleBuilder({
    this.tile,
    this.modal,
    this.modalHeader,
    this.modalActions,
    this.modalConfirm,
    this.modalDivider,
    this.modalFooter,
    S2WidgetBuilder<S2Filter> modalFilter,
    S2WidgetBuilder<S2Filter> modalFilterToggle,
    S2ChoiceBuilder<T> choice,
    S2ChoiceBuilder<T> choiceTitle,
    S2ChoiceBuilder<T> choiceSubtitle,
    S2ChoiceBuilder<T> choiceSecondary,
    IndexedWidgetBuilder choiceDivider,
    S2ChoiceGroupBuilder choiceGroup,
    S2ChoiceHeaderBuilder choiceHeader,
    S2WidgetBuilder<String> choiceEmpty,
    // WidgetBuilder choiceProgress,
    // S2ChoiceBuilder<T> choicePager,
  }) : super(
    modalFilter: modalFilter,
    modalFilterToggle: modalFilterToggle,
    choice: choice,
    choiceTitle: choiceTitle,
    choiceSubtitle: choiceSubtitle,
    choiceSecondary: choiceSecondary,
    choiceDivider: choiceDivider,
    choiceGroup: choiceGroup,
    choiceHeader: choiceHeader,
    choiceEmpty: choiceEmpty,
    // choiceProgressBuilder: choiceProgressBuilder,
    // choicePagerBuilder: choicePagerBuilder,
  );

  /// Creates a copy of this [S2SingleBuilder] but with
  /// the given fields replaced with the new values.
  S2SingleBuilder<T> copyWith({
    S2WidgetBuilder<S2SingleState<T>> tile,
    S2WidgetBuilder<S2SingleState<T>> modal,
    S2WidgetBuilder<S2SingleState<T>> modalHeader,
    S2ListWidgetBuilder<S2SingleState<T>> modalActions,
    S2WidgetBuilder<S2SingleState<T>> modalConfirm,
    S2WidgetBuilder<S2SingleState<T>> modalDivider,
    S2WidgetBuilder<S2SingleState<T>> modalFooter,
    S2WidgetBuilder<S2Filter> modalFilter,
    S2WidgetBuilder<S2Filter> modalFilterToggle,
    S2ChoiceBuilder<T> choice,
    S2ChoiceBuilder<T> choiceTitle,
    S2ChoiceBuilder<T> choiceSubtitle,
    S2ChoiceBuilder<T> choiceSecondary,
    IndexedWidgetBuilder choiceDivider,
    S2ChoiceGroupBuilder choiceGroup,
    S2ChoiceHeaderBuilder choiceHeader,
    S2WidgetBuilder<String> choiceEmpty,
    // WidgetBuilder choiceProgress,
    // S2ChoiceBuilder<T> choicePager,
  }) {
    return S2SingleBuilder<T>(
      tile: tile ?? this.tile,
      modal: modal ?? this.modal,
      modalHeader: modalHeader ?? this.modalHeader,
      modalActions: modalActions ?? this.modalActions,
      modalConfirm: modalConfirm ?? this.modalConfirm,
      modalDivider: modalDivider ?? this.modalDivider,
      modalFooter: modalFooter ?? this.modalFooter,
      modalFilter: modalFilter ?? this.modalFilter,
      modalFilterToggle: modalFilterToggle ?? this.modalFilterToggle,
      choice: choice ?? this.choice,
      choiceTitle: choiceTitle ?? this.choiceTitle,
      choiceSubtitle: choiceSubtitle ?? this.choiceSubtitle,
      choiceSecondary: choiceSecondary ?? this.choiceSecondary,
      choiceDivider: choiceDivider ?? this.choiceDivider,
      choiceGroup: choiceGroup ?? this.choiceGroup,
      choiceHeader: choiceHeader ?? this.choiceHeader,
      choiceEmpty: choiceEmpty ?? this.choiceEmpty,
      // choiceProgressBuilder: choiceProgressBuilder ?? this.choiceProgressBuilder,
      // choicePagerBuilder: choicePagerBuilder ?? this.choicePagerBuilder,
    );
  }

  /// Creates a copy of this [S2SingleBuilder] but with
  /// the given fields replaced with the new values.
  S2SingleBuilder<T> merge(S2SingleBuilder<T> other) {
    // if null return current object
    if (other == null) return this;

    return S2SingleBuilder<T>(
      tile: other.tile,
      modal: other.modal,
      modalHeader: other.modalHeader,
      modalActions: other.modalActions,
      modalConfirm: other.modalConfirm,
      modalDivider: other.modalDivider,
      modalFooter: other.modalFooter,
      modalFilter: other.modalFilter,
      modalFilterToggle: other.modalFilterToggle,
      choice: other.choice,
      choiceTitle: other.choiceTitle,
      choiceSubtitle: other.choiceSubtitle,
      choiceSecondary: other.choiceSecondary,
      choiceDivider: other.choiceDivider,
      choiceGroup: other.choiceGroup,
      choiceHeader: other.choiceHeader,
      choiceEmpty: other.choiceEmpty,
      // choiceProgressBuilder: other.choiceProgressBuilder,
      // choicePagerBuilder: other.choicePagerBuilder,
    );
  }
}

/// Builder collection of multiple choice widget
class S2MultiBuilder<T> extends S2Builder<T> {

  /// Builder for custom tile widget
  final S2WidgetBuilder<S2MultiState<T>> tile;

  /// Builder for custom modal widget
  final S2WidgetBuilder<S2MultiState<T>> modal;

  /// Builder for custom modal header widget
  final S2WidgetBuilder<S2MultiState<T>> modalHeader;

  /// Builder for custom modal actions widget
  final S2ListWidgetBuilder<S2MultiState<T>> modalActions;

  /// Builder for custom modal confirm action widget
  final S2WidgetBuilder<S2MultiState<T>> modalConfirm;

  /// Builder for divider widget between header, body, and footer modal
  final S2WidgetBuilder<S2MultiState<T>> modalDivider;

  /// Builder for custom modal footer widget
  final S2WidgetBuilder<S2MultiState<T>> modalFooter;

  /// default constuctor
  const S2MultiBuilder({
    this.tile,
    this.modal,
    this.modalHeader,
    this.modalActions,
    this.modalConfirm,
    this.modalDivider,
    this.modalFooter,
    S2WidgetBuilder<S2Filter> modalFilter,
    S2WidgetBuilder<S2Filter> modalFilterToggle,
    S2ChoiceBuilder<T> choice,
    S2ChoiceBuilder<T> choiceTitle,
    S2ChoiceBuilder<T> choiceSubtitle,
    S2ChoiceBuilder<T> choiceSecondary,
    IndexedWidgetBuilder choiceDivider,
    S2ChoiceGroupBuilder choiceGroup,
    S2ChoiceHeaderBuilder choiceHeader,
    S2WidgetBuilder<String> choiceEmpty,
    // WidgetBuilder choiceProgress,
    // S2ChoiceBuilder<T> choicePager,
  }) : super(
    modalFilter: modalFilter,
    modalFilterToggle: modalFilterToggle,
    choice: choice,
    choiceTitle: choiceTitle,
    choiceSubtitle: choiceSubtitle,
    choiceSecondary: choiceSecondary,
    choiceDivider: choiceDivider,
    choiceGroup: choiceGroup,
    choiceHeader: choiceHeader,
    choiceEmpty: choiceEmpty,
    // choiceProgressBuilder: choiceProgressBuilder,
    // choicePagerBuilder: choicePagerBuilder,
  );

  /// Creates a copy of this [S2MultiBuilder] but with
  /// the given fields replaced with the new values.
  S2MultiBuilder<T> copyWith({
    S2WidgetBuilder<S2MultiState<T>> tile,
    S2WidgetBuilder<S2MultiState<T>> modal,
    S2WidgetBuilder<S2MultiState<T>> modalHeader,
    S2ListWidgetBuilder<S2MultiState<T>> modalActions,
    S2WidgetBuilder<S2MultiState<T>> modalConfirm,
    S2WidgetBuilder<S2MultiState<T>> modalDivider,
    S2WidgetBuilder<S2MultiState<T>> modalFooter,
    S2WidgetBuilder<S2Filter> modalFilter,
    S2WidgetBuilder<S2Filter> modalFilterToggle,
    S2ChoiceBuilder<T> choice,
    S2ChoiceBuilder<T> choiceTitle,
    S2ChoiceBuilder<T> choiceSubtitle,
    S2ChoiceBuilder<T> choiceSecondary,
    IndexedWidgetBuilder choiceDivider,
    S2ChoiceGroupBuilder choiceGroup,
    S2ChoiceHeaderBuilder choiceHeader,
    S2WidgetBuilder<String> choiceEmpty,
    // WidgetBuilder choiceProgress,
    // S2ChoiceBuilder<T> choicePager,
  }) {
    return S2MultiBuilder<T>(
      tile: tile ?? this.tile,
      modal: modal ?? this.modal,
      modalHeader: modalHeader ?? this.modalHeader,
      modalActions: modalActions ?? this.modalActions,
      modalConfirm: modalConfirm ?? this.modalConfirm,
      modalDivider: modalDivider ?? this.modalDivider,
      modalFooter: modalFooter ?? this.modalFooter,
      modalFilter: modalFilter ?? this.modalFilter,
      modalFilterToggle: modalFilterToggle ?? this.modalFilterToggle,
      choice: choice ?? this.choice,
      choiceTitle: choiceTitle ?? this.choiceTitle,
      choiceSubtitle: choiceSubtitle ?? this.choiceSubtitle,
      choiceSecondary: choiceSecondary ?? this.choiceSecondary,
      choiceDivider: choiceDivider ?? this.choiceDivider,
      choiceGroup: choiceGroup ?? this.choiceGroup,
      choiceHeader: choiceHeader ?? this.choiceHeader,
      choiceEmpty: choiceEmpty ?? this.choiceEmpty,
      // choiceProgressBuilder: choiceProgressBuilder ?? this.choiceProgressBuilder,
      // choicePagerBuilder: choicePagerBuilder ?? this.choicePagerBuilder,
    );
  }

  /// Creates a copy of this [S2MultiBuilder] but with
  /// the given fields replaced with the new values.
  S2MultiBuilder<T> merge(S2MultiBuilder<T> other) {
    // if null return current object
    if (other == null) return this;

    return S2MultiBuilder<T>(
      tile: other.tile,
      modal: other.modal,
      modalHeader: other.modalHeader,
      modalActions: other.modalActions,
      modalConfirm: other.modalConfirm,
      modalDivider: other.modalDivider,
      modalFooter: other.modalFooter,
      modalFilter: other.modalFilter,
      modalFilterToggle: other.modalFilterToggle,
      choice: other.choice,
      choiceTitle: other.choiceTitle,
      choiceSubtitle: other.choiceSubtitle,
      choiceSecondary: other.choiceSecondary,
      choiceDivider: other.choiceDivider,
      choiceGroup: other.choiceGroup,
      choiceHeader: other.choiceHeader,
      choiceEmpty: other.choiceEmpty,
      // choiceProgressBuilder: other.choiceProgressBuilder,
      // choicePagerBuilder: other.choicePagerBuilder,
    );
  }
}
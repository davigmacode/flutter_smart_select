import 'package:flutter/widgets.dart';
import '../state/filter.dart';
import '../widget.dart';
import 'choice_item.dart';
import 'choice_group.dart';

/// A common builder
typedef Widget S2WidgetBuilder<T>(
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
class S2Builder<T> {
  /// Builder for modal filter
  final S2WidgetBuilder<S2Filter> modalFilterBuilder;

  /// Builder for modal filter toggle
  final S2WidgetBuilder<S2Filter> modalFilterToggleBuilder;

  /// Builder for each custom choices item
  final S2ChoiceBuilder<T> choiceBuilder;

  /// Builder for each custom choices item subtitle
  final S2ChoiceBuilder<T> choiceTitleBuilder;

  /// Builder for each custom choices item subtitle
  final S2ChoiceBuilder<T> choiceSubtitleBuilder;

  /// Builder for each custom choices item secondary
  final S2ChoiceBuilder<T> choiceSecondaryBuilder;

  /// Builder for custom divider widget between choices item
  final IndexedWidgetBuilder choiceDividerBuilder;

  /// Builder for custom empty display
  final S2WidgetBuilder<String> choiceEmptyBuilder;

  /// A widget builder for custom choices group
  final S2ChoiceGroupBuilder choiceGroupBuilder;

  /// A widget builder for custom header choices group
  final S2ChoiceHeaderBuilder choiceHeaderBuilder;

  // /// Builder for progress indicator on choice load
  // final WidgetBuilder choiceProgressBuilder;

  // /// Builder for progress indicator on choice load
  // final S2ChoiceBuilder<T> choicePagerBuilder;

  /// default constructor
  const S2Builder({
    this.modalFilterBuilder,
    this.modalFilterToggleBuilder,
    this.choiceBuilder,
    this.choiceTitleBuilder,
    this.choiceSubtitleBuilder,
    this.choiceSecondaryBuilder,
    this.choiceDividerBuilder,
    this.choiceEmptyBuilder,
    this.choiceGroupBuilder,
    this.choiceHeaderBuilder,
    // this.choiceProgressBuilder,
    // this.choicePagerBuilder,
  });
}

/// Builder collection of single choice widget
class S2SingleBuilder<T> extends S2Builder<T> {

  /// Builder for custom tile widget
  final S2WidgetBuilder<S2SingleState<T>> tileBuilder;

  /// Builder for custom modal widget
  final S2WidgetBuilder<S2SingleState<T>> modalBuilder;

  /// Builder for custom modal header widget
  final S2WidgetBuilder<S2SingleState<T>> modalHeaderBuilder;

  /// Builder for modal confirm action widget
  final S2WidgetBuilder<S2SingleState<T>> modalConfirmBuilder;

  /// Builder for divider widget between header, body, and footer modal
  final S2WidgetBuilder<S2SingleState<T>> modalDividerBuilder;

  /// Builder for modal footer widget
  final S2WidgetBuilder<S2SingleState<T>> modalFooterBuilder;

  /// default contructor
  const S2SingleBuilder({
    this.tileBuilder,
    this.modalBuilder,
    this.modalHeaderBuilder,
    this.modalConfirmBuilder,
    this.modalDividerBuilder,
    this.modalFooterBuilder,
    S2WidgetBuilder<S2Filter> modalFilterBuilder,
    S2WidgetBuilder<S2Filter> modalFilterToggleBuilder,
    S2ChoiceBuilder<T> choiceBuilder,
    S2ChoiceBuilder<T> choiceTitleBuilder,
    S2ChoiceBuilder<T> choiceSubtitleBuilder,
    S2ChoiceBuilder<T> choiceSecondaryBuilder,
    IndexedWidgetBuilder choiceDividerBuilder,
    S2WidgetBuilder<String> choiceEmptyBuilder,
    S2ChoiceGroupBuilder choiceGroupBuilder,
    S2ChoiceHeaderBuilder choiceHeaderBuilder,
    WidgetBuilder choiceProgressBuilder,
    S2ChoiceBuilder<T> choicePagerBuilder,
  }) : super(
    modalFilterBuilder: modalFilterBuilder,
    modalFilterToggleBuilder: modalFilterToggleBuilder,
    choiceBuilder: choiceBuilder,
    choiceTitleBuilder: choiceTitleBuilder,
    choiceSubtitleBuilder: choiceSubtitleBuilder,
    choiceSecondaryBuilder: choiceSecondaryBuilder,
    choiceDividerBuilder: choiceDividerBuilder,
    choiceGroupBuilder: choiceGroupBuilder,
    choiceHeaderBuilder: choiceHeaderBuilder,
    choiceEmptyBuilder: choiceEmptyBuilder,
    // choiceProgressBuilder: choiceProgressBuilder,
    // choicePagerBuilder: choicePagerBuilder,
  );

  /// Creates a copy of this [S2SingleBuilder] but with
  /// the given fields replaced with the new values.
  S2SingleBuilder<T> copyWith({
    S2WidgetBuilder<S2SingleState<T>> tileBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalHeaderBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalConfirmBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalDividerBuilder,
    S2WidgetBuilder<S2SingleState<T>> modalFooterBuilder,
    S2WidgetBuilder<S2Filter> modalFilterBuilder,
    S2WidgetBuilder<S2Filter> modalFilterToggleBuilder,
    S2ChoiceBuilder<T> choiceBuilder,
    S2ChoiceBuilder<T> choiceTitleBuilder,
    S2ChoiceBuilder<T> choiceSubtitleBuilder,
    S2ChoiceBuilder<T> choiceSecondaryBuilder,
    IndexedWidgetBuilder choiceDividerBuilder,
    S2WidgetBuilder<String> choiceEmptyBuilder,
    S2ChoiceGroupBuilder choiceGroupBuilder,
    S2ChoiceHeaderBuilder choiceHeaderBuilder,
    WidgetBuilder choiceProgressBuilder,
    S2ChoiceBuilder<T> choicePagerBuilder,
  }) {
    return S2SingleBuilder<T>(
      tileBuilder: tileBuilder ?? this.tileBuilder,
      modalBuilder: modalBuilder ?? this.modalBuilder,
      modalHeaderBuilder: modalHeaderBuilder ?? this.modalHeaderBuilder,
      modalConfirmBuilder: modalConfirmBuilder ?? this.modalConfirmBuilder,
      modalDividerBuilder: modalDividerBuilder ?? this.modalDividerBuilder,
      modalFooterBuilder: modalFooterBuilder ?? this.modalFooterBuilder,
      modalFilterBuilder: modalFilterBuilder ?? this.modalFilterBuilder,
      modalFilterToggleBuilder: modalFilterToggleBuilder ?? this.modalFilterToggleBuilder,
      choiceBuilder: choiceBuilder ?? this.choiceBuilder,
      choiceTitleBuilder: choiceTitleBuilder ?? this.choiceTitleBuilder,
      choiceSubtitleBuilder: choiceSubtitleBuilder ?? this.choiceSubtitleBuilder,
      choiceSecondaryBuilder: choiceSecondaryBuilder ?? this.choiceSecondaryBuilder,
      choiceDividerBuilder: choiceDividerBuilder ?? this.choiceDividerBuilder,
      choiceEmptyBuilder: choiceEmptyBuilder ?? this.choiceEmptyBuilder,
      choiceGroupBuilder: choiceGroupBuilder ?? this.choiceGroupBuilder,
      choiceHeaderBuilder: choiceHeaderBuilder ?? this.choiceHeaderBuilder,
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
      tileBuilder: other.tileBuilder,
      modalBuilder: other.modalBuilder,
      modalHeaderBuilder: other.modalHeaderBuilder,
      modalConfirmBuilder: other.modalConfirmBuilder,
      modalDividerBuilder: other.modalDividerBuilder,
      modalFooterBuilder: other.modalFooterBuilder,
      modalFilterBuilder: other.modalFilterBuilder,
      modalFilterToggleBuilder: other.modalFilterToggleBuilder,
      choiceBuilder: other.choiceBuilder,
      choiceTitleBuilder: other.choiceTitleBuilder,
      choiceSubtitleBuilder: other.choiceSubtitleBuilder,
      choiceSecondaryBuilder: other.choiceSecondaryBuilder,
      choiceDividerBuilder: other.choiceDividerBuilder,
      choiceEmptyBuilder: other.choiceEmptyBuilder,
      choiceGroupBuilder: other.choiceGroupBuilder,
      choiceHeaderBuilder: other.choiceHeaderBuilder,
      // choiceProgressBuilder: other.choiceProgressBuilder,
      // choicePagerBuilder: other.choicePagerBuilder,
    );
  }
}

/// Builder collection of multiple choice widget
class S2MultiBuilder<T> extends S2Builder<T> {

  /// Builder for custom tile widget
  final S2WidgetBuilder<S2MultiState<T>> tileBuilder;

  /// Builder for custom modal widget
  final S2WidgetBuilder<S2MultiState<T>> modalBuilder;

  /// Builder for custom modal header widget
  final S2WidgetBuilder<S2MultiState<T>> modalHeaderBuilder;

  /// Builder for custom modal confirm action widget
  final S2WidgetBuilder<S2MultiState<T>> modalConfirmBuilder;

  /// Builder for divider widget between header, body, and footer modal
  final S2WidgetBuilder<S2MultiState<T>> modalDividerBuilder;

  /// Builder for custom modal footer widget
  final S2WidgetBuilder<S2MultiState<T>> modalFooterBuilder;

  /// default constuctor
  const S2MultiBuilder({
    this.tileBuilder,
    this.modalBuilder,
    this.modalHeaderBuilder,
    this.modalConfirmBuilder,
    this.modalDividerBuilder,
    this.modalFooterBuilder,
    S2WidgetBuilder<S2Filter> modalFilterBuilder,
    S2WidgetBuilder<S2Filter> modalFilterToggleBuilder,
    S2ChoiceBuilder<T> choiceBuilder,
    S2ChoiceBuilder<T> choiceTitleBuilder,
    S2ChoiceBuilder<T> choiceSubtitleBuilder,
    S2ChoiceBuilder<T> choiceSecondaryBuilder,
    IndexedWidgetBuilder choiceDividerBuilder,
    S2WidgetBuilder<String> choiceEmptyBuilder,
    S2ChoiceGroupBuilder choiceGroupBuilder,
    S2ChoiceHeaderBuilder choiceHeaderBuilder,
    WidgetBuilder choiceProgressBuilder,
    S2ChoiceBuilder<T> choicePagerBuilder,
  }) : super(
    modalFilterBuilder: modalFilterBuilder,
    modalFilterToggleBuilder: modalFilterToggleBuilder,
    choiceBuilder: choiceBuilder,
    choiceTitleBuilder: choiceTitleBuilder,
    choiceSubtitleBuilder: choiceSubtitleBuilder,
    choiceSecondaryBuilder: choiceSecondaryBuilder,
    choiceDividerBuilder: choiceDividerBuilder,
    choiceEmptyBuilder: choiceEmptyBuilder,
    choiceGroupBuilder: choiceGroupBuilder,
    choiceHeaderBuilder: choiceHeaderBuilder,
    // choiceProgressBuilder: choiceProgressBuilder,
    // choicePagerBuilder: choicePagerBuilder,
  );

  /// Creates a copy of this [S2MultiBuilder] but with
  /// the given fields replaced with the new values.
  S2MultiBuilder<T> copyWith({
    S2WidgetBuilder<S2MultiState<T>> tileBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalHeaderBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalConfirmBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalDividerBuilder,
    S2WidgetBuilder<S2MultiState<T>> modalFooterBuilder,
    S2WidgetBuilder<S2Filter> modalFilterBuilder,
    S2WidgetBuilder<S2Filter> modalFilterToggleBuilder,
    S2ChoiceBuilder<T> choiceBuilder,
    S2ChoiceBuilder<T> choiceTitleBuilder,
    S2ChoiceBuilder<T> choiceSubtitleBuilder,
    S2ChoiceBuilder<T> choiceSecondaryBuilder,
    IndexedWidgetBuilder choiceDividerBuilder,
    S2WidgetBuilder<String> choiceEmptyBuilder,
    S2ChoiceGroupBuilder choiceGroupBuilder,
    S2ChoiceHeaderBuilder choiceHeaderBuilder,
    WidgetBuilder choiceProgressBuilder,
    S2ChoiceBuilder<T> choicePagerBuilder,
  }) {
    return S2MultiBuilder<T>(
      tileBuilder: tileBuilder ?? this.tileBuilder,
      modalBuilder: modalBuilder ?? this.modalBuilder,
      modalHeaderBuilder: modalHeaderBuilder ?? this.modalHeaderBuilder,
      modalConfirmBuilder: modalConfirmBuilder ?? this.modalConfirmBuilder,
      modalDividerBuilder: modalDividerBuilder ?? this.modalDividerBuilder,
      modalFooterBuilder: modalFooterBuilder ?? this.modalFooterBuilder,
      modalFilterBuilder: modalFilterBuilder ?? this.modalFilterBuilder,
      modalFilterToggleBuilder: modalFilterToggleBuilder ?? this.modalFilterToggleBuilder,
      choiceBuilder: choiceBuilder ?? this.choiceBuilder,
      choiceTitleBuilder: choiceTitleBuilder ?? this.choiceTitleBuilder,
      choiceSubtitleBuilder: choiceSubtitleBuilder ?? this.choiceSubtitleBuilder,
      choiceSecondaryBuilder: choiceSecondaryBuilder ?? this.choiceSecondaryBuilder,
      choiceDividerBuilder: choiceDividerBuilder ?? this.choiceDividerBuilder,
      choiceEmptyBuilder: choiceEmptyBuilder ?? this.choiceEmptyBuilder,
      choiceGroupBuilder: choiceGroupBuilder ?? this.choiceGroupBuilder,
      choiceHeaderBuilder: choiceHeaderBuilder ?? this.choiceHeaderBuilder,
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
      tileBuilder: other.tileBuilder,
      modalBuilder: other.modalBuilder,
      modalHeaderBuilder: other.modalHeaderBuilder,
      modalConfirmBuilder: other.modalConfirmBuilder,
      modalDividerBuilder: other.modalDividerBuilder,
      modalFooterBuilder: other.modalFooterBuilder,
      modalFilterBuilder: other.modalFilterBuilder,
      modalFilterToggleBuilder: other.modalFilterToggleBuilder,
      choiceBuilder: other.choiceBuilder,
      choiceTitleBuilder: other.choiceTitleBuilder,
      choiceSubtitleBuilder: other.choiceSubtitleBuilder,
      choiceSecondaryBuilder: other.choiceSecondaryBuilder,
      choiceDividerBuilder: other.choiceDividerBuilder,
      choiceEmptyBuilder: other.choiceEmptyBuilder,
      choiceGroupBuilder: other.choiceGroupBuilder,
      choiceHeaderBuilder: other.choiceHeaderBuilder,
      // choiceProgressBuilder: other.choiceProgressBuilder,
      // choicePagerBuilder: other.choicePagerBuilder,
    );
  }
}
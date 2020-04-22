import 'package:flutter/widgets.dart';
import '../state/filter.dart';
import '../widget.dart';
import 'choice.dart';

/// A builder for
typedef Widget S2WidgetBuilder<T>(
  BuildContext context,
  T value,
);

/// A builder for
typedef Widget S2ComplexWidgetBuilder<A, B>(
  BuildContext context,
  A value,
  B anotherValue,
);

/// A widget builder for custom each choices item
typedef Widget S2ChoiceItemBuilder<T>(
  BuildContext context,
  S2Choice<T> choice,
  String searchText,
);

/// A widget builder for custom choices group
typedef Widget S2GroupBuilder(
  BuildContext context,
  Widget header,
  Widget choices,
);

/// A widget builder for custom header choices group
typedef Widget S2GroupHeaderBuilder(
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
  final S2ChoiceItemBuilder<T> choiceBuilder;

  /// Builder for each custom choices item subtitle
  final S2ChoiceItemBuilder<T> choiceTitleBuilder;

  /// Builder for each custom choices item subtitle
  final S2ChoiceItemBuilder<T> choiceSubtitleBuilder;

  /// Builder for each custom choices item secondary
  final S2ChoiceItemBuilder<T> choiceSecondaryBuilder;

  /// Builder for custom divider widget between choices item
  final IndexedWidgetBuilder choiceDividerBuilder;

  /// Builder for custom empty display
  final S2WidgetBuilder<String> choiceEmptyBuilder;

  /// A widget builder for custom choices group
  final S2GroupBuilder groupBuilder;

  /// A widget builder for custom header choices group
  final S2GroupHeaderBuilder groupHeaderBuilder;

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
    this.groupBuilder,
    this.groupHeaderBuilder,
  });
}

class S2SingleBuilder<T> extends S2Builder<T> {

  final S2WidgetBuilder<S2SingleState<T>> tileBuilder;
  final S2WidgetBuilder<S2SingleState<T>> modalBuilder;
  final S2WidgetBuilder<S2SingleState<T>> modalHeaderBuilder;
  final S2WidgetBuilder<S2SingleState<T>> modalConfirmBuilder;
  final S2WidgetBuilder<S2SingleState<T>> modalDividerBuilder;
  final S2WidgetBuilder<S2SingleState<T>> modalFooterBuilder;

  const S2SingleBuilder({
    this.tileBuilder,
    this.modalBuilder,
    this.modalHeaderBuilder,
    this.modalConfirmBuilder,
    this.modalDividerBuilder,
    this.modalFooterBuilder,
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
  }) : super(
    modalFilterBuilder: modalFilterBuilder,
    modalFilterToggleBuilder: modalFilterToggleBuilder,
    choiceBuilder: choiceBuilder,
    choiceTitleBuilder: choiceTitleBuilder,
    choiceSubtitleBuilder: choiceSubtitleBuilder,
    choiceSecondaryBuilder: choiceSecondaryBuilder,
    choiceDividerBuilder: choiceDividerBuilder,
    groupBuilder: groupBuilder,
    groupHeaderBuilder: groupHeaderBuilder,
    choiceEmptyBuilder: choiceEmptyBuilder,
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
    S2ChoiceItemBuilder<T> choiceBuilder,
    S2ChoiceItemBuilder<T> choiceTitleBuilder,
    S2ChoiceItemBuilder<T> choiceSubtitleBuilder,
    S2ChoiceItemBuilder<T> choiceSecondaryBuilder,
    IndexedWidgetBuilder choiceDividerBuilder,
    S2WidgetBuilder<String> choiceEmptyBuilder,
    S2GroupBuilder groupBuilder,
    S2GroupHeaderBuilder groupHeaderBuilder,
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
      groupBuilder: groupBuilder ?? this.groupBuilder,
      groupHeaderBuilder: groupHeaderBuilder ?? this.groupHeaderBuilder,
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
      groupBuilder: other.groupBuilder,
      groupHeaderBuilder: other.groupHeaderBuilder,
    );
  }
}

class S2MultiBuilder<T> extends S2Builder<T> {

  final S2WidgetBuilder<S2MultiState<T>> tileBuilder;
  final S2WidgetBuilder<S2MultiState<T>> modalBuilder;
  final S2WidgetBuilder<S2MultiState<T>> modalHeaderBuilder;
  final S2WidgetBuilder<S2MultiState<T>> modalConfirmBuilder;
  final S2WidgetBuilder<S2MultiState<T>> modalDividerBuilder;
  final S2WidgetBuilder<S2MultiState<T>> modalFooterBuilder;

  const S2MultiBuilder({
    this.tileBuilder,
    this.modalBuilder,
    this.modalHeaderBuilder,
    this.modalConfirmBuilder,
    this.modalDividerBuilder,
    this.modalFooterBuilder,
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
  }) : super(
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
    S2ChoiceItemBuilder<T> choiceBuilder,
    S2ChoiceItemBuilder<T> choiceTitleBuilder,
    S2ChoiceItemBuilder<T> choiceSubtitleBuilder,
    S2ChoiceItemBuilder<T> choiceSecondaryBuilder,
    IndexedWidgetBuilder choiceDividerBuilder,
    S2WidgetBuilder<String> choiceEmptyBuilder,
    S2GroupBuilder groupBuilder,
    S2GroupHeaderBuilder groupHeaderBuilder,
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
      groupBuilder: groupBuilder ?? this.groupBuilder,
      groupHeaderBuilder: groupHeaderBuilder ?? this.groupHeaderBuilder,
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
      groupBuilder: other.groupBuilder,
      groupHeaderBuilder: other.groupHeaderBuilder,
    );
  }
}
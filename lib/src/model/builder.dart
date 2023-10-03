import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
// import '../state/filter.dart';
import '../widget.dart';
import 'choice_item.dart';
import 'group_data.dart';

/// A common widget builder
typedef Widget S2WidgetBuilder<T>(
  BuildContext? context,
  T value,
);

/// A common list of widget builder
typedef List<Widget> S2ListWidgetBuilder<T>(
  BuildContext? context,
  T value,
);

/// A complex builder
typedef Widget S2ComplexWidgetBuilder<A, B>(
  BuildContext? context,
  A value,
  B anotherValue,
);

/// A builder for choice list item widget
typedef Widget? S2ChoiceListBuilder<T>(S2Choice<T> choice);

/// collection of builder
@immutable
class S2Builder<T> with Diagnosticable {
  /// Builder for custom divider widget between choices item
  final IndexedWidgetBuilder? choiceDivider;

  // /// Builder for progress indicator on choice load
  // final WidgetBuilder choiceProgressBuilder;

  // /// Builder for progress indicator on choice load
  // final S2ChoiceBuilder<T> choicePagerBuilder;

  /// default constructor
  const S2Builder({
    this.choiceDivider,
    // this.choiceProgressBuilder,
    // this.choicePagerBuilder,
  });
}

/// Builder collection of single choice widget
class S2SingleBuilder<T> extends S2Builder<T> {
  /// Builder for custom tile widget
  final S2WidgetBuilder<S2SingleState<T>>? tile;

  /// Builder for custom modal widget
  final S2WidgetBuilder<S2SingleState<T>>? modal;

  /// Builder for custom modal header widget
  final S2WidgetBuilder<S2SingleState<T>>? modalHeader;

  /// Builder for modal filter
  final S2WidgetBuilder<S2SingleState<T>>? modalFilter;

  /// Builder for modal filter toggle
  final S2WidgetBuilder<S2SingleState<T>>? modalFilterToggle;

  /// Builder for custom modal actions widget
  final S2ListWidgetBuilder<S2SingleState<T>>? modalActions;

  /// Builder for modal confirm action widget
  final S2WidgetBuilder<S2SingleState<T>>? modalConfirm;

  /// Builder for divider widget between header, body, and footer modal
  final S2WidgetBuilder<S2SingleState<T>>? modalDivider;

  /// Builder for modal footer widget
  final S2WidgetBuilder<S2SingleState<T>>? modalFooter;

  /// A widget builder for custom choices group
  final S2ComplexWidgetBuilder<S2SingleState<T>, S2Group<T>>? group;

  /// A widget builder for custom header choices group
  final S2ComplexWidgetBuilder<S2SingleState<T>, S2Group<T>>? groupHeader;

  /// Builder for each custom choices item
  final S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>>? choice;

  /// Builder for each custom choices item subtitle
  final S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>>? choiceTitle;

  /// Builder for each custom choices item subtitle
  final S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>>? choiceSubtitle;

  /// Builder for each custom choices item secondary
  final S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>>? choiceSecondary;

  /// Builder for custom empty display
  final S2WidgetBuilder<S2SingleState<T>>? choiceEmpty;

  /// default contructor
  const S2SingleBuilder({
    this.tile,
    this.modal,
    this.modalHeader,
    this.modalActions,
    this.modalFilter,
    this.modalFilterToggle,
    this.modalConfirm,
    this.modalDivider,
    this.modalFooter,
    this.group,
    this.groupHeader,
    this.choice,
    this.choiceTitle,
    this.choiceSubtitle,
    this.choiceSecondary,
    this.choiceEmpty,
    IndexedWidgetBuilder? choiceDivider,
    // WidgetBuilder choiceProgress,
    // S2ChoiceBuilder<T> choicePager,
  }) : super(
          choiceDivider: choiceDivider,
          // choiceProgressBuilder: choiceProgressBuilder,
          // choicePagerBuilder: choicePagerBuilder,
        );

  /// Creates a copy of this [S2SingleBuilder] but with
  /// the given fields replaced with the new values.
  S2SingleBuilder<T> copyWith({
    S2WidgetBuilder<S2SingleState<T>>? tile,
    S2WidgetBuilder<S2SingleState<T>>? modal,
    S2WidgetBuilder<S2SingleState<T>>? modalHeader,
    S2WidgetBuilder<S2SingleState<T>>? modalFilter,
    S2WidgetBuilder<S2SingleState<T>>? modalFilterToggle,
    S2ListWidgetBuilder<S2SingleState<T>>? modalActions,
    S2WidgetBuilder<S2SingleState<T>>? modalConfirm,
    S2WidgetBuilder<S2SingleState<T>>? modalDivider,
    S2WidgetBuilder<S2SingleState<T>>? modalFooter,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Group<T>>? group,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Group<T>>? groupHeader,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>>? choice,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>>? choiceTitle,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>>? choiceSubtitle,
    S2ComplexWidgetBuilder<S2SingleState<T>, S2Choice<T>>? choiceSecondary,
    S2WidgetBuilder<S2SingleState<T>>? choiceEmpty,
    IndexedWidgetBuilder? choiceDivider,
    // WidgetBuilder choiceProgress,
    // S2ChoiceBuilder<T> choicePager,
  }) {
    return S2SingleBuilder<T>(
      tile: tile ?? this.tile,
      modal: modal ?? this.modal,
      modalHeader: modalHeader ?? this.modalHeader,
      modalActions: modalActions ?? this.modalActions,
      modalFilter: modalFilter ?? this.modalFilter,
      modalFilterToggle: modalFilterToggle ?? this.modalFilterToggle,
      modalConfirm: modalConfirm ?? this.modalConfirm,
      modalDivider: modalDivider ?? this.modalDivider,
      modalFooter: modalFooter ?? this.modalFooter,
      group: group ?? this.group,
      groupHeader: groupHeader ?? this.groupHeader,
      choice: choice ?? this.choice,
      choiceTitle: choiceTitle ?? this.choiceTitle,
      choiceSubtitle: choiceSubtitle ?? this.choiceSubtitle,
      choiceSecondary: choiceSecondary ?? this.choiceSecondary,
      choiceEmpty: choiceEmpty ?? this.choiceEmpty,
      choiceDivider: choiceDivider ?? this.choiceDivider,
      // choiceProgressBuilder: choiceProgressBuilder ?? this.choiceProgressBuilder,
      // choicePagerBuilder: choicePagerBuilder ?? this.choicePagerBuilder,
    );
  }

  /// Creates a copy of this [S2SingleBuilder] but with
  /// the given fields replaced with the new values.
  S2SingleBuilder<T> merge(S2SingleBuilder<T>? other) {
    // if null return current object
    if (other == null) return this;

    return S2SingleBuilder<T>(
      tile: other.tile,
      modal: other.modal,
      modalHeader: other.modalHeader,
      modalActions: other.modalActions,
      modalFilter: other.modalFilter,
      modalFilterToggle: other.modalFilterToggle,
      modalConfirm: other.modalConfirm,
      modalDivider: other.modalDivider,
      modalFooter: other.modalFooter,
      group: other.group,
      groupHeader: other.groupHeader,
      choice: other.choice,
      choiceTitle: other.choiceTitle,
      choiceSubtitle: other.choiceSubtitle,
      choiceSecondary: other.choiceSecondary,
      choiceEmpty: other.choiceEmpty,
      choiceDivider: other.choiceDivider,
      // choiceProgressBuilder: other.choiceProgressBuilder,
      // choicePagerBuilder: other.choicePagerBuilder,
    );
  }
}

/// Builder collection of multiple choice widget
class S2MultiBuilder<T> extends S2Builder<T> {
  /// Builder for custom tile widget
  final S2WidgetBuilder<S2MultiState<T>>? tile;

  /// Builder for custom modal widget
  final S2WidgetBuilder<S2MultiState<T>>? modal;

  /// Builder for custom modal header widget
  final S2WidgetBuilder<S2MultiState<T>>? modalHeader;

  /// Builder for modal filter
  final S2WidgetBuilder<S2MultiState<T>>? modalFilter;

  /// Builder for modal filter toggle
  final S2WidgetBuilder<S2MultiState<T>>? modalFilterToggle;

  /// Builder for custom modal actions widget
  final S2ListWidgetBuilder<S2MultiState<T>>? modalActions;

  /// Builder for custom modal confirm action widget
  final S2WidgetBuilder<S2MultiState<T>>? modalConfirm;

  /// Builder for divider widget between header, body, and footer modal
  final S2WidgetBuilder<S2MultiState<T>>? modalDivider;

  /// Builder for custom modal footer widget
  final S2WidgetBuilder<S2MultiState<T>>? modalFooter;

  /// A widget builder for custom choices group
  final S2ComplexWidgetBuilder<S2MultiState<T>, S2Group<T>>? group;

  /// A widget builder for custom header choices group
  final S2ComplexWidgetBuilder<S2MultiState<T>, S2Group<T>>? groupHeader;

  /// Builder for each custom choices item
  final S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>>? choice;

  /// Builder for each custom choices item subtitle
  final S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>>? choiceTitle;

  /// Builder for each custom choices item subtitle
  final S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>>? choiceSubtitle;

  /// Builder for each custom choices item secondary
  final S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>>? choiceSecondary;

  /// Builder for custom empty display
  final S2WidgetBuilder<S2MultiState<T>>? choiceEmpty;

  /// default constructor
  const S2MultiBuilder({
    this.tile,
    this.modal,
    this.modalHeader,
    this.modalFilter,
    this.modalFilterToggle,
    this.modalActions,
    this.modalConfirm,
    this.modalDivider,
    this.modalFooter,
    this.group,
    this.groupHeader,
    this.choice,
    this.choiceTitle,
    this.choiceSubtitle,
    this.choiceSecondary,
    this.choiceEmpty,
    IndexedWidgetBuilder? choiceDivider,
    // WidgetBuilder choiceProgress,
    // S2ChoiceBuilder<T> choicePager,
  }) : super(
          choiceDivider: choiceDivider,
          // choiceProgressBuilder: choiceProgressBuilder,
          // choicePagerBuilder: choicePagerBuilder,
        );

  /// Creates a copy of this [S2MultiBuilder] but with
  /// the given fields replaced with the new values.
  S2MultiBuilder<T> copyWith({
    S2WidgetBuilder<S2MultiState<T>>? tile,
    S2WidgetBuilder<S2MultiState<T>>? modal,
    S2WidgetBuilder<S2MultiState<T>>? modalHeader,
    S2WidgetBuilder<S2MultiState<T>>? modalFilter,
    S2WidgetBuilder<S2MultiState<T>>? modalFilterToggle,
    S2ListWidgetBuilder<S2MultiState<T>>? modalActions,
    S2WidgetBuilder<S2MultiState<T>>? modalConfirm,
    S2WidgetBuilder<S2MultiState<T>>? modalDivider,
    S2WidgetBuilder<S2MultiState<T>>? modalFooter,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Group<T>>? group,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Group<T>>? groupHeader,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>>? choice,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>>? choiceTitle,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>>? choiceSubtitle,
    S2ComplexWidgetBuilder<S2MultiState<T>, S2Choice<T>>? choiceSecondary,
    S2WidgetBuilder<S2MultiState<T>>? choiceEmpty,
    IndexedWidgetBuilder? choiceDivider,
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
      group: group ?? this.group,
      groupHeader: groupHeader ?? this.groupHeader,
      choice: choice ?? this.choice,
      choiceTitle: choiceTitle ?? this.choiceTitle,
      choiceSubtitle: choiceSubtitle ?? this.choiceSubtitle,
      choiceSecondary: choiceSecondary ?? this.choiceSecondary,
      choiceEmpty: choiceEmpty ?? this.choiceEmpty,
      choiceDivider: choiceDivider ?? this.choiceDivider,
      // choiceProgressBuilder: choiceProgressBuilder ?? this.choiceProgressBuilder,
      // choicePagerBuilder: choicePagerBuilder ?? this.choicePagerBuilder,
    );
  }

  /// Creates a copy of this [S2MultiBuilder] but with
  /// the given fields replaced with the new values.
  S2MultiBuilder<T> merge(S2MultiBuilder<T>? other) {
    // if null return current object
    if (other == null) return this;

    return S2MultiBuilder<T>(
      tile: other.tile,
      modal: other.modal,
      modalHeader: other.modalHeader,
      modalFilter: other.modalFilter,
      modalFilterToggle: other.modalFilterToggle,
      modalActions: other.modalActions,
      modalConfirm: other.modalConfirm,
      modalDivider: other.modalDivider,
      modalFooter: other.modalFooter,
      group: other.group,
      groupHeader: other.groupHeader,
      choice: other.choice,
      choiceTitle: other.choiceTitle,
      choiceSubtitle: other.choiceSubtitle,
      choiceSecondary: other.choiceSecondary,
      choiceEmpty: other.choiceEmpty,
      choiceDivider: other.choiceDivider,
      // choiceProgressBuilder: other.choiceProgressBuilder,
      // choicePagerBuilder: other.choicePagerBuilder,
    );
  }
}

// /// Builder collection of multiple choice widget
// class S2Builders<T> {

//   /// Builder for custom tile widget
//   final S2WidgetBuilder<S2State<T>> tile;

//   /// Builder for custom modal widget
//   final S2WidgetBuilder<S2State<T>> modal;

//   /// Builder for custom modal header widget
//   final S2WidgetBuilder<S2State<T>> modalHeader;

//   /// Builder for custom modal actions widget
//   final S2ListWidgetBuilder<S2State<T>> modalActions;

//   /// Builder for custom modal confirm action widget
//   final S2WidgetBuilder<S2State<T>> modalConfirm;

//   /// Builder for divider widget between header, body, and footer modal
//   final S2WidgetBuilder<S2State<T>> modalDivider;

//   /// Builder for custom modal footer widget
//   final S2WidgetBuilder<S2State<T>> modalFooter;

//   /// Builder for modal filter
//   final S2WidgetBuilder<S2State<T>> modalFilter;

//   /// Builder for modal filter toggle
//   final S2WidgetBuilder<S2State<T>> modalFilterToggle;

//   /// A widget builder for custom choices group
//   final S2ComplexWidgetBuilder<S2State<T>, S2Group<T>> group;

//   /// A widget builder for custom header choices group
//   final S2ComplexWidgetBuilder<S2State<T>, S2Group<T>> groupHeader;

//   /// Builder for each custom choices item
//   final S2ComplexWidgetBuilder<S2State<T>, S2Choice<T>> choice;

//   /// Builder for each custom choices item subtitle
//   final S2ComplexWidgetBuilder<S2State<T>, S2Choice<T>> choiceTitle;

//   /// Builder for each custom choices item subtitle
//   final S2ComplexWidgetBuilder<S2State<T>, S2Choice<T>> choiceSubtitle;

//   /// Builder for each custom choices item secondary
//   final S2ComplexWidgetBuilder<S2State<T>, S2Choice<T>> choiceSecondary;

//   /// Builder for custom empty display
//   final S2WidgetBuilder<S2State<T>> choiceEmpty;

//   /// Builder for custom divider widget between choices item
//   final IndexedWidgetBuilder choiceDivider;

//   /// default constructor
//   const S2Builders({
//     this.tile,
//     this.modal,
//     this.modalHeader,
//     this.modalActions,
//     this.modalConfirm,
//     this.modalDivider,
//     this.modalFooter,
//     this.modalFilter,
//     this.modalFilterToggle,
//     this.group,
//     this.groupHeader,
//     this.choice,
//     this.choiceTitle,
//     this.choiceSubtitle,
//     this.choiceSecondary,
//     this.choiceEmpty,
//     this.choiceDivider,
//   });

//   /// Creates a copy of this [S2Builders] but with
//   /// the given fields replaced with the new values.
//   S2Builders<T> copyWith({
//     S2WidgetBuilder<S2State<T>> tile,
//     S2WidgetBuilder<S2State<T>> modal,
//     S2WidgetBuilder<S2State<T>> modalHeader,
//     S2ListWidgetBuilder<S2State<T>> modalActions,
//     S2WidgetBuilder<S2State<T>> modalConfirm,
//     S2WidgetBuilder<S2State<T>> modalDivider,
//     S2WidgetBuilder<S2State<T>> modalFooter,
//     S2WidgetBuilder<S2Filter> modalFilter,
//     S2WidgetBuilder<S2Filter> modalFilterToggle,
//     S2ComplexWidgetBuilder<S2State<T>, S2Group<T>> group,
//     S2ComplexWidgetBuilder<S2State<T>, S2Group<T>> groupHeader,
//     S2ComplexWidgetBuilder<S2State<T>, S2Choice<T>> choice,
//     S2ComplexWidgetBuilder<S2State<T>, S2Choice<T>> choiceTitle,
//     S2ComplexWidgetBuilder<S2State<T>, S2Choice<T>> choiceSubtitle,
//     S2ComplexWidgetBuilder<S2State<T>, S2Choice<T>> choiceSecondary,
//     S2WidgetBuilder<S2State<T>> choiceEmpty,
//     IndexedWidgetBuilder choiceDivider,
//   }) {
//     return S2Builders<T>(
//       tile: tile ?? this.tile,
//       modal: modal ?? this.modal,
//       modalHeader: modalHeader ?? this.modalHeader,
//       modalActions: modalActions ?? this.modalActions,
//       modalConfirm: modalConfirm ?? this.modalConfirm,
//       modalDivider: modalDivider ?? this.modalDivider,
//       modalFooter: modalFooter ?? this.modalFooter,
//       modalFilter: modalFilter ?? this.modalFilter,
//       modalFilterToggle: modalFilterToggle ?? this.modalFilterToggle,
//       group: group ?? this.group,
//       groupHeader: groupHeader ?? this.groupHeader,
//       choice: choice ?? this.choice,
//       choiceTitle: choiceTitle ?? this.choiceTitle,
//       choiceSubtitle: choiceSubtitle ?? this.choiceSubtitle,
//       choiceSecondary: choiceSecondary ?? this.choiceSecondary,
//       choiceEmpty: choiceEmpty ?? this.choiceEmpty,
//       choiceDivider: choiceDivider ?? this.choiceDivider,
//     );
//   }

//   /// Creates a copy of this [S2Builders] but with
//   /// the given fields replaced with the new values.
//   S2Builders<T> merge(S2Builders<T> other) {
//     // if null return current object
//     if (other == null) return this;

//     return S2Builders<T>(
//       tile: other.tile,
//       modal: other.modal,
//       modalHeader: other.modalHeader,
//       modalActions: other.modalActions,
//       modalConfirm: other.modalConfirm,
//       modalDivider: other.modalDivider,
//       modalFooter: other.modalFooter,
//       modalFilter: other.modalFilter,
//       modalFilterToggle: other.modalFilterToggle,
//       group: other.group,
//       groupHeader: other.groupHeader,
//       choice: other.choice,
//       choiceTitle: other.choiceTitle,
//       choiceSubtitle: other.choiceSubtitle,
//       choiceSecondary: other.choiceSecondary,
//       choiceEmpty: other.choiceEmpty,
//       choiceDivider: other.choiceDivider,
//     );
//   }
// }

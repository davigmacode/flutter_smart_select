import 'package:flutter/widgets.dart';
import './modal_theme.dart';

/// Target to open choices list
enum S2ModalType {
  /// open in full page
  fullPage,
  /// open in popup dialog
  popupDialog,
  /// open in sliding bottom sheet
  bottomSheet,
}

/// Modal configuration
class S2ModalConfig {

  /// Modal type to display choices
  final S2ModalType type;

  /// Use different title with the trigger widget title
  final String title;

  /// Whether the options list modal use header or not
  final bool useHeader;

  /// Whether the option list need to confirm
  /// to return the changed value
  final bool useConfirm;

  /// custom confirmation icon
  final Icon confirmIcon;

  /// Whether the option list is filterable or not
  final bool useFilter;

  /// Custom searchbar hint
  final String filterHint;

  /// Whether the filter is autocomplete or need confirmation
  final bool filterAuto;

  /// The filter autocomplete delay
  final Duration filterDelay;

  /// The `barrierDismissible` argument is used to indicate whether tapping on the
  /// barrier will dismiss the dialog. It is `true` by default and can not be `null`.
  final bool barrierDismissible;

  /// The `barrierColor` argument is used to specify the color of the modal
  /// barrier that darkens everything the dialog. If `null` the default color
  /// `Colors.black54` is used.
  final Color barrierColor;

  /// Configure modal style
  final S2ModalStyle style;

  /// Configure modal header style
  final S2ModalHeaderStyle headerStyle;

  /// Create modal configuration
  const S2ModalConfig({
    this.type = S2ModalType.fullPage,
    this.title,
    this.useHeader = true,
    this.useConfirm = false,
    this.confirmIcon,
    this.useFilter = false,
    this.filterAuto = false,
    this.filterDelay = const Duration(milliseconds: 300),
    this.filterHint,
    this.barrierDismissible = true,
    this.barrierColor,
    this.style = const S2ModalStyle(),
    this.headerStyle = const S2ModalHeaderStyle(),
  }) :
    assert(useHeader != null),
    assert(useConfirm != null),
    assert(useFilter != null),
    assert(filterAuto != null),
    assert(barrierDismissible != null),
    assert(style != null),
    assert(headerStyle != null);

  /// Creates a copy of this [S2ModalConfig] but with
  /// the given fields replaced with the new values.
  S2ModalConfig copyWith({
    S2ModalType type,
    String title,
    bool useHeader,
    bool useConfirm,
    Icon confirmIcon,
    bool useFilter,
    bool filterAuto,
    Duration filterDelay,
    String filterHint,
    S2ModalStyle style,
    S2ModalHeaderStyle headerStyle,
  }) {
    return S2ModalConfig(
      type: type ?? this.type,
      title: title ?? this.title,
      useHeader: useHeader ?? this.useHeader,
      useConfirm: useConfirm ?? this.useConfirm,
      confirmIcon: confirmIcon ?? this.confirmIcon,
      useFilter: useFilter ?? this.useFilter,
      filterAuto: filterAuto ?? this.filterAuto,
      filterDelay: filterDelay ?? this.filterDelay,
      filterHint: filterHint ?? this.filterHint,
      style: style ?? this.style,
      headerStyle: headerStyle ?? this.headerStyle,
    );
  }

  /// Returns a new [S2ModalConfig] that is
  /// a combination of this object and the given [other] style.
  S2ModalConfig merge(S2ModalConfig other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      type: other.type,
      title: other.title,
      useHeader: other.useHeader,
      useConfirm: other.useConfirm,
      confirmIcon: other.confirmIcon,
      useFilter: other.useFilter,
      filterAuto: other.filterAuto,
      filterDelay: other.filterDelay,
      filterHint: other.filterHint,
      style: other.style,
      headerStyle: other.headerStyle,
    );
  }
}
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

  /// Whether the option list need to confirm
  /// to return the changed value
  final bool useConfirmation;

  /// Whether the options list modal use header or not
  final bool useHeader;

  /// Whether the option list is filterable or not
  final bool useFilter;

  /// Custom searchbar hint
  final String filterHint;

  /// Whether the filter is autocomplete or need confirmation
  final bool filterAuto;

  /// Configure modal style
  final S2ModalStyle style;

  /// Configure modal header style
  final S2ModalHeaderStyle headerStyle;

  /// Create modal configuration
  const S2ModalConfig({
    this.type = S2ModalType.fullPage,
    this.title,
    this.useConfirmation = false,
    this.useHeader = true,
    this.useFilter = false,
    this.filterAuto = false,
    this.filterHint,
    this.style = const S2ModalStyle(),
    this.headerStyle = const S2ModalHeaderStyle(),
  }) :
    assert(useConfirmation != null),
    assert(useHeader != null),
    assert(useFilter != null),
    assert(filterAuto != null),
    assert(style != null),
    assert(headerStyle != null);

  /// Creates a copy of this [S2ModalConfig] but with
  /// the given fields replaced with the new values.
  S2ModalConfig copyWith({
    S2ModalType type,
    String title,
    bool useConfirmation,
    bool useHeader,
    bool useFilter,
    bool filterAuto,
    String filterHint,
    S2ModalStyle style,
    S2ModalHeaderStyle headerStyle,
  }) {
    return S2ModalConfig(
      type: type ?? this.type,
      title: title ?? this.title,
      useConfirmation: useConfirmation ?? this.useConfirmation,
      useHeader: useHeader ?? this.useHeader,
      useFilter: useFilter ?? this.useFilter,
      filterAuto: filterAuto ?? this.filterAuto,
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
      useConfirmation: other.useConfirmation,
      useHeader: other.useHeader,
      useFilter: other.useFilter,
      filterAuto: other.filterAuto,
      filterHint: other.filterHint,
      style: other.style,
      headerStyle: other.headerStyle,
    );
  }
}
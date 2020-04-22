import './modal_theme.dart';

/// Target to open choices list
enum S2ModalType { fullPage, popupDialog, bottomSheet }

/// Modal configuration
class S2ModalConfig {

  /// Modal type to display choices
  final S2ModalType type;

  /// Use different title with the trigger widget title
  final String title;

  /// Custom searchbar hint
  final String filterHint;

  /// Whether the options list modal use header or not
  final bool useHeader;

  /// Whether the option list is filterable or not
  final bool useFilter;

  /// Whether the filter is autocomplete or need confirmation
  final bool autofilter;

  /// Whether the option list need to confirm
  /// to return the changed value
  final bool useConfirmation;

  /// Configure modal style
  final S2ModalStyle style;

  /// Configure modal header style
  final S2ModalHeaderStyle headerStyle;

  /// Create modal configuration
  const S2ModalConfig({
    this.type = S2ModalType.fullPage,
    this.title,
    this.filterHint,
    this.useHeader = true,
    this.useFilter = false,
    this.autofilter = false,
    this.useConfirmation = false,
    this.style = const S2ModalStyle(),
    this.headerStyle = const S2ModalHeaderStyle(),
  });

  /// Creates a copy of this [S2ModalConfig] but with
  /// the given fields replaced with the new values.
  S2ModalConfig copyWith({
    S2ModalType type,
    String title,
    String filterHint,
    bool useHeader,
    bool useFilter,
    bool useConfirmation,
    S2ModalStyle style,
    S2ModalHeaderStyle headerStyle,
  }) {
    return S2ModalConfig(
      type: type ?? this.type,
      title: title ?? this.title,
      filterHint: filterHint ?? this.filterHint,
      useHeader: useHeader ?? this.useHeader,
      useFilter: useFilter ?? this.useFilter,
      useConfirmation: useConfirmation ?? this.useConfirmation,
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
      filterHint: other.filterHint,
      useHeader: other.useHeader,
      useFilter: other.useFilter,
      useConfirmation: other.useConfirmation,
      style: other.style,
      headerStyle: other.headerStyle,
    );
  }
}
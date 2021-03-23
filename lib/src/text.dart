import 'package:flutter/widgets.dart';

/// Text widget that supports highlight
class S2Text extends StatelessWidget {
  /// The text data string
  final String? text;

  /// The text style
  final TextStyle? style;

  /// The highlight data string
  final String? highlight;

  /// The highlight color
  final Color? highlightColor;

  /// Whether the match is case sensitive or not
  final bool caseSensitive;

  /// Default constructor
  const S2Text({
    Key? key,
    this.text,
    this.style,
    this.highlight,
    this.highlightColor,
    this.caseSensitive = false,
  }) : super(key: key);

  /// Default hightlight color
  ///
  /// Defaults to yellow
  static const Color defaultHightlightColor = Color(0xFFFBC02D);

  @override
  Widget build(BuildContext context) {
    if ((highlight?.isEmpty ?? true) || text!.isEmpty) {
      return Text(text!, style: style);
    }

    final TextStyle defaultTextStyle = DefaultTextStyle.of(context).style;
    final TextStyle textStyle = defaultTextStyle.merge(style);
    final Pattern pattern = RegExp(highlight!, caseSensitive: caseSensitive);
    int start = 0;
    int indexOfHighlight;
    List<TextSpan> spans = [];

    do {
      indexOfHighlight = text!.indexOf(pattern, start);
      if (indexOfHighlight < 0) {
        // no highlight
        final content = text!.substring(start, text!.length);
        spans.add(_normalSpan(content, textStyle));
        break;
      }
      if (indexOfHighlight == start) {
        // start with highlight.
        final highlightedText = text!.substring(start, start + highlight!.length);
        spans.add(_highlightSpan(highlightedText, textStyle));
        start += highlightedText.length;
      } else {
        // normal + highlight
        final String normalText = text!.substring(start, indexOfHighlight);
        spans.add(_normalSpan(normalText, textStyle));
        start += normalText.length;
      }
    } while (true);

    return Text.rich(TextSpan(children: spans));
  }

  TextSpan _highlightSpan(String content, TextStyle style) {
    return TextSpan(
      text: content,
      style: style.copyWith(
        backgroundColor: highlightColor ?? defaultHightlightColor,
      ),
    );
  }

  TextSpan _normalSpan(String content, TextStyle style) {
    return TextSpan(text: content, style: style);
  }
}

import 'package:flutter/widgets.dart';

/// text widget that supports highlight
class S2Text extends StatelessWidget {

  /// the text data string
  final String text;

  /// the text style
  final TextStyle style;

  /// the highlight data string
  final String highlight;

  /// the highlight color
  final Color highlightColor;

  /// whether the match is case sensitive or not
  final bool caseSensitive;

  /// default constructor
  const S2Text({
    Key key,
    this.text,
    this.style,
    this.highlight,
    this.highlightColor,
    this.caseSensitive = false,
  }) : super(key: key);

  /// default hightlight color
  ///
  /// defaults to yellow
  static const Color defaultHightlightColor = Color(0xFFFBC02D);

  @override
  Widget build(BuildContext context) {
    if ((highlight?.isEmpty ?? true) || text.isEmpty) {
      return Text(text, style: style);
    }

    final Pattern pattern = RegExp(highlight, caseSensitive: caseSensitive);
    int start = 0;
    int indexOfHighlight;
    List<TextSpan> spans = [];

    do {
      indexOfHighlight = text.indexOf(pattern, start);
      if (indexOfHighlight < 0) {
        // no highlight
        spans.add(_normalSpan(text.substring(start, text.length)));
        break;
      }
      if (indexOfHighlight == start) {
        // start with highlight.
        spans.add(_highlightSpan(text.substring(start, start + highlight.length)));
        start += highlight.length;
      } else {
        // normal + highlight
        final String normalText = text.substring(start, indexOfHighlight);
        spans.add(_normalSpan(normalText));
        start += normalText.length;
      }
    } while (true);

    return Text.rich(TextSpan(children: spans));
  }

  TextSpan _highlightSpan(String content) {
    return TextSpan(
      text: content,
      style: style.copyWith(
        backgroundColor: highlightColor ?? defaultHightlightColor
      )
    );
  }

  TextSpan _normalSpan(String content) {
    return TextSpan(text: content, style: style);
  }
}
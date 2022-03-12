import 'package:flutter/widgets.dart';
import 'package:flutter_skeleton/src/skeleton_shape.dart';

class SkeletonShapeText extends StatelessWidget {
  final String data;
  final int? maxLines;
  final double? spacing;
  final TextStyle? style;
  final TextDirection? textDirection;

  const SkeletonShapeText(
    this.data, {
    this.style,
    Key? key,
    this.maxLines,
    this.spacing,
    this.textDirection,
  }) : super(key: key);

  int get _maxLines => maxLines ?? 1;
  double get _spacing => spacing ?? 4;
  TextStyle get _style => style ?? TextStyle();

  @override
  Widget build(BuildContext context) {
    final words = data.trim().replaceAll(RegExp(r'\s{2,}'), ' ').split(' ');
    final spans = <WidgetSpan>[];

    if (words.length != 1) {
      for (final word in words) {
        spans.add(WidgetSpan(child: _span(word)));
        if (word != words.first || word != words.last) {
          spans.add(WidgetSpan(child: SizedBox(width: _spacing)));
        }
      }
    } else {
      spans.add(WidgetSpan(child: _span(words.first)));
    }

    return RichText(
      maxLines: _maxLines,
      overflow: TextOverflow.clip,
      softWrap: true,
      text: TextSpan(text: '', children: spans),
    );
  }

  Widget _span(String text) {
    final textPainter = TextPainter(
        text: TextSpan(text: text, style: _style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout();

    return SkeletonShape(
      width: textPainter.width,
      height: textPainter.height,
    );
  }
}

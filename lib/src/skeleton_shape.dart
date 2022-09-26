import 'package:easy_skeleton/src/skeleton_manager.dart';
import 'package:easy_skeleton/src/skeleton_scope.dart';
import 'package:easy_skeleton/src/skeleton_theme.dart';
import 'package:flutter/material.dart';

abstract class SkeletonShape extends Widget {
  const factory SkeletonShape({
    required double width,
    required double height,
    double? radius,
    Key? key,
  }) = _SkeletonShapeRect;

  const factory SkeletonShape.circle(double side, {Key? key}) =
      _SkeletonShapeRect.circle;

  const factory SkeletonShape.square(double side, {double? radius, Key? key}) =
      _SkeletonShapeRect.square;

  const factory SkeletonShape.text(
    String data, {
    TextStyle? style,
    int maxLines,
    double spacing,
    TextDirection? textDirection,
    Key? key,
  }) = _SkeletonShapeText;
}

class _Shape extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double radius;

  const _Shape({
    required this.width,
    required this.height,
    required this.color,
    required this.radius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
      data: SkeletonThemeData(color: color, radius: radius),
      child: LayoutBuilder(builder: (context, constraints) {
        return CustomPaint(
          size: Size(width, height),
          painter: _SkeletonShapePainter(
            constraints: constraints,
            size: Size(width, height),
            radius: radius,
            color: color,
          ),
        );
      }),
    );
  }
}

class _SkeletonShapePainter extends CustomPainter {
  final Size size;
  final Color color;
  final double radius;
  final BoxConstraints constraints;

  _SkeletonShapePainter({
    required this.color,
    required this.radius,
    required this.size,
    required this.constraints,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final clampedWidth =
        this.size.width.clamp(this.size.width, constraints.maxWidth);
    final clampedHeight =
        this.size.height.clamp(this.size.width, constraints.maxHeight);
    final rect = Rect.fromLTWH(0, 0, clampedWidth, clampedHeight);
    canvas
      ..clipRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..drawPaint(paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _SkeletonShapeRect extends StatelessWidget implements SkeletonShape {
  final double width;
  final double height;
  final double? radius;

  const _SkeletonShapeRect({
    Key? key,
    required this.width,
    required this.height,
    this.radius,
  }) : super(key: key);

  const _SkeletonShapeRect.circle(
    double side, {
    Key? key,
  })  : width = side,
        height = side,
        radius = side,
        super(key: key);

  const _SkeletonShapeRect.square(
    double side, {
    this.radius,
    Key? key,
  })  : width = side,
        height = side,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      final skeletonTheme = _themeData(context);
      final radius = this.radius ?? skeletonTheme.radius;
      final child = _Shape(
        width: width,
        height: height,
        color: skeletonTheme.color!,
        radius: radius,
      );

      final scope = SkeletonScope.of(context);
      if (scope.builder != null) {
        return scope.builder!(context, child);
      }
      return child;
    } catch (e) {
      throw FlutterError('SkeletonScope not found');
    }
  }

  SkeletonThemeData _themeData(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final skeleton = context.findAncestorWidgetOfExactType<SkeletonManager>();
    if (skeleton != null &&
        (skeleton.darkTheme != null || skeleton.theme != null)) {
      var theme =
          brightness == Brightness.light ? skeleton.theme : skeleton.darkTheme;
      theme ??= skeleton.theme ?? skeleton.darkTheme;
      return theme!;
    }

    return SkeletonThemeData(color: Colors.grey);
  }
}

class _SkeletonShapeText extends StatelessWidget implements SkeletonShape {
  final String data;
  final int maxLines;
  final double spacing;
  final TextStyle? style;
  final TextDirection? textDirection;

  const _SkeletonShapeText(
    this.data, {
    this.style,
    this.maxLines = 1,
    this.spacing = 4,
    this.textDirection,
    Key? key,
  }) : super(key: key);

  TextStyle get _style => style ?? const TextStyle();

  @override
  Widget build(BuildContext context) {
    final words = data.trim().replaceAll(RegExp(r'\s{2,}'), ' ').split(' ');
    final spans = <WidgetSpan>[];

    if (words.length != 1) {
      for (final word in words) {
        spans.add(WidgetSpan(child: _span(word)));
        if (word != words.first || word != words.last) {
          spans.add(WidgetSpan(child: SizedBox(width: spacing)));
        }
      }
    } else {
      spans.add(WidgetSpan(child: _span(words.first)));
    }

    return RichText(
      maxLines: maxLines,
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

    return _SkeletonShapeRect(
      width: textPainter.width,
      height: textPainter.height,
    );
  }
}

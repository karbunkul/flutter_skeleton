import 'package:flutter/material.dart';
import 'package:flutter_skeleton/src/skeleton_manager.dart';
import 'package:flutter_skeleton/src/skeleton_scope.dart';
import 'package:flutter_skeleton/src/skeleton_theme.dart';

class SkeletonShape extends StatelessWidget {
  final double width;
  final double height;
  final double? radius;

  const SkeletonShape({
    Key? key,
    required this.width,
    required this.height,
    this.radius,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    try {
      final skeletonTheme = _themeData(context);
      final _radius = radius ?? skeletonTheme.radius;
      final child = _Shape(
        width: width,
        height: height,
        color: skeletonTheme.color!,
        radius: _radius,
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
      var _theme =
          brightness == Brightness.light ? skeleton.theme : skeleton.darkTheme;
      _theme ??= skeleton.theme ?? skeleton.darkTheme;
      return _theme!;
    }

    return SkeletonThemeData(color: Colors.grey);
  }

  factory SkeletonShape.circle(double side) {
    return SkeletonShape(width: side, height: side, radius: side);
  }

  factory SkeletonShape.square(double side, {double? radius}) {
    return SkeletonShape(width: side, height: side, radius: radius);
  }
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
      child: CustomPaint(
        size: Size(width, height),
        painter: _SkeletonShapePainter(
          size: Size(width, height),
          radius: radius,
          color: color,
        ),
      ),
    );
  }
}

class _SkeletonShapePainter extends CustomPainter {
  final Size size;
  final Color color;
  final double radius;

  _SkeletonShapePainter({
    required this.color,
    required this.radius,
    required this.size,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final rect = Rect.fromLTWH(0, 0, this.size.width, this.size.height);
    canvas
      ..clipRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..drawPaint(paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

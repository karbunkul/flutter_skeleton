import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SkeletonTheme extends InheritedTheme {
  final SkeletonThemeData data;

  const SkeletonTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(SkeletonTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ancestorTheme =
        context.findAncestorWidgetOfExactType<SkeletonTheme>()!;
    return identical(this, ancestorTheme)
        ? child
        : SkeletonTheme(data: data, child: child);
  }

  static SkeletonThemeData of(BuildContext context) {
    final skeletonTheme =
        context.dependOnInheritedWidgetOfExactType<SkeletonTheme>();
    var theme = skeletonTheme?.data ?? _defaultTheme(context);

    if (theme.color == null) {
      theme = theme.copyWith(color: _color(context));
    }
    return theme;
  }

  static Color _color(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  static SkeletonThemeData _defaultTheme(BuildContext context) {
    return SkeletonThemeData(color: _color(context));
  }
}

class SkeletonThemeData with Diagnosticable {
  final Color? color;
  late double radius;

  SkeletonThemeData({
    this.color,
    double? radius,
  }) {
    this.radius = radius ?? 8;
  }

  SkeletonThemeData copyWith({Color? color, double? radius}) {
    return SkeletonThemeData(
      color: color ?? this.color,
      radius: radius ?? this.radius,
    );
  }
}

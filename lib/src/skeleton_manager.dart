import 'package:flutter/material.dart';
import 'package:flutter_skeleton/src/skeleton_scope.dart';
import 'package:flutter_skeleton/src/skeleton_theme.dart';

class SkeletonManager extends StatelessWidget {
  final Widget child;
  final SkeletonThemeData? theme;
  final SkeletonThemeData? darkTheme;
  final SkeletonBuilder? builder;
  final SkeletonBuilder? groupBuilder;
  final bool? drawShape;

  SkeletonManager({
    Key? key,
    required this.child,
    this.builder,
    this.groupBuilder,
    this.theme,
    this.darkTheme,
    this.drawShape,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
      data: _themeData(context),
      child: SkeletonScope(
        drawShape: drawShape ?? true,
        builder: builder,
        groupBuilder: groupBuilder,
        child: child,
      ),
    );
  }

  SkeletonThemeData _themeData(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    var skeletonTheme = SkeletonTheme.of(context);
    var _theme = brightness == Brightness.light ? theme : darkTheme;
    _theme ??= theme ?? darkTheme;

    return _theme ?? skeletonTheme.copyWith(radius: 8.0);
  }
}
import 'package:easy_skeleton/src/skeleton_scope.dart';
import 'package:easy_skeleton/src/skeleton_theme.dart';
import 'package:flutter/material.dart';

class SkeletonManager extends StatelessWidget {
  final Widget child;
  final SkeletonThemeData? theme;
  final SkeletonThemeData? darkTheme;
  final SkeletonBuilder? builder;
  final SkeletonBuilder? groupBuilder;
  final SkeletonViewMode? viewMode;

  const SkeletonManager({
    required this.child,
    Key? key,
    this.theme,
    this.darkTheme,
    this.builder,
    this.groupBuilder,
    this.viewMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
      data: _themeData(context),
      child: SkeletonScope(
        viewMode: viewMode ?? SkeletonViewMode.auto,
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

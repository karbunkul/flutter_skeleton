import 'package:flutter/widgets.dart';

typedef SkeletonBuilder = Widget Function(BuildContext context, Widget child);

enum SkeletonViewMode { show, hide, auto }

class SkeletonScope extends InheritedWidget {
  final SkeletonBuilder? builder;
  final SkeletonBuilder? groupBuilder;
  final SkeletonViewMode viewMode;

  const SkeletonScope({
    required this.viewMode,
    super.key,
    required super.child,
    this.builder,
    this.groupBuilder,
  });

  static SkeletonScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SkeletonScope>();
  }

  static SkeletonScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SkeletonScope>()!;
  }

  @override
  bool updateShouldNotify(SkeletonScope oldWidget) {
    return true;
  }
}

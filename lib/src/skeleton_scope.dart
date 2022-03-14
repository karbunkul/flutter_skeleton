import 'package:flutter/widgets.dart';

typedef SkeletonBuilder = Widget Function(BuildContext context, Widget child);

enum SkeletonViewMode { show, hide, auto }

class SkeletonScope extends InheritedWidget {
  final SkeletonBuilder? builder;
  final SkeletonBuilder? groupBuilder;
  final SkeletonViewMode viewMode;

  SkeletonScope({
    required this.viewMode,
    Key? key,
    required Widget child,
    this.builder,
    this.groupBuilder,
  }) : super(key: key, child: child);

  static SkeletonScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SkeletonScope>();
  }

  static SkeletonScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SkeletonScope>()!;
  }

  @override
  bool updateShouldNotify(SkeletonScope old) {
    return true;
  }
}

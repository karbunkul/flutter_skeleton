import 'package:easy_skeleton/src/skeleton_scope.dart';
import 'package:flutter/widgets.dart';

class SkeletonGroup extends StatelessWidget {
  final WidgetBuilder builder;
  final bool skeleton;

  const SkeletonGroup({
    Key? key,
    required this.builder,
    required this.skeleton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scope = SkeletonScope.maybeOf(context);
    final child = builder(context);
    final viewMode = scope?.viewMode ?? SkeletonViewMode.auto;

    switch (viewMode) {
      case SkeletonViewMode.hide:
        return child;

      default:
        if (skeleton == true && scope != null && scope.groupBuilder != null) {
          return scope.groupBuilder!.call(context, child);
        }
        return child;
    }
  }
}

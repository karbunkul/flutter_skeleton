import 'package:flutter/widgets.dart';
import 'package:flutter_skeleton/src/skeleton_scope.dart';

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

    if (scope?.drawShape == false) {
      return child;
    }

    if (skeleton == true && scope != null && scope.groupBuilder != null) {
      return scope.groupBuilder!.call(context, child);
    }
    return child;
  }
}
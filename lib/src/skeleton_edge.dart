import 'package:easy_skeleton/src/skeleton_group.dart';
import 'package:flutter/widgets.dart';

class SkeletonEdge extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const SkeletonEdge({
    required this.child,
    super.key,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    if (padding == null && margin == null) {
      return child;
    }
    final group = context.findAncestorWidgetOfExactType<SkeletonGroup>();
    if (group != null) {
      return Container(padding: padding, margin: margin, child: child);
    }

    return child;
  }
}

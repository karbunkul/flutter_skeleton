import 'package:flutter/widgets.dart';
import 'package:flutter_skeleton/src/skeleton_group.dart';

class SkeletonEdge extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const SkeletonEdge({
    required this.child,
    Key? key,
    this.padding,
    this.margin,
  }) : super(key: key);

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

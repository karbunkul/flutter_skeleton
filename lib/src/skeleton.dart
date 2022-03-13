import 'package:flutter/widgets.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:flutter_skeleton/src/skeleton_group.dart';

class Skeleton extends StatelessWidget {
  final Widget child;
  final Widget shape;
  final bool? skeleton;

  const Skeleton({
    required this.child,
    required this.shape,
    Key? key,
    this.skeleton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final group = context.findAncestorWidgetOfExactType<SkeletonGroup>();
    if (_drawShape(context) == false && group?.skeleton == true) {
      return SizedBox();
    }

    if (_skeleton(context)) {
      return shape;
    }

    return child;
  }

  bool _skeleton(BuildContext context) {
    if (skeleton != null) {
      return skeleton!;
    }

    return context.findAncestorWidgetOfExactType<SkeletonGroup>()?.skeleton ??
        false;
  }

  bool _drawShape(BuildContext context) {
    return SkeletonScope.of(context).drawShape;
  }

  factory Skeleton.builder({
    required WidgetBuilder builder,
    required Widget shape,
    bool? skeleton,
  }) {
    final child = Builder(builder: builder);
    return Skeleton(shape: shape, skeleton: skeleton, child: child);
  }
}

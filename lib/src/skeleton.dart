import 'package:easy_skeleton/easy_skeleton.dart';
import 'package:flutter/widgets.dart';

typedef SkeletonTextBuilder = Widget Function(
  BuildContext context,
  String data,
);

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
    final scope = SkeletonScope.maybeOf(context);
    final viewMode = scope?.viewMode ?? SkeletonViewMode.auto;

    // always show shape
    if (viewMode == SkeletonViewMode.show) {
      return shape;
    }

    // disable skeleton shape
    if (viewMode == SkeletonViewMode.hide && group?.skeleton == true) {
      return const SizedBox();
    }

    // auto logic
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

  factory Skeleton.builder({
    required WidgetBuilder builder,
    required Widget shape,
    bool? skeleton,
  }) {
    final child = Builder(builder: builder);
    return Skeleton(shape: shape, skeleton: skeleton, child: child);
  }

  factory Skeleton.text(
    String data, {
    // skeleton text placeholder
    String? skeletonText,
    SkeletonTextBuilder? textBuilder,
    TextStyle? style,
    TextAlign? textAlign,
    bool? skeleton,
  }) {
    Widget child = Text(data, style: style, textAlign: textAlign);

    if (textBuilder != null) {
      child = Builder(builder: (context) {
        return textBuilder.call(context, data);
      });
    }

    return Skeleton(
      skeleton: skeleton,
      shape: SkeletonShape.text(skeletonText ?? data, style: style),
      child: child,
    );
  }
}

import 'package:easy_skeleton/easy_skeleton.dart';
import 'package:example/skeleton_demo_page.dart';
import 'package:flutter/material.dart';

class PersonItem extends StatelessWidget {
  final Person data;
  const PersonItem(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      dense: true,
      title: Skeleton.builder(
        builder: (context) => Text(data.displayName),
        shape: const SkeletonShape.text('data.displayName', spacing: 8),
      ),
      subtitle: SkeletonEdge(
        padding: const EdgeInsets.only(top: 8),
        child: Skeleton.builder(
          builder: (context) => Text(data.jobTitle, style: textTheme.caption),
          shape: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child:
                SkeletonShape.text('data jobTitle', style: textTheme.caption!),
          ),
        ),
      ),
      trailing: Skeleton.builder(
        builder: (context) => const Text('отпуск'),
        shape: const SkeletonShape.text('отпуск', style: TextStyle()),
      ),
      leading: Skeleton.builder(
        builder: (context) => CircleAvatar(child: Text(data.avatar)),
        shape: const SkeletonShape.circle(40),
      ),
    );
  }
}

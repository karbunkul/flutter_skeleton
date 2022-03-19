import 'package:easy_skeleton/easy_skeleton.dart';
import 'package:example/skeleton_demo_page.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skeleton Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      builder: (_, child) {
        return SkeletonManager(
          viewMode: SkeletonViewMode.hide,
          theme: SkeletonThemeData(color: Colors.grey, radius: 4),
          // darkTheme: SkeletonThemeData(color: Colors.amber, radius: 4),
          groupBuilder: (context, child) {
            final color = SkeletonTheme.of(context).color;

            return Shimmer.fromColors(
              baseColor: color!,
              highlightColor: color.withOpacity(0.8),
              child: child,
            );
          },
          child: child!,
        );
      },
      home: const SkeletonDemoPage(),
    );
  }
}

class InvertedTheme extends StatelessWidget {
  final Widget child;
  const InvertedTheme({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var app = context.findAncestorWidgetOfExactType<MaterialApp>();
    if (app != null && app.theme != null && app.darkTheme != null) {
      var isDark = Theme.of(context).brightness == Brightness.dark;
      var brightness = isDark ? Brightness.light : Brightness.dark;
      var themeData = isDark ? app.theme : app.darkTheme;
      return Theme(
        data: themeData!.copyWith(brightness: brightness),
        child: child,
      );
    }
    return child;
  }
}

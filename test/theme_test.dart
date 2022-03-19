import 'package:easy_skeleton/easy_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'default theme: color default value from Theme.highlightColor, default radius 8.0',
      (tester) async {
    var themeData = ThemeData.light();
    await tester.pumpWidget(MaterialApp(
      theme: themeData,
      home: Builder(builder: (_) {
        var skeletonTheme = SkeletonTheme.of(_);
        expect(skeletonTheme.color != null, true);
        expect(skeletonTheme.radius == 8.0, true);
        expect(skeletonTheme.color == Theme.of(_).colorScheme.surface, true);
        return const Scaffold();
      }),
    ));
  });
}

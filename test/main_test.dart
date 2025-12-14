import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbithub_based_project/main.dart';
import 'package:orbithub_based_project/pages/option_a_page.dart';

void main() {
  group('MyApp', () {
    testWidgets('App initializes with OptionAPage as home',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify OptionAPage is the home page
      expect(find.byType(OptionAPage), findsOneWidget);
      expect(find.text('Here is the start page'), findsOneWidget);
      expect(find.text('Option A'), findsOneWidget);
    });

    testWidgets('App uses Material3 design', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.useMaterial3, true);
    });

    testWidgets('App has correct title', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.title, 'OrbitHub Project');
    });
  });
}

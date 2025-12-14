import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbithub_based_project/pages/option_a_page.dart';

void main() {
  group('OptionAPage Widget Tests', () {
    testWidgets('should display centered text "Here is the start page"',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: OptionAPage(),
        ),
      );

      // Assert
      expect(find.text(OptionAPage.displayText), findsOneWidget);
      expect(find.text('Here is the start page'), findsOneWidget);
    });

    testWidgets('should have AppBar with title "Option A"',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: OptionAPage(),
        ),
      );

      // Assert
      expect(find.widgetWithText(AppBar, 'Option A'), findsOneWidget);
    });

    testWidgets('text should be centered on the page',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: OptionAPage(),
        ),
      );

      // Assert - Find the Center widget containing the text
      final centerFinder = find.ancestor(
        of: find.text('Here is the start page'),
        matching: find.byType(Center),
      );
      expect(centerFinder, findsOneWidget);
    });

    testWidgets('text should have proper styling',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: OptionAPage(),
        ),
      );

      // Assert
      final textWidget = tester.widget<Text>(
        find.text('Here is the start page'),
      );
      expect(textWidget.style?.fontSize, 24);
      expect(textWidget.style?.fontWeight, FontWeight.w500);
      expect(textWidget.textAlign, TextAlign.center);
    });

    testWidgets('should be a Scaffold widget', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: OptionAPage(),
        ),
      );

      // Assert
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should have correct route name', (WidgetTester tester) async {
      // Assert
      expect(OptionAPage.routeName, '/option-a');
    });

    testWidgets('should render correctly with key',
        (WidgetTester tester) async {
      // Arrange
      const testKey = Key('option-a-page');

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: OptionAPage(key: testKey),
        ),
      );

      // Assert
      expect(find.byKey(testKey), findsOneWidget);
    });
  });
}

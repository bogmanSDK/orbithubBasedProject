import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbithub_based_project/main.dart';
import 'package:orbithub_based_project/pages/option_a_page.dart';

void main() {
  group('Main App Integration Tests', () {
    testWidgets('should navigate to Option A page when button is pressed',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());

      // Act - Find and tap the "Go to Option A" button
      final optionAButton = find.text('Go to Option A');
      expect(optionAButton, findsOneWidget);
      await tester.tap(optionAButton);
      await tester.pumpAndSettle();

      // Assert - Should be on Option A page
      expect(find.text('Here is the start page'), findsOneWidget);
      expect(find.widgetWithText(AppBar, 'Option A'), findsOneWidget);
    });

    testWidgets('Option A page should be visible only in Option A section',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());

      // Act & Assert - Initially on home page, placeholder should not be visible
      expect(find.text('Here is the start page'), findsNothing);

      // Navigate to Option A
      await tester.tap(find.text('Go to Option A'));
      await tester.pumpAndSettle();

      // Now placeholder should be visible
      expect(find.text('Here is the start page'), findsOneWidget);

      // Go back to home
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Placeholder should not be visible on home page
      expect(find.text('Here is the start page'), findsNothing);
    });

    testWidgets(
        'Option B and Option C should not show Option A placeholder page',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());

      // Act - Try to navigate to Option B
      await tester.tap(find.text('Go to Option B'));
      await tester.pumpAndSettle();

      // Assert - Should show snackbar, not navigate to Option A page
      expect(find.text('This section is not available'), findsOneWidget);
      expect(find.text('Here is the start page'), findsNothing);

      // Dismiss snackbar
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Act - Try to navigate to Option C
      await tester.tap(find.text('Go to Option C'));
      await tester.pumpAndSettle();

      // Assert - Should show snackbar, not navigate to Option A page
      expect(find.text('This section is not available'), findsOneWidget);
      expect(find.text('Here is the start page'), findsNothing);
    });

    testWidgets('HomePage should display section selection buttons',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(const MyApp());

      // Assert
      expect(find.text('Select a section:'), findsOneWidget);
      expect(find.text('Go to Option A'), findsOneWidget);
      expect(find.text('Go to Option B'), findsOneWidget);
      expect(find.text('Go to Option C'), findsOneWidget);
    });

    testWidgets('should have correct route registered for Option A',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(const MyApp());

      // Assert - Navigate using route name
      final context = tester.element(find.byType(MaterialApp));
      final navigator = Navigator.of(context);
      
      // This will throw if route is not registered
      navigator.pushNamed(OptionAPage.routeName);
      await tester.pumpAndSettle();

      expect(find.text('Here is the start page'), findsOneWidget);
    });

    testWidgets('Option A page should match layout specifications',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());

      // Act - Navigate to Option A
      await tester.tap(find.text('Go to Option A'));
      await tester.pumpAndSettle();

      // Assert - Verify layout structure
      expect(find.byType(Scaffold), findsNWidgets(greaterThanOrEqualTo(1)));
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      
      // Verify text styling matches Option A specifications
      final textWidget = tester.widget<Text>(
        find.text('Here is the start page'),
      );
      expect(textWidget.style?.fontSize, 24);
      expect(textWidget.textAlign, TextAlign.center);
    });
  });
}

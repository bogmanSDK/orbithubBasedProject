import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbithub_based_project/pages/option_a_page.dart';

void main() {
  group('OptionAPage', () {
    testWidgets('Scenario 1: Placeholder page is successfully created',
        (WidgetTester tester) async {
      // Given the developer is ready to create the placeholder page in section "Option A"
      // When the developer creates a page with the centered text "Here is the start page"
      await tester.pumpWidget(const MaterialApp(home: OptionAPage()));

      // Then the page should successfully be created with the centered text "Here is the start page"
      expect(find.text('Here is the start page'), findsOneWidget);

      // And the page should be styled and laid out according to "Option A"
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Option A'), findsOneWidget);
    });

    testWidgets('Scenario 2: Placeholder page is visible in the correct section',
        (WidgetTester tester) async {
      // Given the placeholder page has been created
      // When the user navigates to section "Option A"
      await tester.pumpWidget(const MaterialApp(home: OptionAPage()));

      // Then the user should be able to see the placeholder page with centered text "Here is the start page"
      expect(find.text('Here is the start page'), findsOneWidget);
      expect(find.text('Option A'), findsOneWidget);
    });

    testWidgets('Scenario 4: Placeholder page layout matches "Option A"',
        (WidgetTester tester) async {
      // Given the placeholder page has been created
      await tester.pumpWidget(const MaterialApp(home: OptionAPage()));

      // When the developer or user views the page
      await tester.pumpAndSettle();

      // Then the layout and styling of the page should match the specifications of "Option A"
      // Verify the text is centered
      final centerFinder = find.byType(Center);
      expect(centerFinder, findsOneWidget);

      // Verify the text widget exists within the center
      final textFinder = find.text('Here is the start page');
      expect(textFinder, findsOneWidget);

      // Verify text styling
      final Text textWidget = tester.widget(textFinder);
      expect(textWidget.style?.fontSize, 24);
      expect(textWidget.style?.fontWeight, FontWeight.w500);
      expect(textWidget.textAlign, TextAlign.center);
    });

    testWidgets('Page has correct section name', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: OptionAPage()));

      // Verify the section name is "Option A"
      expect(OptionAPage.sectionName, 'Option A');
      expect(find.text('Option A'), findsOneWidget);
    });

    testWidgets('Page has correct placeholder text constant',
        (WidgetTester tester) async {
      // Verify the placeholder text constant is correct
      expect(OptionAPage.placeholderText, 'Here is the start page');
    });

    testWidgets('Page renders with Material App', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: OptionAPage()));

      // Verify the page renders correctly
      expect(find.byType(OptionAPage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('AppBar has correct title', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: OptionAPage()));

      // Verify AppBar title
      final appBarFinder = find.byType(AppBar);
      expect(appBarFinder, findsOneWidget);

      final AppBar appBar = tester.widget(appBarFinder);
      final Text title = appBar.title as Text;
      expect(title.data, 'Option A');
    });

    testWidgets('Text is properly centered in body', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: OptionAPage()));

      // Find the Scaffold and verify its body is a Center widget
      final scaffoldFinder = find.byType(Scaffold);
      expect(scaffoldFinder, findsOneWidget);

      final Scaffold scaffold = tester.widget(scaffoldFinder);
      expect(scaffold.body, isA<Center>());
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbithub_based_project/pages/tabs_page.dart';

void main() {
  group('TabsPage', () {
    testWidgets('should display two tabs labeled Home and Settings',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: TabsPage()));

      // Verify Home tab is visible
      expect(find.text('Home'), findsOneWidget);
      
      // Verify Settings tab is visible
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('should have Home tab selected by default',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: TabsPage()));

      // Find the TabBar
      final tabBar = tester.widget<TabBar>(find.byType(TabBar));
      
      // Verify the controller is at index 0 (Home tab)
      expect(tabBar.controller?.index, 0);
    });

    testWidgets('should display Home tab content by default',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: TabsPage()));

      // Verify Home tab content is displayed
      expect(find.text('Home Tab'), findsOneWidget);
      expect(find.text('This is the Home tab content'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      
      // Verify Settings tab content is not visible
      expect(find.text('Settings Tab'), findsNothing);
    });

    testWidgets('should switch to Settings tab when clicked',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: TabsPage()));

      // Tap on Settings tab
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      // Verify Settings tab content is displayed
      expect(find.text('Settings Tab'), findsOneWidget);
      expect(find.text('This is the Settings tab content'), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
      
      // Verify Home tab content is not visible
      expect(find.text('Home Tab'), findsNothing);
    });

    testWidgets('should not affect Settings tab when Home tab is clicked',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: TabsPage()));

      // Home tab is already selected, tap on it again
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      // Verify Home tab content is still displayed
      expect(find.text('Home Tab'), findsOneWidget);
      
      // Settings tab should not be affected (not visible)
      expect(find.text('Settings Tab'), findsNothing);
    });

    testWidgets('should switch back to Home tab from Settings tab',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: TabsPage()));

      // Switch to Settings tab
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();
      expect(find.text('Settings Tab'), findsOneWidget);

      // Switch back to Home tab
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      // Verify Home tab content is displayed again
      expect(find.text('Home Tab'), findsOneWidget);
      expect(find.text('Settings Tab'), findsNothing);
    });

    testWidgets('should reset to Home tab when page is recreated',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: TabsPage()));

      // Switch to Settings tab
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();
      expect(find.text('Settings Tab'), findsOneWidget);

      // Simulate navigating away and returning by rebuilding the widget
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Container())));
      await tester.pumpAndSettle();
      
      await tester.pumpWidget(const MaterialApp(home: TabsPage()));
      await tester.pumpAndSettle();

      // Verify Home tab is selected by default
      final tabBar = tester.widget<TabBar>(find.byType(TabBar));
      expect(tabBar.controller?.index, 0);
      expect(find.text('Home Tab'), findsOneWidget);
    });
  });

  group('HomeTab', () {
    testWidgets('should display home icon and text',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeTab()));

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.text('Home Tab'), findsOneWidget);
      expect(find.text('This is the Home tab content'), findsOneWidget);
    });
  });

  group('SettingsTab', () {
    testWidgets('should display settings icon and text',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsTab()));

      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.text('Settings Tab'), findsOneWidget);
      expect(find.text('This is the Settings tab content'), findsOneWidget);
    });
  });
}

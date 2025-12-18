import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbit_hub_project/pages/tabs_page.dart';
import 'package:orbit_hub_project/services/theme_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TabsPage', () {
    late ThemeService themeService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      themeService = ThemeService();
      await themeService.initialize();
    });

    Widget createTestWidget() {
      return ChangeNotifierProvider<ThemeService>.value(
        value: themeService,
        child: MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeService.themeMode,
          home: const TabsPage(),
        ),
      );
    }

    group('UI Elements', () {
      testWidgets('should display app bar with title', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.text('Orbit Hub'), findsOneWidget);
      });

      testWidgets('should display two tabs: Main and Settings', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.text('Main'), findsOneWidget);
        expect(find.text('Settings'), findsOneWidget);
      });

      testWidgets('should display theme toggle button', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.byIcon(Icons.dark_mode), findsOneWidget);
      });

      testWidgets('should show Main tab content by default', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.text('Main Content'), findsOneWidget);
        expect(find.text('This is a placeholder for the Main tab content.'), findsOneWidget);
        expect(find.byIcon(Icons.home_outlined), findsOneWidget);
      });

      testWidgets('should have tab icons', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.byIcon(Icons.home), findsOneWidget);
        expect(find.byIcon(Icons.settings), findsOneWidget);
      });
    });

    group('Tab Navigation', () {
      testWidgets('should switch to Settings tab when clicked', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Initially on Main tab
        expect(find.text('Main Content'), findsOneWidget);

        // Tap Settings tab
        await tester.tap(find.text('Settings'));
        await tester.pumpAndSettle();

        // Should show Settings content
        expect(find.text('Settings'), findsWidgets);
        expect(find.text('This is a placeholder for the Settings tab content.'), findsOneWidget);
        expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
      });

      testWidgets('should switch back to Main tab when clicked', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Switch to Settings
        await tester.tap(find.text('Settings'));
        await tester.pumpAndSettle();

        // Switch back to Main
        await tester.tap(find.text('Main'));
        await tester.pumpAndSettle();

        // Should show Main content again
        expect(find.text('Main Content'), findsOneWidget);
        expect(find.text('This is a placeholder for the Main tab content.'), findsOneWidget);
      });

      testWidgets('should display correct placeholder content for Main tab', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.byIcon(Icons.home_outlined), findsOneWidget);
        expect(find.text('Main Content'), findsOneWidget);
        expect(find.text('This is a placeholder for the Main tab content.'), findsOneWidget);
      });

      testWidgets('should display correct placeholder content for Settings tab', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        await tester.tap(find.text('Settings'));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
        expect(find.text('This is a placeholder for the Settings tab content.'), findsOneWidget);
      });
    });

    group('Theme Switching', () {
      testWidgets('should display dark mode icon when in light theme', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(themeService.themeMode, ThemeMode.light);
        expect(find.byIcon(Icons.dark_mode), findsOneWidget);
      });

      testWidgets('should toggle to dark theme when icon is tapped', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(themeService.themeMode, ThemeMode.light);

        await tester.tap(find.byIcon(Icons.dark_mode));
        await tester.pumpAndSettle();

        expect(themeService.themeMode, ThemeMode.dark);
      });

      testWidgets('should display light mode icon when in dark theme', (WidgetTester tester) async {
        await themeService.setThemeMode(ThemeMode.dark);
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.light_mode), findsOneWidget);
      });

      testWidgets('should toggle to light theme from dark theme', (WidgetTester tester) async {
        await themeService.setThemeMode(ThemeMode.dark);
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.light_mode));
        await tester.pumpAndSettle();

        expect(themeService.themeMode, ThemeMode.light);
      });

      testWidgets('should show current theme in Settings tab', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        await tester.tap(find.text('Settings'));
        await tester.pumpAndSettle();

        expect(find.text('Current Theme: Light'), findsOneWidget);
      });

      testWidgets('should update theme display in Settings tab after toggle', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        await tester.tap(find.text('Settings'));
        await tester.pumpAndSettle();

        expect(find.text('Current Theme: Light'), findsOneWidget);

        // Toggle theme
        await tester.tap(find.byIcon(Icons.dark_mode));
        await tester.pumpAndSettle();

        expect(find.text('Current Theme: Dark'), findsOneWidget);
      });

      testWidgets('should have tooltip on theme toggle button', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final tooltipFinder = find.byWidgetPredicate(
          (widget) => widget is Tooltip && widget.message == 'Switch to Dark Mode',
        );

        expect(tooltipFinder, findsOneWidget);
      });
    });

    group('Error Handling', () {
      testWidgets('should display error message when theme toggle fails', (WidgetTester tester) async {
        // Create a service that will fail on toggle
        final failingService = ThemeService();
        // Don't initialize to cause failure

        await tester.pumpWidget(
          ChangeNotifierProvider<ThemeService>.value(
            value: failingService,
            child: MaterialApp(
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: failingService.themeMode,
              home: const TabsPage(),
            ),
          ),
        );

        // Try to toggle theme
        await tester.tap(find.byIcon(Icons.dark_mode));
        await tester.pumpAndSettle();

        // Should show error snackbar
        expect(find.text('Failed to switch theme: Exception: SharedPreferences not initialized'), findsOneWidget);
      });

      testWidgets('should keep previous theme when toggle fails', (WidgetTester tester) async {
        final failingService = ThemeService();
        final initialTheme = failingService.themeMode;

        await tester.pumpWidget(
          ChangeNotifierProvider<ThemeService>.value(
            value: failingService,
            child: MaterialApp(
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: failingService.themeMode,
              home: const TabsPage(),
            ),
          ),
        );

        await tester.tap(find.byIcon(Icons.dark_mode));
        await tester.pumpAndSettle();

        // Theme should remain the same
        expect(failingService.themeMode, initialTheme);
      });
    });

    group('Responsive Design', () {
      testWidgets('should adapt to small screen sizes', (WidgetTester tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Should find all UI elements on small screen
        expect(find.text('Main Content'), findsOneWidget);
        expect(find.byIcon(Icons.home_outlined), findsOneWidget);

        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      testWidgets('should adapt to large screen sizes', (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Should find all UI elements on large screen
        expect(find.text('Main Content'), findsOneWidget);
        expect(find.byIcon(Icons.home_outlined), findsOneWidget);

        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      testWidgets('should adjust padding on compact screens', (WidgetTester tester) async {
        tester.view.physicalSize = const Size(500, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final paddingWidget = tester.widget<Padding>(
          find.descendant(
            of: find.byType(TabsPage),
            matching: find.byType(Padding),
          ).first,
        );

        // Compact screens should use 16.0 padding
        expect(paddingWidget.padding, const EdgeInsets.all(16.0));

        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      testWidgets('should adjust padding on wide screens', (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1000, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final paddingWidget = tester.widget<Padding>(
          find.descendant(
            of: find.byType(TabsPage),
            matching: find.byType(Padding),
          ).first,
        );

        // Wide screens should use 32.0 padding
        expect(paddingWidget.padding, const EdgeInsets.all(32.0));

        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });

    group('Integration', () {
      testWidgets('should maintain tab state when theme changes', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Switch to Settings tab
        await tester.tap(find.text('Settings'));
        await tester.pumpAndSettle();

        expect(find.text('This is a placeholder for the Settings tab content.'), findsOneWidget);

        // Toggle theme
        await tester.tap(find.byIcon(Icons.dark_mode));
        await tester.pumpAndSettle();

        // Should still be on Settings tab
        expect(find.text('This is a placeholder for the Settings tab content.'), findsOneWidget);
      });

      testWidgets('should persist theme across tab switches', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Toggle to dark theme
        await tester.tap(find.byIcon(Icons.dark_mode));
        await tester.pumpAndSettle();

        expect(themeService.themeMode, ThemeMode.dark);

        // Switch tabs
        await tester.tap(find.text('Settings'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Main'));
        await tester.pumpAndSettle();

        // Theme should still be dark
        expect(themeService.themeMode, ThemeMode.dark);
      });
    });
  });
}

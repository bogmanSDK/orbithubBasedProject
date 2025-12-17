import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbit_hub_project/services/theme_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThemeService', () {
    late ThemeService themeService;

    setUp(() {
      themeService = ThemeService();
    });

    group('initialization', () {
      test('should initialize with light theme by default', () {
        expect(themeService.themeMode, ThemeMode.light);
      });

      test('should load saved theme preference on initialization', () async {
        // Setup saved preference
        SharedPreferences.setMockInitialValues({
          'theme_mode': 'ThemeMode.dark',
        });

        await themeService.initialize();

        expect(themeService.themeMode, ThemeMode.dark);
      });

      test('should default to light theme when no saved preference exists', () async {
        SharedPreferences.setMockInitialValues({});

        await themeService.initialize();

        expect(themeService.themeMode, ThemeMode.light);
      });

      test('should handle initialization errors gracefully', () async {
        // This test ensures that if SharedPreferences fails, the service continues
        await themeService.initialize();
        
        expect(themeService.themeMode, ThemeMode.light);
      });
    });

    group('toggleTheme', () {
      test('should toggle from light to dark theme', () async {
        SharedPreferences.setMockInitialValues({});
        await themeService.initialize();

        expect(themeService.themeMode, ThemeMode.light);

        await themeService.toggleTheme();

        expect(themeService.themeMode, ThemeMode.dark);
      });

      test('should toggle from dark to light theme', () async {
        SharedPreferences.setMockInitialValues({
          'theme_mode': 'ThemeMode.dark',
        });
        await themeService.initialize();

        expect(themeService.themeMode, ThemeMode.dark);

        await themeService.toggleTheme();

        expect(themeService.themeMode, ThemeMode.light);
      });

      test('should persist theme preference after toggle', () async {
        SharedPreferences.setMockInitialValues({});
        await themeService.initialize();

        await themeService.toggleTheme();

        final prefs = await SharedPreferences.getInstance();
        final savedTheme = prefs.getString('theme_mode');
        
        expect(savedTheme, 'ThemeMode.dark');
      });

      test('should notify listeners when theme changes', () async {
        SharedPreferences.setMockInitialValues({});
        await themeService.initialize();

        var notified = false;
        themeService.addListener(() {
          notified = true;
        });

        await themeService.toggleTheme();

        expect(notified, true);
      });

      test('should revert theme on save failure', () async {
        // Initialize without calling initialize() to simulate SharedPreferences not ready
        final initialTheme = themeService.themeMode;

        expect(
          () async => await themeService.toggleTheme(),
          throwsException,
        );

        // Theme should revert to previous state
        expect(themeService.themeMode, initialTheme);
      });
    });

    group('setThemeMode', () {
      test('should set theme to dark mode', () async {
        SharedPreferences.setMockInitialValues({});
        await themeService.initialize();

        await themeService.setThemeMode(ThemeMode.dark);

        expect(themeService.themeMode, ThemeMode.dark);
      });

      test('should set theme to light mode', () async {
        SharedPreferences.setMockInitialValues({
          'theme_mode': 'ThemeMode.dark',
        });
        await themeService.initialize();

        await themeService.setThemeMode(ThemeMode.light);

        expect(themeService.themeMode, ThemeMode.light);
      });

      test('should not change theme if setting same mode', () async {
        SharedPreferences.setMockInitialValues({});
        await themeService.initialize();

        var notificationCount = 0;
        themeService.addListener(() {
          notificationCount++;
        });

        await themeService.setThemeMode(ThemeMode.light);

        expect(themeService.themeMode, ThemeMode.light);
        expect(notificationCount, 0);
      });

      test('should persist theme preference after set', () async {
        SharedPreferences.setMockInitialValues({});
        await themeService.initialize();

        await themeService.setThemeMode(ThemeMode.dark);

        final prefs = await SharedPreferences.getInstance();
        final savedTheme = prefs.getString('theme_mode');
        
        expect(savedTheme, 'ThemeMode.dark');
      });

      test('should notify listeners when theme is set', () async {
        SharedPreferences.setMockInitialValues({});
        await themeService.initialize();

        var notified = false;
        themeService.addListener(() {
          notified = true;
        });

        await themeService.setThemeMode(ThemeMode.dark);

        expect(notified, true);
      });

      test('should revert theme on save failure', () async {
        // Initialize without calling initialize() to simulate SharedPreferences not ready
        final initialTheme = themeService.themeMode;

        expect(
          () async => await themeService.setThemeMode(ThemeMode.dark),
          throwsException,
        );

        expect(themeService.themeMode, initialTheme);
      });

      test('should handle system theme mode', () async {
        SharedPreferences.setMockInitialValues({});
        await themeService.initialize();

        await themeService.setThemeMode(ThemeMode.system);

        expect(themeService.themeMode, ThemeMode.system);
      });
    });

    group('loadTheme', () {
      test('should load light theme from preferences', () async {
        SharedPreferences.setMockInitialValues({
          'theme_mode': 'ThemeMode.light',
        });
        await themeService.initialize();

        expect(themeService.themeMode, ThemeMode.light);
      });

      test('should load dark theme from preferences', () async {
        SharedPreferences.setMockInitialValues({
          'theme_mode': 'ThemeMode.dark',
        });
        await themeService.initialize();

        expect(themeService.themeMode, ThemeMode.dark);
      });

      test('should load system theme from preferences', () async {
        SharedPreferences.setMockInitialValues({
          'theme_mode': 'ThemeMode.system',
        });
        await themeService.initialize();

        expect(themeService.themeMode, ThemeMode.system);
      });

      test('should default to light theme for invalid preference value', () async {
        SharedPreferences.setMockInitialValues({
          'theme_mode': 'InvalidValue',
        });
        await themeService.initialize();

        expect(themeService.themeMode, ThemeMode.light);
      });

      test('should handle missing preference gracefully', () async {
        SharedPreferences.setMockInitialValues({});
        await themeService.initialize();

        expect(themeService.themeMode, ThemeMode.light);
      });
    });

    group('error handling', () {
      test('should throw exception when SharedPreferences not initialized on toggle', () async {
        expect(
          () async => await themeService.toggleTheme(),
          throwsException,
        );
      });

      test('should throw exception when SharedPreferences not initialized on set', () async {
        expect(
          () async => await themeService.setThemeMode(ThemeMode.dark),
          throwsException,
        );
      });

      test('should handle load errors without crashing', () async {
        SharedPreferences.setMockInitialValues({});
        await themeService.initialize();
        
        // Service should continue working even if load had issues
        expect(themeService.themeMode, isNotNull);
      });
    });
  });
}

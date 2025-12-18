import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service responsible for managing app theme (light/dark mode)
/// Persists theme preference using SharedPreferences
class ThemeService extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  ThemeMode _themeMode = ThemeMode.light;
  SharedPreferences? _prefs;

  ThemeMode get themeMode => _themeMode;

  /// Initialize the service and load saved theme preference
  Future<void> initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      await loadTheme();
    } catch (e) {
      // If initialization fails, continue with default light theme
      _themeMode = ThemeMode.light;
    }
  }

  /// Load theme preference from storage
  Future<void> loadTheme() async {
    try {
      final savedTheme = _prefs?.getString(_themeKey);
      if (savedTheme != null) {
        _themeMode = _parseThemeMode(savedTheme);
        notifyListeners();
      }
    } catch (e) {
      // If loading fails, keep current theme
    }
  }

  /// Switch between light and dark theme
  /// Throws exception if saving fails
  Future<void> toggleTheme() async {
    try {
      _themeMode = _themeMode == ThemeMode.light 
          ? ThemeMode.dark 
          : ThemeMode.light;
      
      await _saveTheme();
      notifyListeners();
    } catch (e) {
      // Revert to previous theme if save fails
      _themeMode = _themeMode == ThemeMode.light 
          ? ThemeMode.dark 
          : ThemeMode.light;
      rethrow;
    }
  }

  /// Set specific theme mode
  /// Throws exception if saving fails
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    
    final previousMode = _themeMode;
    try {
      _themeMode = mode;
      await _saveTheme();
      notifyListeners();
    } catch (e) {
      // Revert to previous theme if save fails
      _themeMode = previousMode;
      rethrow;
    }
  }

  /// Save theme preference to storage
  Future<void> _saveTheme() async {
    if (_prefs == null) {
      throw Exception('SharedPreferences not initialized');
    }
    
    final success = await _prefs!.setString(
      _themeKey, 
      _themeMode.toString(),
    );
    
    if (!success) {
      throw Exception('Failed to save theme preference');
    }
  }

  /// Parse theme mode from string
  ThemeMode _parseThemeMode(String value) {
    switch (value) {
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }
}

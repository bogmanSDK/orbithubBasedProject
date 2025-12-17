import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:orbit_hub_project/services/theme_service.dart';
import 'package:orbit_hub_project/pages/tabs_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeService = ThemeService();
  await themeService.initialize();
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => themeService,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return MaterialApp(
          title: 'Orbit Hub Project',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
          ),
          themeMode: themeService.themeMode,
          home: const TabsPage(),
        );
      },
    );
  }
}

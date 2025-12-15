import 'package:flutter/material.dart';
import 'package:orbithub_based_project/pages/tabs_page.dart';
import 'package:orbithub_based_project/pages/login_page.dart';
import 'package:orbithub_based_project/services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OrbitHub Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AuthCheckPage(),
    );
  }
}

/// A page that checks authentication status and redirects accordingly
class AuthCheckPage extends StatelessWidget {
  const AuthCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    
    // Check if user is authenticated
    if (authService.isAuthenticated()) {
      return const TabsPage();
    } else {
      return const LoginPage();
    }
  }
}

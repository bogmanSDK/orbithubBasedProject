import 'package:flutter/material.dart';
import 'package:orbithub_based_project/services/auth_service.dart';
import 'package:orbithub_based_project/pages/tabs_page.dart';

/// Login page displayed when user is not authenticated
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Required'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Please log in to continue',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Log in the user
                AuthService().login();
                
                // Navigate to TabsPage
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const TabsPage()),
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

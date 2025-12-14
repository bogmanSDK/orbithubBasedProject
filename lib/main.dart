import 'package:flutter/material.dart';
import 'pages/option_a_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OrbitHub Based Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        OptionAPage.routeName: (context) => const OptionAPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select a section:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, OptionAPage.routeName);
              },
              child: const Text('Go to Option A'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Placeholder for other sections
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('This section is not available'),
                  ),
                );
              },
              child: const Text('Go to Option B'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Placeholder for other sections
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('This section is not available'),
                  ),
                );
              },
              child: const Text('Go to Option C'),
            ),
          ],
        ),
      ),
    );
  }
}

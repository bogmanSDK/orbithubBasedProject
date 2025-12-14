import 'package:flutter/material.dart';

/// Placeholder page for Option A section
/// Displays centered text "Here is the start page"
class OptionAPage extends StatelessWidget {
  const OptionAPage({super.key});

  static const String sectionName = 'Option A';
  static const String placeholderText = 'Here is the start page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(sectionName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text(
          placeholderText,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

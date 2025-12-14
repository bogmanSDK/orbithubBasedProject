import 'package:flutter/material.dart';

/// A placeholder page for Option A section
/// 
/// This page displays centered text "Here is the start page"
/// according to the specifications of Option A layout.
class OptionAPage extends StatelessWidget {
  const OptionAPage({super.key});

  static const String routeName = '/option-a';
  static const String displayText = 'Here is the start page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Option A'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text(
          displayText,
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:orbit_hub_project/services/theme_service.dart';

/// Main page with tabs for Main and Settings sections
/// Supports responsive design and theme switching
class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _themeError;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _toggleTheme() async {
    final themeService = context.read<ThemeService>();
    
    setState(() {
      _themeError = null;
    });

    try {
      await themeService.toggleTheme();
    } catch (e) {
      setState(() {
        _themeError = 'Failed to switch theme: ${e.toString()}';
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_themeError!),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();
    final isDarkMode = themeService.themeMode == ThemeMode.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orbit Hub'),
        actions: [
          Tooltip(
            message: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            child: IconButton(
              icon: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: _toggleTheme,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.home),
              text: 'Main',
            ),
            Tab(
              icon: Icon(Icons.settings),
              text: 'Settings',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _MainTab(isCompact: isCompact),
          _SettingsTab(isCompact: isCompact),
        ],
      ),
    );
  }
}

/// Main tab placeholder content
class _MainTab extends StatelessWidget {
  final bool isCompact;

  const _MainTab({required this.isCompact});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(isCompact ? 16.0 : 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home_outlined,
              size: isCompact ? 64 : 96,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: isCompact ? 16 : 24),
            Text(
              'Main Content',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isCompact ? 8 : 16),
            Text(
              'This is a placeholder for the Main tab content.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Settings tab placeholder content
class _SettingsTab extends StatelessWidget {
  final bool isCompact;

  const _SettingsTab({required this.isCompact});

  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();
    final isDarkMode = themeService.themeMode == ThemeMode.dark;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(isCompact ? 16.0 : 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.settings_outlined,
              size: isCompact ? 64 : 96,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: isCompact ? 16 : 24),
            Text(
              'Settings',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isCompact ? 8 : 16),
            Text(
              'This is a placeholder for the Settings tab content.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isCompact ? 24 : 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Current Theme: ${isDarkMode ? "Dark" : "Light"}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

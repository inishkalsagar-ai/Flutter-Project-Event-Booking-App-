import 'package:flutter/material.dart';
import '../app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ValueListenableBuilder<ThemeMode>(
        valueListenable: appThemeMode,
        builder: (context, mode, child) {
          return SwitchListTile(
            secondary: const Icon(Icons.dark_mode_outlined),
            title: const Text('Dark Mode'),
            subtitle: const Text('Change the app appearance'),
            value: mode == ThemeMode.dark,
            onChanged: (enabled) => appThemeMode.value =
                enabled ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gemini_app_project/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeThemeSwitch extends StatelessWidget {
  const ChangeThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    return Switch(
      value: theme.isDarkMode,
      onChanged: (value) {
        final themeProvider = context.read<ThemeProvider>();
        themeProvider.toggleTheme(value);
      },
    );
  }
}

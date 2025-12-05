import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_app/provider/theme_provider.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProviderModel>(context);
    return IconButton(
      onPressed: themeProvider.toggleTheme,
      icon: Icon(
        themeProvider.isDarkMode
            ? Icons.wb_sunny_outlined
            : Icons.nightlight_outlined,
      ),
    );
  }
}

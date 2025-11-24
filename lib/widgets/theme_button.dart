import 'package:flutter/material.dart';
import 'package:reader_app/provider/theme_provider.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key, required this.themeprovider});

  final ThemeProviderModel themeprovider;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: themeprovider.toggleTheme,
      icon: Icon(
        themeprovider.isDarkMode
            ? Icons.wb_sunny_outlined
            : Icons.nightlight_outlined,
      ),
    );
  }
}

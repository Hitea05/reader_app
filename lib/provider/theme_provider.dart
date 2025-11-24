import 'package:flutter/material.dart';

class ThemeProviderModel extends ChangeNotifier {
  bool _isDarkMode = false;

  get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData get currentTheme {
    return _isDarkMode ? darkTheme : lightTheme;
  }

  final darkTheme = ThemeData(
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.deepPurple,
    ),
    appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple),
    brightness: .dark,
    colorScheme: .fromSeed(brightness: .dark, seedColor: Colors.deepPurple),
    textTheme: TextTheme(
      titleMedium: TextStyle(fontWeight: .bold, fontSize: 24, letterSpacing: 1),
      displayMedium: TextStyle(fontWeight: .w600, fontSize: 18),
      displaySmall: TextStyle(fontWeight: .normal, fontSize: 16),
    ),
  );

  final lightTheme = ThemeData(
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.deepPurpleAccent[200],
    ),
    appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurpleAccent),
    brightness: .light,
    colorScheme: .fromSeed(
      brightness: .light,
      seedColor: Colors.deepPurpleAccent,
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(fontWeight: .bold, fontSize: 24, letterSpacing: 1),
      displayMedium: TextStyle(fontWeight: .w600, fontSize: 18),
      displaySmall: TextStyle(fontWeight: .normal, fontSize: 16),
    ),
  );
}

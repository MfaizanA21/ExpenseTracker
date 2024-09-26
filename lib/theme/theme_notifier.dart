import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = true;
  bool get isDarkMode => _isDarkMode;

  ThemeMode get currentThemeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
/*************  ✨ Codeium Command 🌟  *************/
}
# Miscellaneous
*.log
*.lock
*.sublime-project
*.sublime-workspace
# Flutter/Dart
*.freezed
*.g.dart
connect.lock
coverage/
flutter_*.log
ios/Flutter/Archives/
ios/Flutter/Debug.xcconfig
ios/Flutter/Release.xcconfig
packages/
pubspec.lock
/******  688c6805-64b1-4a1a-bec5-23d3555e6d45  *******/

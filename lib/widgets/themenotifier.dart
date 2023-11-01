import 'package:flutter/material.dart';
import 'theme.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _currentTheme = lightTheme;

  ThemeData get currentTheme => _currentTheme;

  ThemeData getTheme() {
    return _currentTheme;
  }

  void setTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}

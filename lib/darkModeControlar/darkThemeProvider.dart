import 'package:flutter/cupertino.dart';
import 'package:the_holy_quran/darkModeControlar/darkThemePref.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePref darkThemePref = DarkThemePref();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePref.setDarkTheme(value);

    notifyListeners();
  }
}

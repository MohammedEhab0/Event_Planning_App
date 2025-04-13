import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingProviders extends ChangeNotifier {
  String currentLanguage = 'ar';
  ThemeMode themeMode = ThemeMode.light;

  void changeLanguage(BuildContext context, String newLanguage) {
    if (newLanguage == currentLanguage) return;
    currentLanguage = newLanguage;
    context.setLocale(Locale(newLanguage));
    notifyListeners();
  }

  void changeTheme(ThemeMode newThemeMode) {
    if (newThemeMode == themeMode) return;
    themeMode = newThemeMode;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProviders extends ChangeNotifier {
  String currentLanguage = 'en';
  ThemeMode themeMode = ThemeMode.light;

  SettingProviders() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? savedLanguage = sharedPreference.getString('currentLanguage');
    if (savedLanguage != null) {
      currentLanguage = savedLanguage;
      }
}

  void changeLanguage(BuildContext context, String newLanguage) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    if (newLanguage == currentLanguage) return;

    await sharedPreference.setString('currentLanguage', newLanguage);
    currentLanguage = newLanguage;
    context.setLocale(Locale(currentLanguage));
    notifyListeners();
  }

  void changeTheme(ThemeMode newThemeMode) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    if (newThemeMode == themeMode) return;

    themeMode = newThemeMode;
    await sharedPreference.setString('themeMode', newThemeMode.toString());
    notifyListeners();
  }
}
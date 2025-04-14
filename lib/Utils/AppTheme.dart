import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';

import 'AppColors.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
      secondaryHeaderColor: AppColors.primaryDark,
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.primaryDark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showUnselectedLabels: true,
          selectedItemColor: AppColors.white,
          selectedLabelStyle: AppStyle.bold12White,
          unselectedLabelStyle: AppStyle.bold12White));
  static final ThemeData lightTheme = ThemeData(
      secondaryHeaderColor: AppColors.white,
      primaryColor: AppColors.primarylight,
      scaffoldBackgroundColor: AppColors.backgroundlight,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showUnselectedLabels: true,
          selectedItemColor: AppColors.white,
          selectedLabelStyle: AppStyle.bold12White,
          unselectedLabelStyle: AppStyle.bold12White));
}

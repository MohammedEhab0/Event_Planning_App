import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Utils/AppColors.dart';
import '../../Utils/AppStyle.dart';
import 'package:event_planning_app/Providers/SettingProviders.dart';

class ToggleTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var settingProviders = Provider.of<SettingProviders>(context);
    bool isDark = settingProviders.themeMode == ThemeMode.dark;

    return AnimatedToggleSwitch<bool>.dual(
      current: isDark,
      first: false,
      second: true,
      height: 40,
      style: ToggleStyle(
        backgroundColor: AppColors.primarylight.withOpacity(0.2),
        borderColor: AppColors.primarylight,
        borderRadius: BorderRadius.circular(20),
        indicatorColor: AppColors.primarylight,
      ),
      onChanged: (val) {
        settingProviders.changeTheme(val ? ThemeMode.dark : ThemeMode.light);
      },
      iconBuilder: (val) => Icon(
        val ? Icons.nightlight : Icons.sunny,
        color: AppColors.white,
        size: 20,
      ),
      textBuilder: (val) => Text(
        val ? tr('dark') : tr('light'),
        style: AppStyle.bold16White,
      ),
    );
  }
}

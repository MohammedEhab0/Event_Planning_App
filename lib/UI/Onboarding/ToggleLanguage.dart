import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';
import '../../Utils/AppColors.dart';
import '../../Utils/AppStyle.dart';
import 'package:event_planning_app/Providers/SettingProviders.dart';

class ToggleLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var settingProviders = Provider.of<SettingProviders>(context);
    return LiteRollingSwitch(
      width: 100,
      textSize: 16,
      textOnColor: AppColors.white,
      textOffColor: AppColors.white,
      colorOff: AppColors.primarylight,
      colorOn: AppColors.primarylight,
      textOn: 'arabic'.tr(),
      textOff: 'english'.tr(),
      iconOn: Icons.language,
      iconOff: Icons.language,
      onTap: () {},
      onDoubleTap: () {},
      onSwipe: () {},
      onChanged: (bool isOn) {
        settingProviders.changeLanguage(context,isOn ? 'ar' : 'en',);
      },
    );
  }
}

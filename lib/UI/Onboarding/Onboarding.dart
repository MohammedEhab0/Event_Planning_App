import 'package:event_planning_app/Providers/SettingProviders.dart';
import 'package:event_planning_app/UI/Onboarding/IntroScreen.dart';
import 'package:event_planning_app/UI/Onboarding/ToggleLanguage.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../../Utils/AppStyle.dart';
import 'ToggleTheme.dart';

class Onboarding extends StatefulWidget {
  static const routeName = 'Onboarding';

  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    var settingProviders = Provider.of<SettingProviders>(context);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Image.asset(AppAssets.logo),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.05, horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.Onboarding),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'personalize',
                  style: AppStyle.bold20PrimaryLight,
                ).tr(),
              ),

              // Description Text
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'prg_personalize', // This should also be translated
                  style: AppStyle.light16Black,
                ).tr(),
              ),

              // SwitchButton for language
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'language',
                        style: AppStyle.light20PrimaryLight,
                      ).tr(),
                      ToggleLanguage(),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'theme',
                        style: AppStyle.light20PrimaryLight,
                      ).tr(),
                      ToggleTheme()
                    ]),

              ),  SizedBox(height: height * .02),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.symmetric(
                          vertical: height * .02, horizontal: width * .08),
                      backgroundColor: AppColors.primarylight),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(IntroScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'start'.tr(),
                        style: AppStyle.bold20White,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

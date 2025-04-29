import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeScreen.dart';
import 'package:event_planning_app/UI/Login/ForgetPassword.dart';
import 'package:event_planning_app/UI/Onboarding/ToggleLanguage.dart';
import 'package:event_planning_app/UI/Register/Register.dart';
import 'package:event_planning_app/UI/Widgets/CustomElevatedButton.dart';
import 'package:event_planning_app/UI/Widgets/CustomTextField.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Login extends StatelessWidget {
  static const routeName = 'Login';

  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: height * .04,
                ),
                Container(
                  height: height * .25,
                  child: Image.asset(AppAssets.logoSplash),
                ),
                SizedBox(
                  height: height * .05,
                ),
                CustomTextField(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'email'.tr(),
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: height * .03,
                ),
                CustomTextField(
                  prefixIcon: Icon(Icons.password),
                  hintText: 'password'.tr(),
                  textInputType: TextInputType.visiblePassword,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ForgetPassword.routeName);
                        },
                        child: Text(
                          'forget password'.tr(),
                          style: AppStyle.bold16PrimaryLight.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primarylight),
                        )),
                    SizedBox(
                      height: height * .03,
                    ),
                  ],
                ),
                CustomElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routeName);
                    }, textButton: "login".tr()),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'do not have account'.tr(),
                      style: AppStyle.bold16Black,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Register.routeName);
                        },
                        child: Text(
                          'create account'.tr(),
                          style: AppStyle.bold16PrimaryLight.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primarylight),
                        )),
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1.5,
                        color: AppColors.primarylight,
                        indent: width * .04,
                        endIndent: width * .04,
                      ),
                    ),
                    Text(
                      'or'.tr(),
                      style: AppStyle.light20PrimaryLight,
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1.5,
                        color: AppColors.primarylight,
                        indent: width * .04,
                        endIndent: width * .04,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleLanguage(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/UI/Login/Login.dart';
import 'package:event_planning_app/UI/Onboarding/ToggleLanguage.dart';
import 'package:event_planning_app/UI/Widgets/CustomElevatedButton.dart';
import 'package:event_planning_app/UI/Widgets/CustomTextField.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Register extends StatelessWidget {
  static const routeName = 'Register';

  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(color: AppColors.black),elevation: 0, backgroundColor: Colors.transparent,
        title: Text('register'.tr(),style: AppStyle.bold20Black,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: height * .05,
                ),
                Container(
                  height: height * .23,
                  child: Image.asset(AppAssets.logoSplash),
                ),
                SizedBox(
                  height: height * .05,
                ),
                CustomTextField(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'name'.tr(),
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: height * .02,
                ),
                CustomTextField(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'email'.tr(),
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: height * .02,
                ),
                CustomTextField(
                  prefixIcon: Icon(Icons.password),
                  hintText: 'password'.tr(),
                  textInputType: TextInputType.visiblePassword,
                ),
                SizedBox(
                  height: height * .02,
                ),
                CustomTextField(
                  prefixIcon: Icon(Icons.password),
                  hintText: 're password'.tr(),
                  textInputType: TextInputType.visiblePassword,
                ),
                SizedBox(
                  height: height * .02,
                ),
                CustomElevatedButton(
                    onPressed: () {}, textButton: "create account".tr()),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have account'.tr(),
                      style: AppStyle.bold16Black,
                    ),
                    TextButton(
                        onPressed: () {Navigator.of(context).pushNamed( Login.routeName);},
                        child: Text(
                          'login'.tr(),
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

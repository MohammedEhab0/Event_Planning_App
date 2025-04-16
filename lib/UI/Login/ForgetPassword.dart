import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/UI/Login/Login.dart';
import 'package:event_planning_app/UI/Onboarding/ToggleLanguage.dart';
import 'package:event_planning_app/UI/Widgets/CustomElevatedButton.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ForgetPassword extends StatelessWidget {
  static const routeName = 'ForgetPassword';

  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(color: AppColors.black),elevation: 0, backgroundColor: Colors.transparent,
        title: Text('ForgetPassword'.tr(),style: AppStyle.bold20Black,),
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
            Image.asset(AppAssets.forgetPassword),
                SizedBox(
                  height: height * .05,
                ),
                CustomElevatedButton(
                    onPressed: () {}, textButton: "reset password".tr()),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


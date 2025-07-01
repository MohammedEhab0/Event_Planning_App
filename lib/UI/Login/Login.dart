import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/Modal/MyUser.dart';
import 'package:event_planning_app/Providers/EventListProvider.dart';
import 'package:event_planning_app/Providers/UserProvider.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeScreen.dart';
import 'package:event_planning_app/UI/Login/ForgetPassword.dart';
import 'package:event_planning_app/UI/Login/LoginNavigator.dart';
import 'package:event_planning_app/UI/Login/LoginViewModel.dart';
import 'package:event_planning_app/UI/Onboarding/ToggleLanguage.dart';
import 'package:event_planning_app/UI/Register/Register.dart';
import 'package:event_planning_app/UI/Widgets/CustomElevatedButton.dart';
import 'package:event_planning_app/UI/Widgets/CustomTextField.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:event_planning_app/Utils/DialogUtils.dart';
import 'package:event_planning_app/Utils/FireBaseUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const routeName = 'Login';

  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> implements LoginNavigator{

@override
  void initState() {
    // TODO: implement initState
    viewModel.loginNav= this;
    super.initState();

  }
  LoginViewModel viewModel = LoginViewModel();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: ( context) => viewModel,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .04),
              child: Form(
                key: viewModel.formKey,
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
                      controller: viewModel.emailController,
                      prefixIcon: Icon(Icons.email),
                      hintText: 'email'.tr(),
                      textInputType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "please enter email";
                        }
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return "please enter valid email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    CustomTextField(
                      controller: viewModel.passwordController,
                      obscureText: true,
                      prefixIcon: Icon(Icons.password),
                      hintText: 'password'.tr(),
                      textInputType: TextInputType.phone,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "please enter password";
                        }
                        if (text.length < 6) {
                          return "please enter more 6 character in  password";
                        }

                        return null;
                      },
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
                          viewModel.login(context);
                        },
                        textButton: "login".tr()),
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
                              Navigator.of(context)
                                  .pushReplacementNamed(Register.routeName);
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
        ),
      ),
    );
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
    DialogUtils.hideLoading(context: context);
  }

@override
void showLoading({ required String message}) {
  // TODO: implement showLoading
  DialogUtils.showLoading(context: context, message: message);
}

@override
void showMessage({ required String message}) {
  // TODO: implement showMessage
  DialogUtils.showMessage(
      context: context,
      message: message,
      positiveAction: true,
      onPositiveAction: navigate);
}

@override
void navigate() {
  // TODO: implement navigate
Navigator.of(context).pop((Route<dynamic> route) => false,);
}

}

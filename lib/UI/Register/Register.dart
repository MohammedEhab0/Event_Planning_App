import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/Modal/MyUser.dart';
import 'package:event_planning_app/Providers/EventListProvider.dart';
import 'package:event_planning_app/Providers/UserProvider.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeScreen.dart';
import 'package:event_planning_app/UI/Login/Login.dart';
import 'package:event_planning_app/UI/Onboarding/ToggleLanguage.dart';
import 'package:event_planning_app/UI/Register/RegisterNavigator.dart';
import 'package:event_planning_app/UI/Register/Register_viewModel.dart';
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

class Register extends StatefulWidget {
  static const routeName = 'Register';

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> implements RegisterNavigator{

  @override
  void initState() {
    // TODO: implement initState
    viewModel.registerNavigator=this;
    super.initState();
  }
  RegisterViewModel viewModel = RegisterViewModel();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'register'.tr(),
            style: AppStyle.bold20Black,
          ),
          centerTitle: true,
        ),
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
                      controller: viewModel.nameController,
                      prefixIcon: Icon(Icons.person),
                      hintText: 'name'.tr(),
                      textInputType: TextInputType.name,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "please enter name";
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * .02,
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
                      height: height * .02,
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
                      height: height * .02,
                    ),
                    CustomTextField(
                      controller: viewModel.rePasswordController,
                      obscureText: true,
                      prefixIcon: Icon(Icons.password),
                      hintText: 're password'.tr(),
                      textInputType: TextInputType.phone,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "please enter password";
                        }
                        if (text.length < 6) {
                          return "please enter more 6 character in  password";
                        }
                        if (text != viewModel.passwordController.text) {
                          return "please  match password";
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    CustomElevatedButton(
                        onPressed:()=>viewModel.register(context),
                        textButton: "create account".tr()),
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
                            onPressed: () {
                              Navigator.of(context).pushNamed(Login.routeName);
                            },
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
    Navigator.of(context).pushNamedAndRemoveUntil(
      HomeScreen.routeName,
          (Route<dynamic> route) => false,
    );
  }
}

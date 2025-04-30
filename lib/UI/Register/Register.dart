import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeScreen.dart';
import 'package:event_planning_app/UI/Login/Login.dart';
import 'package:event_planning_app/UI/Onboarding/ToggleLanguage.dart';
import 'package:event_planning_app/UI/Widgets/CustomElevatedButton.dart';
import 'package:event_planning_app/UI/Widgets/CustomTextField.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:event_planning_app/Utils/DialogUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Register extends StatefulWidget {
  static const routeName = 'Register';

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController(text: 'moooooo');
  TextEditingController emailController = TextEditingController(text: 'mo@mo.com');
  TextEditingController passwordController = TextEditingController(text: '123456');
  TextEditingController rePasswordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
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
              key: formKey,
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
                  CustomTextField(controller: nameController,
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
                    controller: emailController,
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
                    controller: passwordController,
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
                    controller: rePasswordController,
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
                      if (text != passwordController.text) {
                        return "please  match password";
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  CustomElevatedButton(
                      onPressed: (){register();},
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
    );
  }

  register() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context: context, message: '...Waiting ');
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(context: context, message: 'Register successfully',positiveAction: true,onPositiveAction: (){
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });

        print('Register successfully: ${credential.user?.uid}');

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        } else {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(context: context, message: 'Register faild ',negativeAction: true,onNegativeAction: (){
            Navigator.of(context).pop();
          });
          print('FirebaseAuthException: ${e.message}');
        }
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(context: context, message: 'Register faild ',negativeAction: true,onNegativeAction: (){
          Navigator.of(context).pop();
        });

        print('Error: $e');
      }
    }
  }
}

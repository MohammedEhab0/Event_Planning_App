import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/Modal/MyUser.dart';
import 'package:event_planning_app/Providers/EventListProvider.dart';
import 'package:event_planning_app/Providers/UserProvider.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeScreen.dart';
import 'package:event_planning_app/UI/Login/ForgetPassword.dart';
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

class _LoginState extends State<Login> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController =
      TextEditingController(text: 'mo@mo.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
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
                    height: height * .03,
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
                        login();
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
    );
  }

  login() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context: context, message: '...Loading');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        MyUser? user= await FireBaseUtils.readUserFromFireStore(credential.user?.uid??'');
        if(user == null){
          return;
        }
        var userProvider=Provider.of<UserProvider>(context,listen: false);
        userProvider.updateUser(user);
        var eventListProvider=Provider.of<EventListProvider>(context,listen: false);
        eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
        eventListProvider.getFavoriteEvents( userProvider.currentUser!.id);
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
            context: context,
            message: 'Login successfully',
            positiveAction: true,
            onPositiveAction: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName,
                    (Route<dynamic> route) => false,
              );});
        print('Login successfully ');
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
              context: context,
              message: 'Login faild ',
              negativeAction: true,
              onNegativeAction: () {
                Navigator.of(context).pop();
              });
          print('No user found for that email.');
        } else if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
              context: context,
              message: 'Login faild ',
              negativeAction: true,
              onNegativeAction: () {
                Navigator.of(context).pop();
              });
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
            context: context,
            message: 'Login faild ',
            negativeAction: true,
            onNegativeAction: () {
              Navigator.of(context).pop();
            });
        print('Error: $e');
      }
    }
  }
}

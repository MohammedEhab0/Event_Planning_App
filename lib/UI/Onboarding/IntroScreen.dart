import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeScreen.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  static const routeName = 'introScreen';

  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return IntroductionScreen(
      globalBackgroundColor: Theme.of(context).secondaryHeaderColor,
      allowImplicitScrolling: false,
      globalHeader: Align(
        alignment: Alignment.center,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(AppAssets.logo),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          decoration: PageDecoration(pageMargin: EdgeInsets.only(top:height*.15 ),
              titleTextStyle: AppStyle.bold20PrimaryLight,bodyTextStyle: AppStyle.bold16Black,),
          title: "Inspire".tr(),
          body: "Inspire_p".tr(),
          image: Image.asset(AppAssets.intro1),
        ),
        PageViewModel( decoration: PageDecoration(pageMargin: EdgeInsets.only(top:height*.15 ),
          titleTextStyle: AppStyle.bold20PrimaryLight,bodyTextStyle: AppStyle.bold16Black,),
          title: "Effortless".tr(),
          body: "Effortless_p".tr(),
          image: Image.asset(AppAssets.intro2),
        ),
        PageViewModel( decoration: PageDecoration(pageMargin: EdgeInsets.only(top:height*.15 ),
          titleTextStyle: AppStyle.bold20PrimaryLight,bodyTextStyle: AppStyle.bold16Black,),
          title: "Connect".tr(),
          body: "Connect_p".tr(),
          image: Image.asset(AppAssets.intro3),
        ),
      ],
      onDone: () {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      },
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: Icon(
        Icons.arrow_back,
        color: AppColors.primarylight,
      ),
      next: Icon(
        Icons.arrow_forward_outlined,
        color: AppColors.primarylight,
      ),
      done: Icon(
        Icons.arrow_forward_outlined,
        color: AppColors.primarylight,
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: AppColors.primarylight,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: ShapeDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

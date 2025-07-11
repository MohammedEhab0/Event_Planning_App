import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/Providers/EventListProvider.dart';
import 'package:event_planning_app/Providers/UserProvider.dart';
import 'package:event_planning_app/UI/HomeScreen/CreateEvent/CreateEvent.dart';
import 'package:event_planning_app/UI/HomeScreen/EventDetails/EditEvent.dart';
import 'package:event_planning_app/UI/HomeScreen/EventDetails/EventDetails.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeScreen.dart';
import 'package:event_planning_app/UI/Login/ForgetPassword.dart';
import 'package:event_planning_app/UI/Register/Register.dart';
import 'package:event_planning_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:event_planning_app/UI/Onboarding/IntroScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'UI/HomeScreen/CreateEvent/CreateEventProvider.dart';
import 'UI/HomeScreen/CreateEvent/PickLocationScreen.dart';
import 'UI/HomeScreen/MapTab/MapTabProvider.dart';
import 'UI/Onboarding/Onboarding.dart';
import 'Utils/AppTheme.dart';
import 'Providers/SettingProviders.dart';
import 'package:event_planning_app/UI/Login/Login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Optionally disable network if needed
   // await FirebaseFirestore.instance.disableNetwork();
  } catch (e) {
    print("Error initializing Firebase: $e");
    // Handle the error appropriately (e.g., show an error message)
  }

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      startLocale: Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SettingProviders()),
          ChangeNotifierProvider(create: (context) => EventListProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => CreateEventProvider()),
          ChangeNotifierProvider(create: (context) => MapsTabProvider()

          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var settingProviders = Provider.of<SettingProviders>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode: settingProviders.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      title: 'EventPlanningApp',
      initialRoute: Onboarding.routeName,
      routes: {
        Onboarding.routeName: (context) => const Onboarding(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        IntroScreen.routeName: (context) => const IntroScreen(),
        CreateEvent.routeName: (context) => CreateEvent(),
        Login.routeName: (context) => Login(),
        Register.routeName: (context) => Register(),
        ForgetPassword.routeName: (context) => ForgetPassword(),
        EventDetails.routeName:(context) => EventDetails(),
        EditEvent.routeName:(context) => EditEvent(),
        PickLocationScreen.routeName:(context) => PickLocationScreen(),
      },
    );
  }
}
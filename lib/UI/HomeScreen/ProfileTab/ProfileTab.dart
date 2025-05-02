import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/UI/Login/Login.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:event_planning_app/Providers/SettingProviders.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final List<String> languageItems = ['english'.tr(), 'arabic'.tr()];

  final List<String> themeItems = [
    'light'.tr(),
    'dark'.tr(),
  ];

  String? selectedlanguageValue;

  String? selectedthemeValue;

  @override
  @override
  Widget build(BuildContext context) {
    var settingProviders = Provider.of<SettingProviders>(context);

    final width = MediaQuery.of(context).size.width;

    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(52)),
        ),
        toolbarHeight: height * .21,
        backgroundColor: AppColors.primarylight,
        title: Row(
          children: [
            Image.asset(AppAssets.routeProfile),
            SizedBox(width: width * .05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * .005),
                Row(
                  children: [
                    Text(
                      'Route ',
                      style: AppStyle.bold28White,
                    ),
                  ],
                ),
                SizedBox(height: height * .01),
                Text(
                  'Welcome ✨',
                  style: AppStyle.bold14White,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(height * .02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: height * .01),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Row(
                  children: [
                    Icon(Icons.language,
                        size: 16, color: AppColors.primarylight),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'language'.tr(),
                        style: AppStyle.bold14PrimaryLight,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: languageItems
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: AppStyle.bold14PrimaryLight,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: selectedlanguageValue,
                onChanged: (value) {
                  setState(() {
                    selectedlanguageValue = value;

                    if (selectedlanguageValue == 'arabic'.tr()) {
                      settingProviders.changeLanguage(context, 'ar');
                    } else {
                      settingProviders.changeLanguage(context, 'en');
                    }
                  });
                },
                buttonStyleData: ButtonStyleData(
                  height: height * .07,
                  width: width * .95,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primarylight,
                    ),
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                  elevation: 2,
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                  ),
                  iconSize: 20,
                  iconEnabledColor: AppColors.primarylight,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: height * .3,
                  width: width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all(6),
                    thumbVisibility: MaterialStateProperty.all(true),
                  ),
                ),
                menuItemStyleData: MenuItemStyleData(
                  height: height * .1,
                ),
              ),
            ),
            SizedBox(height: height * .01),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Row(
                  children: [
                    Icon(Icons.sunny, size: 16, color: AppColors.primarylight),
                    SizedBox(width: 4),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'theme'.tr(),
                            style: AppStyle.bold14PrimaryLight,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                items: themeItems
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: AppStyle.bold14PrimaryLight,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: selectedthemeValue,
                onChanged: (value) {
                  setState(() {
                    selectedthemeValue = value;
                    if (selectedthemeValue == 'dark'.tr()) {
                      settingProviders.changeTheme(ThemeMode.dark);
                    } else {
                      settingProviders.changeTheme(ThemeMode.light);
                    }
                  });
                },
                buttonStyleData: ButtonStyleData(
                  height: height * .07,
                  width: width * .95,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primarylight,
                    ),
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                  elevation: 2,
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                  ),
                  iconSize: 20,
                  iconEnabledColor: AppColors.primarylight,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: height * .3,
                  width: width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all(6),
                    thumbVisibility: MaterialStateProperty.all(true),
                  ),
                ),
                menuItemStyleData: MenuItemStyleData(
                  height: height * .1,
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(
                        vertical: height * .02, horizontal: width * .08),
                    backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Login.routeName);
                },
                child: Row(
                  children: [
                    Text(
                      'logOut'.tr(),
                      style: AppStyle.bold20White,
                    ),
                    SizedBox(width: width * .05),
                    Icon(
                      Icons.login_outlined,
                      color: AppColors.white,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

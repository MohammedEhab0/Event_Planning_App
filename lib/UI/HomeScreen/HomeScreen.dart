import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/HomeTab.dart';
import 'package:event_planning_app/UI/HomeScreen/MapTab/MapTab.dart';
import 'package:event_planning_app/UI/HomeScreen/ProfileTab/ProfileTab.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/UI/HomeScreen/HeartTab/HeartTab.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectIndex = 0;

  final List<Widget> bottomTabsList = [
    HomeTab(),
    MapTab(),
    HeartTab(),
    ProfileTab(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomTabsList[selectIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Theme.of(context).primaryColor),
        child: BottomAppBar(padding: EdgeInsets.zero,
          notchMargin: 4,
          shape: CircularNotchedRectangle(),
          color: AppColors.gray,
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: selectIndex,
            onTap: (index) {
              setState(() {
                selectIndex = index;
              });
            },
            items: [
              customBottomNavigationBarItem(
                index: 0,
                image: selectIndex == 0 ? AppAssets.home1 : AppAssets.home,
                imageName: 'home'.tr(),
              ),
              customBottomNavigationBarItem(
                index: 1,
                image: selectIndex == 1 ? AppAssets.map1 : AppAssets.map,
                imageName: 'map'.tr(),
              ),
              customBottomNavigationBarItem(
                index: 2,
                image: selectIndex == 2 ? AppAssets.heart1 : AppAssets.heart,
                imageName: 'heart'.tr(),
              ),
              customBottomNavigationBarItem(
                index: 3,
                image: selectIndex == 3 ? AppAssets.user1 : AppAssets.user,
                imageName: 'user'.tr(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          shape:
              StadiumBorder(side: BorderSide(width: 5, color: AppColors.white)),
          elevation: 0,
          onPressed: () {},
          child: Icon(
            Icons.add,
            size: 30,
            color: AppColors.white,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomNavigationBarItem customBottomNavigationBarItem({
    required int index,
    required String image,
    required String imageName,
  }) {
    return BottomNavigationBarItem(
      label: imageName,
      icon: ImageIcon(AssetImage(image)),
    );
  }
}

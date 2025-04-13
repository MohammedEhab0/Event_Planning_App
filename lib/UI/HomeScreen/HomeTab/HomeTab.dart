import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/EventItem.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/TabBarItem.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/TabBarData.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
  final List<TabBarData> tabBarList = [
    TabBarData(text: "All".tr(), iconTab: Icons.adjust_sharp),
    TabBarData(text: "Sport".tr(), iconTab: Icons.directions_bike_sharp),
    TabBarData(text: "Birthday".tr(), iconTab: Icons.cake),
    TabBarData(text: "Meeting".tr(), iconTab: Icons.business_center),
    TabBarData(text: "Gaming".tr(), iconTab: Icons.videogame_asset),
    TabBarData(text: "Workshop".tr(), iconTab: Icons.work),
    TabBarData(text: "Book Club".tr(), iconTab: Icons.book),
    TabBarData(text: "Exhibition".tr(), iconTab: Icons.photo),
    TabBarData(text: "Holiday".tr(), iconTab: Icons.beach_access),
    TabBarData(text: "Eating".tr(), iconTab: Icons.restaurant),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primarylight,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * .01),
                Text(
                  'Welcome Back ✨ ',
                  style: AppStyle.bold14White,
                ),
                SizedBox(height: height * .005),
                Text(
                  'Route Route  ',
                  style: AppStyle.bold24White,
                ),
              ],
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.all(height * .01),
              child: Icon(Icons.wb_sunny_outlined),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundlight,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.all(height * .01),
              padding: EdgeInsets.all(height * .01),
              child: Text(
                'En',
                style: AppStyle.light20PrimaryLight,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * .04),
            height: height * .136,
            decoration: BoxDecoration(
              color: AppColors.primarylight,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: height * .007),
                Row(
                  children: [
                    ImageIcon(
                      AssetImage(AppAssets.map),
                      color: AppColors.backgroundlight,
                    ),
                    Text(
                      'Cairo, Egypt ',
                      style: AppStyle.bold14White,
                    ),
                  ],
                ),
                SizedBox(height: height * .01),
                DefaultTabController(
                  length: tabBarList.length,
                  child: TabBar(
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    labelPadding: EdgeInsets.all(height * .01),
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    tabs: tabBarList
                        .map((e) => TabBarItem(
                              text: e.text,
                              tabIcon: e.iconTab,
                              isSelected: selectedIndex == tabBarList.indexOf(e)
                                  ? true
                                  : false,
                            ))
                        .toList(),
                  ),
                ),

              ],

            ),
          ), Expanded(
              child: ListView.separated(padding: EdgeInsets.symmetric(vertical:  height * .02),
                  itemBuilder: (context, index) {
                    return EventItem();
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: height * .03);
                  },
                  itemCount: 10))
        ],
      ),
    );
  }
}

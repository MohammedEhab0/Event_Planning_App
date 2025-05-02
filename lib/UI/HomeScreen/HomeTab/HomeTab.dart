import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/Modal/Event.dart';
import 'package:event_planning_app/Providers/EventListProvider.dart';
import 'package:event_planning_app/Providers/UserProvider.dart';
import 'package:event_planning_app/UI/HomeScreen/EventDetails/EventDetails.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/EventItem.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/EventBarItem.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/TabBarData.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var eventListProvider = Provider.of<EventListProvider>(context);

    if (eventListProvider.eventList.isEmpty) {
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
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
                  userProvider.currentUser!.name??'',
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
              color: Theme.of(context).primaryColor,
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
                  length: eventListProvider.tabBarList.length,
                  child: TabBar(
                    onTap: (index) {
                      eventListProvider.changeSelectedIndex(index,userProvider.currentUser!.id);
                    },
                    labelPadding: EdgeInsets.all(height * .01),
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    tabs: eventListProvider.tabBarList
                        .map((e) => EventBarItem(
                              textSelectedStyle: AppStyle.bold16PrimaryLight,
                              textUnSelectedStyle: AppStyle.bold16White,
                              unSelectedColor: AppColors.primarylight,
                              selectedColor: AppColors.white,
                              text: e.text,
                              tabIcon: e.iconTab!,
                              isSelected: eventListProvider.selectedIndex ==
                                      eventListProvider.tabBarList.indexOf(e)
                                  ? true
                                  : false,
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: eventListProvider.filterList.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      child: Text(
                        'no Events here ',
                        style: AppStyle.bold20Black,
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: height * .02),
                      itemBuilder: (context, index) {
                        return InkWell(onTap: (){
                          Navigator.of(context).pushNamed(EventDetails.routeName,
                              arguments: eventListProvider.filterList[index]);
                        },
                            child: EventItem(
                          event: eventListProvider.filterList[index],
                        ));
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: height * .03);
                      },
                      itemCount: eventListProvider.filterList.length))
        ],
      ),
    );
  }
}

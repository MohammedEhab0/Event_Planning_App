import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/Modal/Event.dart';
import 'package:event_planning_app/Providers/EventListProvider.dart';
import 'package:event_planning_app/Providers/UserProvider.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  Event event;

  EventItem({required this.event});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Container(
      width: double.infinity,
      height: height * .26,
      margin: EdgeInsets.symmetric(horizontal: width * .04),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * .03, vertical: height * .008),
            margin: EdgeInsets.all(width * .025),
            decoration: BoxDecoration(
                color: AppColors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.date.day.toString(),
                  style: AppStyle.bold20PrimaryLight,
                ),
                Text(
                  DateFormat('MMM').format(event.date),
                  style: AppStyle.bold14PrimaryLight,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * .04, vertical: height * .008),
            margin: EdgeInsets.all(width * .02),
            decoration: BoxDecoration(
                color: AppColors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    style: AppStyle.bold14PrimaryLight,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    eventListProvider.updateIsFavoriteEvent(event,userProvider.currentUser!.id);
                    eventListProvider.getFavoriteEvents(userProvider.currentUser!.id);
                  },
                  icon: Image.asset(
                    event.isFavorite == true
                        ? AppAssets.heart1
                        : AppAssets.heart,
                    color: AppColors.primarylight,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
              image: AssetImage(
                event.image,
              ),
              fit: BoxFit.fill)),
    );
  }
}

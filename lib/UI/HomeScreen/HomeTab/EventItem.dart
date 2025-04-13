import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '21',
                  style: AppStyle.bold20PrimaryLight,
                ),
                Text(
                  'nov',
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
                    'llllllllllllllllllll',
                    style: AppStyle.bold14PrimaryLight,
                  ),
                ),
                Image.asset(
                  AppAssets.heart,
                  color: AppColors.primarylight,
                )
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
              image: AssetImage(
                AppAssets.eating,
              ),
              fit: BoxFit.fill)),
    );
  }
}

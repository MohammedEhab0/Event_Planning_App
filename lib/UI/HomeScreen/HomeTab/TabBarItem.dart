import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';

class TabBarItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final IconData tabIcon;

  const TabBarItem({
    required this.text,
    required this.tabIcon,
    required this.isSelected,
  }) ;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return
     Container(

        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : AppColors.primarylight,
          borderRadius: BorderRadius.circular(46),
          border: Border.all(color: isSelected ? AppColors.primarylight : AppColors.white, width: 2),
        ),
        padding: EdgeInsets.symmetric(
            vertical: height * 0.01, horizontal: width * 0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content
          children: [
            Icon(tabIcon,
                color: isSelected ? AppColors.primarylight : AppColors.white),
            SizedBox(width: width * 0.02),
            Text(
              text,
              style: isSelected
                  ? AppStyle.bold16PrimaryLight
                  : AppStyle.bold16White,
            ),
          ],
        ),
      )
    ;
  }
}

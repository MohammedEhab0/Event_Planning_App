import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';

class EventBarItem extends StatelessWidget {

  final String text;
  final bool isSelected;
  final IconData tabIcon;
  final Color selectedColor;
  final Color unSelectedColor;
 final TextStyle textSelectedStyle;
  final TextStyle textUnSelectedStyle;
  const EventBarItem({
    required this.text,
    required this.tabIcon,
    required this.isSelected,required this.selectedColor,required this.unSelectedColor,
    required this.textSelectedStyle,required this.textUnSelectedStyle
  }) ;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return
      Container(

        decoration: BoxDecoration(
          color: isSelected ? selectedColor: unSelectedColor,
          borderRadius: BorderRadius.circular(46),
          border: Border.all(color: isSelected ? unSelectedColor: selectedColor, width: 2),
        ),
        padding: EdgeInsets.symmetric(
            vertical: height * 0.01, horizontal: width * 0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content
          children: [
            Icon(tabIcon,
                color: isSelected ? unSelectedColor: selectedColor),
            SizedBox(width: width * 0.02),
            Text(
              text,
              style: isSelected
                  ? textSelectedStyle
                  : textUnSelectedStyle,
            ),
          ],
        ),
      )
    ;
  }
}

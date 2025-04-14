import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/EventItem.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:event_planning_app/UI/Widgets/CustomTextField.dart';

class HeartTab extends StatelessWidget {
  const HeartTab({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width*.04),
            child: CustomTextField(
              prefixIconColor:AppColors.primarylight,
              prefixIcon:Icon(Icons.search_rounded),
              cursorColor: AppColors.primarylight,
              hintTextStyle: AppStyle.bold16PrimaryLight,
              colorBorder: AppColors.primarylight,
              hintText: "search_event".tr(),

            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              itemBuilder: (context, index) {
                return EventItem();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: height * 0.03);
              },
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}

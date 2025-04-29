import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/Modal/Event.dart';
import 'package:event_planning_app/UI/HomeScreen/EventDetails/EditEvent.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatefulWidget {
  static const routeName = 'EventDetails';

  EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Event eventArgs = ModalRoute.of(context)?.settings.arguments as Event;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(
                EditEvent.routeName,
                arguments: eventArgs);
          }, icon: Icon(Icons.edit_note_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.delete,color: Colors.red,))
        ],
        elevation: 0,
        backgroundColor: AppColors.backgroundlight,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primarylight),
        title: Text(
          'Event Details'.tr(),
          style: AppStyle.light20PrimaryLight,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * .04, vertical: height * .02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: height * .26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(eventArgs.image),
                  ),
                ),
              ),
              SizedBox(height: height * .03),
              Text(
                eventArgs.title,
                style: AppStyle.bold24primarylight,
              ),
              SizedBox(height: height * .03),
              Container(
                padding: EdgeInsets.all(width * .01),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.primarylight, width: 1)),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primarylight,
                        // Set the background color here
                        borderRadius: BorderRadius.circular(
                            16), // Optional: Add border radius for rounded corners
                      ),
                      child: IconButton(
                        padding: EdgeInsets.all(width * .02),
                        onPressed: () {},
                        icon: Icon(
                          Icons.date_range_outlined,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: height * .02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          eventArgs.time,
                          style: AppStyle.bold16PrimaryLight,
                        ),
                        Text(
                          DateFormat('ddd/mmm/yyy').format(eventArgs.date),
                          style: AppStyle.bold16Black,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * .03),
              Container(
                padding: EdgeInsets.all(width * .01),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.primarylight, width: 1)),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primarylight,
                        // Set the background color here
                        borderRadius: BorderRadius.circular(
                            16), // Optional: Add border radius for rounded corners
                      ),
                      child: IconButton(
                        padding: EdgeInsets.all(width * .02),
                        onPressed: () {},
                        icon: Icon(
                          Icons.location_searching_outlined,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: height * .02),
                    Text(
                      "choose Event location".tr(),
                      style: AppStyle.bold16PrimaryLight,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: AppColors.primarylight,
                    )
                  ],
                ),
              ),
              SizedBox(height: height * .03),
              Container(
                height: height * .4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(AppAssets.gps),
                  ),
                ),
              ),
              SizedBox(height: height * .03),
              Text(
                "Description",
                style: AppStyle.bold16Black,
              ),
              SizedBox(height: height * .01),
              Text(
                eventArgs.description,
                style: AppStyle.bold16Black,
              )
            ],
          ),
        ),
      ),
    );
  }
}

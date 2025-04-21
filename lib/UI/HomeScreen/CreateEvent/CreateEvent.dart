

import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/EventBarItem.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/EventItem.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/TabBarData.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/TabBarItem.dart';
import 'package:event_planning_app/UI/Widgets/CustomElevatedButton.dart';
import 'package:event_planning_app/UI/Widgets/CustomTextField.dart';
import 'package:event_planning_app/Utils/AppAssets.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:event_planning_app/Utils/FireBaseUtils.dart';
import 'package:flutter/material.dart';
import 'package:event_planning_app/Modal/Event.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateEvent extends StatefulWidget {
  static const routeName = 'CreateEvent';


  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  var formKey = GlobalKey<FormState>();
  int selectedIndex = 0;
  final List<TabBarData> EventList = [
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

  final List<String> imageEventList = [
    AppAssets.sport,
    AppAssets.birthday,
    AppAssets.meeting,
    AppAssets.gaming,
    AppAssets.workshop,
    AppAssets.bookClub,
    AppAssets.exhibition,
    AppAssets.holiday,
    AppAssets.eating,
  ];

  DateTime? selectedDate;
  String? selectedTime;

  String? formatTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedImage = '';
  String selectedEventName = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    selectedImage = imageEventList[selectedIndex];
    selectedEventName = EventList[selectedIndex].text;


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundlight,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primarylight),
        title: Text(
          'CreateEvent'.tr(),
          style: AppStyle.light20PrimaryLight,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: height * .02),
              Container(
                height: height * .25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(imageEventList[selectedIndex]))),
              ),
              SizedBox(height: height * .02),
              Container(
                height: height * .06,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: EventBarItem(
                              textSelectedStyle: AppStyle.bold16White,
                              textUnSelectedStyle: AppStyle.bold16PrimaryLight,
                              selectedColor: AppColors.primarylight,
                              unSelectedColor: AppColors.white,
                              text: EventList[index].text,
                              tabIcon: EventList[index].iconTab,
                              isSelected:
                                  selectedIndex == index ? true : false));
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: height * .02);
                    },
                    itemCount: EventList.length),
              ),
              SizedBox(height: height * .02),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'title'.tr(),
                        style: AppStyle.light20PrimaryLight,
                      ),
                      SizedBox(height: height * .02),
                      CustomTextField(
                        textInputType: TextInputType.text,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "please enter title";
                          }
                          return null;
                        },
                        controller: titleController,
                        hintText: "title".tr(),
                      ),
                      SizedBox(height: height * .03),
                      Text(
                        "description".tr(),
                        style: AppStyle.light20PrimaryLight,
                      ),
                      SizedBox(height: height * .03),
                      CustomTextField(
                        textInputType: TextInputType.text,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "please Enter Description";
                          }
                          return null;
                        },
                        controller: descriptionController,
                        maxLine: 4,
                        hintText: "description".tr(),
                      )
                    ],
                  )),
              SizedBox(height: height * .02),
              Row(
                children: [
                  Icon(
                    Icons.date_range_outlined,
                    color: AppColors.black,
                  ),
                  SizedBox(width: width * .02),
                  Text(
                    "eventData".tr(),
                    style: AppStyle.bold16Black,
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        chooseDate();
                      },
                      child: Text(
                        selectedDate == null
                            ? "choose Data".tr()
                            : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                        style: AppStyle.bold16PrimaryLight.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primarylight),
                      ))
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.date_range_outlined,
                    color: AppColors.black,
                  ),
                  SizedBox(width: width * .02),
                  Text(
                    "eventTime".tr(),
                    style: AppStyle.bold16Black,
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        chooseTime();
                      },
                      child: Text(
                        formatTime == null ? "choose Time".tr() : formatTime!,
                        style: AppStyle.bold16PrimaryLight.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primarylight),
                      ))
                ],
              ),
              SizedBox(height: height * .02),
              Text(
                'location'.tr(),
                style: AppStyle.light20PrimaryLight,
              ),
              SizedBox(height: height * .02),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.primarylight, width: 1)),
                child: Row(
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: AppColors.primarylight),
                      padding: EdgeInsets.all(width * .02),
                      onPressed: () {},
                      icon: Icon(
                        Icons.location_searching_outlined,
                        color: AppColors.white,
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
              CustomElevatedButton(
                onPressed: () {
                  // Validate the form
                  if (formKey.currentState?.validate() == true) {
                    // Check if a date has been selected
                    if (selectedDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please choose a date")),
                      );
                      return;
                    }

                    // Check if a time has been selected
                    if (formatTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please choose a time")),
                      );
                      return;
                    }

                    // Create the event object
                    Event event = Event(
                      eventName: selectedEventName,
                      title: titleController.text,
                      description: descriptionController.text,
                      image: selectedImage,
                      date: selectedDate!,
                      time: formatTime!,
                    );

                    // Add the event to Firestore
                    FireBaseUtils.addEventToFireStore(event).timeout(
                      Duration(milliseconds: 500),onTimeout: (){
                        print('event add successfully ');
                        Fluttertoast.showToast(
                            msg: "event add successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb:60,
                            backgroundColor: AppColors.primarylight,
                            textColor: AppColors.backgroundlight,
                            fontSize: 16.0
                        );
                    }
                      );
                  }
                },
                textButton: "add Event".tr(),
              )
            ],
          ),
        ),
      ),
    );
  }

  chooseDate() async {
    var chooseDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate = chooseDate;
    setState(() {});
  }

  chooseTime() async {

    var chooseTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (chooseTime != null) {

      selectedTime = chooseTime.format(context);

      formatTime = selectedTime;

      setState(() {});

    }

  }
}

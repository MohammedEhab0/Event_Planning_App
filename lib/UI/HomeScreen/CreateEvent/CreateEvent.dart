import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/EventBarItem.dart';
import 'package:event_planning_app/UI/Widgets/CustomElevatedButton.dart';
import 'package:event_planning_app/UI/Widgets/CustomTextField.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CreateEventProvider.dart';
import 'PickLocationScreen.dart';

class CreateEvent extends StatefulWidget {
  static const routeName = 'CreateEvent';

  @override
  State<CreateEvent> createState() => _CreateEventState();
}


class _CreateEventState extends State<CreateEvent> {
  late CreateEventProvider _createEventProvider;
  @override
  void initState() {
    super.initState();
    // Get the provider instance, but don't cause the widget to rebuild yet.
    // 'listen: false' is crucial here in initState.
    _createEventProvider = Provider.of<CreateEventProvider>(context, listen: false);

    // Explicitly call reset on the existing provider instance when the screen is initialized.
    _createEventProvider.reset();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // We already moved the context out of CreateEventProvider constructor,
    // so it's good to access it here.
    var createEventProvider = Provider.of<CreateEventProvider>(context);

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
                    image: AssetImage(createEventProvider.imageEventList[
                    createEventProvider.selectedIndex]),
                  ),
                ),
              ),
              SizedBox(height: height * .02),
              SizedBox( // Changed Container to SizedBox for better fixed height control for ListView
                height: height * .06,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        createEventProvider.updateSelectedEventData(index);
                      },
                      child: EventBarItem(
                        textSelectedStyle: AppStyle.bold16White,
                        textUnSelectedStyle: AppStyle.bold16PrimaryLight,
                        selectedColor: AppColors.primarylight,
                        unSelectedColor: AppColors.white,
                        text: createEventProvider.EventList[index].text,
                        tabIcon: createEventProvider.EventList[index].iconTab!,
                        isSelected: createEventProvider.selectedIndex == index,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    // This separator for horizontal list view should be SizedBox(width: ...)
                    // not height:
                    return SizedBox(width: width * .02); // Adjusted for horizontal separation
                  },
                  itemCount: createEventProvider.EventList.length,
                ),
              ),
              SizedBox(height: height * .02),
              Form(
                key: createEventProvider.formKey,
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
                          return "please enter title".tr(); // Localize validation messages
                        }
                        return null;
                      },
                      controller: createEventProvider.titleController,
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
                          return "please Enter Description".tr(); // Localize validation messages
                        }
                        return null;
                      },
                      controller: createEventProvider.descriptionController,
                      maxLine: 4,
                      hintText: "description".tr(),
                    )
                  ],
                ),
              ),
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
                      // FIX: Call the method with () and pass context
                      createEventProvider.chooseDate(context);
                    },
                    child: Text(
                      createEventProvider.selectedDate == null
                          ? "choose Data".tr()
                          : "${createEventProvider.selectedDate!.day}/${createEventProvider.selectedDate!.month}/${createEventProvider.selectedDate!.year}",
                      style: AppStyle.bold16PrimaryLight.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primarylight),
                    ),
                  )
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
                      // FIX: Call the method with () and pass context
                      createEventProvider.chooseTime(context);
                    },
                    child: Text(
                      createEventProvider.formatTime == null
                          ? "choose Time".tr()
                          : createEventProvider.formatTime!,
                      style: AppStyle.bold16PrimaryLight.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primarylight),
                    ),
                  )
                ],
              ),
              SizedBox(height: height * .02),
              Text(
                'location'.tr(),
                style: AppStyle.light20PrimaryLight,
              ),
              SizedBox(height: height * .02),
              Container(
                padding: EdgeInsets.all(width * .01),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primarylight, width: 1),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primarylight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.all(width * .02),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            PickLocationScreen.routeName,
                          );
                          // TODO: Implement location selection logic here
                        },
                        icon: Icon(
                          Icons.location_searching_outlined,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: height * .02),
                    Expanded(
                      child: Text(
                        createEventProvider.eventLocation == null
                            ? 'Choose Event Location'
                            : ' ${createEventProvider.city}, ${createEventProvider.country}',
                        style: AppStyle.bold16PrimaryLight,
                      ),
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
                  // FIX: Call the method with () and pass context
                  createEventProvider.createEvent(context);
                },
                textButton: "add Event".tr(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_planning_app/Modal/Event.dart';
import 'package:event_planning_app/UI/HomeScreen/HomeTab/TabBarData.dart';
import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/FireBaseUtils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventList = [];
  List<Event> filterList = [];
  List<Event> favoriteList = [];
  int selectedIndex = 0;
  final  List<TabBarData> tabBarList = [
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

  void getAllEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FireBaseUtils.getEventColleection(uId).orderBy('date').get();
    eventList = querySnapshot.docs.map((doc) => doc.data()).toList();
    filterList=eventList;
    notifyListeners();


  }
  void getFavoriteEvents(String uId ) async{
    QuerySnapshot<Event> querySnapshot =
    await FireBaseUtils.getEventColleection(uId).where('isFavorite', isEqualTo: true).orderBy('date').get();
    favoriteList=querySnapshot.docs.map((doc) => doc.data()).toList();
    notifyListeners();
  }
  void getFilterEvents(String uId) async {
    try {
      QuerySnapshot<Event> querySnapshot =
      await FireBaseUtils.getEventColleection(uId)
          .where('eventName', isEqualTo: tabBarList[selectedIndex].text)
          .orderBy('date')
          .get();
      filterList = querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching filtered events: $e");
      Fluttertoast.showToast(
        msg: "Error fetching events: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: AppColors.primarylight,
        textColor: AppColors.backgroundlight,
        fontSize: 16.0,
      );
    } finally {
      notifyListeners();
    }
  }
  void changeSelectedIndex(int newSelectedIndex, String uId){
    selectedIndex=newSelectedIndex;
    selectedIndex ==0 ? getAllEvents(uId):getFilterEvents(uId);
    notifyListeners();
  }
  void updateIsFavoriteEvent(Event event,String uId)async{

    FireBaseUtils.getEventColleection(uId).doc(event.id).update(
        {'isFavorite': !event.isFavorite}).timeout(Duration(milliseconds: 50),onTimeout: (){
          print('update successfully ');
          Fluttertoast.showToast(
              msg: "update successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb:60,
              backgroundColor: AppColors.primarylight,
              textColor: AppColors.backgroundlight,
              fontSize: 16.0
          );
          selectedIndex ==0 ? getAllEvents(uId):getFilterEvents(uId);
    });
    notifyListeners();
  }
  void updateEvent(Event event,String uId) async {
      FireBaseUtils.getEventColleection(uId).doc(event.id).update({
        'title': event.title,
        'description': event.description,
        'image': event.image,
        'eventName': event.eventName,
        'time': event.time,
        'date': event.date.millisecondsSinceEpoch,
      }).timeout(Duration(milliseconds: 50),onTimeout: ()
      {
        print('update successfully ');
        Fluttertoast.showToast(
            msg: "update successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 60,
            backgroundColor: AppColors.primarylight,
            textColor: AppColors.backgroundlight,
            fontSize: 16.0
        );
        selectedIndex == 0 ? getAllEvents(uId) : getFilterEvents(uId);

      });
      notifyListeners();
  }
  void deleteEvent(Event event, String uId) async {
    try {
      await FireBaseUtils.getEventColleection(uId).doc(event.id).delete().timeout(Duration(milliseconds: 50), onTimeout: () {
        print('Event deleted successfully');
        Fluttertoast.showToast(
          msg: "Event deleted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: AppColors.primarylight,
          textColor: AppColors.backgroundlight,
          fontSize: 16.0,
        );

        // Update the event lists after deletion
        if (selectedIndex == 0) {
          getAllEvents(uId);
        } else {
          getFilterEvents(uId);
        }
      });
    } catch (e) {
      print("Error deleting event: $e");
      Fluttertoast.showToast(
        msg: "Error deleting event: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: AppColors.primarylight,
        textColor: AppColors.backgroundlight,
        fontSize: 16.0,
      );
    } finally {
      notifyListeners();
    }
  }
}

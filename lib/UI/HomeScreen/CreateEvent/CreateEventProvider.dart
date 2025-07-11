import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../../Modal/Event.dart';
import '../../../Providers/EventListProvider.dart';
import '../../../Providers/UserProvider.dart';
import '../../../Utils/AppAssets.dart';
import '../../../Utils/AppColors.dart';
import '../../../Utils/FireBaseUtils.dart';
import '../HomeTab/TabBarData.dart';
import '../MapTab/MapTabProvider.dart';

class CreateEventProvider extends ChangeNotifier {
  CreateEventProvider(){
    reset(); // Call the reset function to set initial state
  }

  var formKey = GlobalKey<FormState>();
  int selectedIndex = 0; // Will be set by reset()
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
  DateTime? selectedDate; // Will be set by reset()
  String? selectedTime; // Will be set by reset()

  String? formatTime; // Will be set by reset()
  TextEditingController titleController = TextEditingController(); // Will be cleared by reset()
  TextEditingController descriptionController = TextEditingController(); // Will be cleared by reset()
  late String selectedImage; // 'late' is necessary as it's initialized in reset()
  late String selectedEventName; // 'late' is necessary as it's initialized in reset()
  Location location = Location();

  // Changed back to public as per your request
  late GoogleMapController googleMapController;

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Set<Marker> markers = {}; // Will be cleared by reset()
  LatLng? eventLocation; // Will be set by reset()
  String? city; // Will be set by reset()
  String? country; // Will be set by reset()

  /// Resets all relevant fields of the provider to their initial, empty state.
  /// This ensures a clean form whenever the screen is opened or a reset is triggered.
  void reset() {
    selectedIndex = 0;
    selectedImage = imageEventList[selectedIndex];
    selectedEventName = EventList[selectedIndex].text;

    titleController.text = ""; // Clear the text in the controller
    descriptionController.text = ""; // Clear the text in the controller

    selectedDate = null;
    selectedTime = null;
    formatTime = null;

    eventLocation = null;
    city = null;
    country = null;

    markers.clear(); // Clear all markers

    // Reset camera position to default/initial
    cameraPosition = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

    // Call getLocation to set the user's current position on the map upon reset.
    // getLocation itself will call notifyListeners().
    getLocation();

    // No need for an additional notifyListeners() here if getLocation() already does.
    notifyListeners();
  }

  // Removed the onMapCreated method from here as it's no longer needed for a private field.


  chooseDate(BuildContext context) async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(), // Use existing date if available, else current.
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    selectedDate = chooseDate;
    notifyListeners();
  }

  chooseTime(BuildContext context) async {
    var chooseTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (chooseTime != null) {
      selectedTime = chooseTime.format(context);
      formatTime = selectedTime;
      notifyListeners();
    }
  }

  void createEvent(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final eventListProvider = Provider.of<EventListProvider>(context, listen: false);
    final mapEventsProvider = Provider.of<MapsTabProvider>(context, listen: false);

    if (formKey.currentState?.validate() == true) {
      if (selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please choose a date")),
        );
        return;
      }
      if (formatTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please choose a time")),
        );
        return;
      }
      // Add validation for eventLocation if it is a mandatory field for creating an event
      if (eventLocation == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please choose an event location")),
        );
        return;
      }

      Event event = Event(
        eventName: selectedEventName,
        title: titleController.text,
        description: descriptionController.text,
        image: selectedImage,
        date: selectedDate!,
        time: formatTime!,
        lat: eventLocation!.latitude, // Include location details
        long: eventLocation!.longitude,
        city: city!, // Include city and country
        country: country!,
      );

      FireBaseUtils.addEventToFireStore(event, userProvider.currentUser!.id).then((value) {
        Fluttertoast.showToast(
          msg: "event add successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 60,
          backgroundColor: AppColors.primarylight,
          textColor: AppColors.backgroundlight,
          fontSize: 16.0,
        );
        Navigator.pop(context); // This context should also come from the method parameter
        eventListProvider.getAllEvents(userProvider.currentUser!.id);
        mapEventsProvider.getAllEvents(userProvider.currentUser!.id);
      }).timeout(
        const Duration(milliseconds: 500),
        onTimeout: () {
          Fluttertoast.showToast(
            msg: "event add successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 60,
            backgroundColor: AppColors.primarylight,
            textColor: AppColors.backgroundlight,
            fontSize: 16.0,
          );
          eventListProvider.getAllEvents(userProvider.currentUser!.id);
        },
      ).catchError((error) { // Catch any errors during the Firebase operation
        print("Error adding event: $error"); // Log the error for debugging
        Fluttertoast.showToast(
          msg: "Failed to add event: ${error.toString()}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red, // Using a generic red for error message background
          textColor: AppColors.backgroundlight,
          fontSize: 16.0,
        );
      });
    }
  }

  void updateSelectedEventData(int index) {
    selectedIndex = index;
    selectedEventName = EventList[index].text;
    selectedImage = imageEventList[index];
    notifyListeners();
  }


  Future<bool> _getLocationPermissioin() async {
    PermissionStatus permissionStatus;

    permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }

    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _checkLocationService() async {
    bool serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    return serviceEnabled;
  }

  Future<void> getLocation() async {
    bool permissionGranted = await _getLocationPermissioin();
    if (!permissionGranted) {
      return;
    }

    bool serviceEnabled = await _checkLocationService();
    if (!serviceEnabled) {
      return;
    }

    LocationData locationData = await location.getLocation();

    // Ensure locationData has valid latitude and longitude before updating map
    if (locationData.latitude != null && locationData.longitude != null) {
      changeLocationOnMap(locationData);
    }
    notifyListeners(); // Notify after attempting to get and set location
  }

  void changeLocationOnMap(LocationData locationData) {
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 14.4746,
    );

    // Remove any existing user location marker before adding a new one
    markers.removeWhere((marker) => marker.markerId == const MarkerId('user_location_marker'));
    markers.add(
      Marker(
        markerId: const MarkerId('user_location_marker'), // Unique ID for user marker
        position: LatLng(
          locationData.latitude ?? 0,
          locationData.longitude ?? 0,
        ),
        infoWindow: const InfoWindow(title: 'Your Current Location'),
      ),
    );

    // Only animate camera if the GoogleMapController has been initialized
    if (googleMapController != null) { // Direct access
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    }
    // notifyListeners(); // Not needed here as getLocation() already calls it.
  }

  void changeLocation(LatLng latLng) {
    eventLocation = latLng;
    // Remove any existing event location marker before adding a new one
    markers.removeWhere((marker) => marker.markerId == const MarkerId('event_location_marker'));
    markers.add(
      Marker(
        markerId: const MarkerId('event_location_marker'), // Unique ID for event marker
        position: latLng,
        infoWindow: const InfoWindow(title: 'Event Location'),
      ),
    );
    convertLatLongForEvent(); // Get address for the selected event location
    notifyListeners(); // Notify UI after marker and potential address update
  }

  Future<void> convertLatLongForEvent() async {
    if (eventLocation == null) {
      city = null;
      country = null;
      notifyListeners(); // Notify if eventLocation is null and fields cleared
      return;
    }

    List<geocoding.Placemark> placemarks = await geocoding
        .placemarkFromCoordinates(
      eventLocation!.latitude,
      eventLocation!.longitude,
    );

    if (placemarks.isNotEmpty) {
      city = placemarks.first.locality ?? placemarks.first.subAdministrativeArea ?? 'Unknown'; // More robust city fallback
      country = placemarks.first.country ?? 'Unknown';
    } else {
      city = 'Unknown'; // Set to 'Unknown' if no placemarks found
      country = 'Unknown';
    }
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    // Do NOT dispose googleMapController here unless you are
    // explicitly managing its lifecycle. The GoogleMap widget handles it.
    super.dispose();
  }
}
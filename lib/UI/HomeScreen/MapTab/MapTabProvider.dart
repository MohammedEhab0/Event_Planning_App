import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../Modal/Event.dart';
import '../../../Providers/UserProvider.dart'; // Still need this for type hinting
import '../../../Utils/FireBaseUtils.dart';

class MapsTabProvider extends ChangeNotifier {
  Location location = Location();

  // Public GoogleMapController - MAKE IT NULLABLE
  GoogleMapController? googleMapController; // Changed from 'late' to nullable '?'

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Set<Marker> markers = {};
  List<Event> events = [];

  // No need for 'late UserProvider userProvider;' if only uId is passed to getAllEvents
  // The MapTab correctly retrieves UserProvider and passes the uId.

  MapsTabProvider() {
    // Optionally call getLocation() here if you want to immediately try to get
    // the user's location on provider creation.
    // However, if called here, it will run *before* the map is created,
    // so the googleMapController will definitely be null initially.
    // This is why the null check for googleMapController is crucial.
    // getLocation(); // You can enable this if you want it to fire immediately
  }

  // Add an isLoading flag for events (as discussed previously)
  bool _isLoadingEvents = false;
  bool get isLoadingEvents => _isLoadingEvents;

  // Fetches all events from Firestore
  void getAllEvents(String uId) async {
    _isLoadingEvents = true;
    notifyListeners(); // Notify to indicate loading state

    try {
      print("MapsTabProvider: Attempting to fetch events for user ID: $uId");
      QuerySnapshot<Event> querySnapshot =
      await FireBaseUtils.getEventColleection(uId).orderBy('date').get();
      print("MapsTabProvider: Fetched ${querySnapshot.docs.length} documents.");
      events = querySnapshot.docs.map((doc) => doc.data()).toList();
      print("MapsTabProvider: Events list size after mapping: ${events.length}");
      _addEventMarkers(); // This calls notifyListeners() internally
    } catch (e) {
      print("MapsTabProvider: Error fetching events: $e");
      // TODO: Handle error feedback to UI
    } finally {
      _isLoadingEvents = false;
      notifyListeners(); // Ensure listeners are notified whether success or fail
    }
  }

  // Adds/updates event markers on the map
  void _addEventMarkers() {
    // Keep user's current location marker, clear only event markers.
    markers.removeWhere((marker) => marker.markerId.value.startsWith('event_'));

    for (var event in events) {
      if (event.lat != null && event.long != null) {
        markers.add(
          Marker(
            markerId: MarkerId('event_${event.id ?? UniqueKey().toString()}'),
            position: LatLng(event.lat!, event.long!),
            infoWindow: InfoWindow(
              title: event.title,
              snippet: "${event.eventName} - ${event.date.toLocal().toString().split(' ')[0]} ${event.time}",
            ),
            onTap: () {
              print('Tapped on event marker: ${event.title}');
            },
          ),
        );
      }
    }
    notifyListeners(); // Notify after all event markers are added/updated
  }

  // Gets current user location and updates map
  Future<void> getLocation() async {
    // Add an isLoading flag for location, if you want a separate indicator
    // bool _isLoadingLocation = true;
    // notifyListeners();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("MapsTabProvider: Location services disabled.");
        // TODO: Show user feedback
        // _isLoadingLocation = false; notifyListeners();
        return;
      }
    }

    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        print("MapsTabProvider: Location permission denied.");
        // TODO: Show user feedback
        // _isLoadingLocation = false; notifyListeners();
        return;
      }
    }

    try {
      LocationData locationData = await location.getLocation();
      if (locationData.latitude != null && locationData.longitude != null) {
        _updateUserLocationOnMap(locationData);
      }
    } catch (e) {
      print("MapsTabProvider: Error getting location: $e");
      // TODO: Handle error feedback
    } finally {
      // _isLoadingLocation = false; notifyListeners();
    }
  }

  // Internal helper to update user location marker and camera
  void _updateUserLocationOnMap(LocationData locationData) {
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 14.4746,
    );

    // Remove old user location marker, if any
    markers.removeWhere((marker) => marker.markerId == const MarkerId('user_location_marker'));

    markers.add(
      Marker(
        markerId: const MarkerId('user_location_marker'),
        position: LatLng(
          locationData.latitude ?? 0,
          locationData.longitude ?? 0,
        ),
        infoWindow: const InfoWindow(title: 'Your Current Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );

    // Animate camera only if googleMapController is initialized
    // This check is now effective because googleMapController is nullable
    if (googleMapController != null) {
      googleMapController!.animateCamera( // Use '!' now that it's nullable and checked
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    }
    notifyListeners();
  }

  StreamSubscription<LocationData>? _locationSubscription;

  void setLocationListener() {
    location.changeSettings(accuracy: LocationAccuracy.high, interval: 1000);
    _locationSubscription?.cancel();
    _locationSubscription = location.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        _updateUserLocationOnMap(currentLocation);
      }
    });
  }

  void animateCameraToEvent(LatLng latLng, String title) {
    cameraPosition = CameraPosition(target: latLng, zoom: 14.4746);

    if (googleMapController != null) {
      googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      ).then((_) {
        Marker? targetMarker;
        // Find marker by its specific ID to be more robust
        final targetMarkerId = MarkerId('event_${events.firstWhere((e) => e.title == title && LatLng(e.lat!, e.long!) == latLng).id ?? ''}'); // More robust lookup if you have the event ID

        targetMarker = markers.firstWhere(
                (marker) => marker.markerId.value.startsWith('event_') && marker.position == latLng && marker.infoWindow.title == title,
            orElse: () => null as Marker // Handle case where marker isn't found
        );
        // Corrected way to find marker by ID:
        // MarkerId markerIdToFind = MarkerId('event_${event.id}'); // if you can pass event.id
        // targetMarker = markers.firstWhereOrNull((m) => m.markerId == markerIdToFind);


        if (targetMarker != null) {
          googleMapController!.showMarkerInfoWindow(targetMarker.markerId);
        }
      });
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    googleMapController?.dispose(); // Use safe call here too
    super.dispose();
  }
}
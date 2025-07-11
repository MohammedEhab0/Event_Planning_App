import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';
import '../../../Providers/UserProvider.dart';
import 'MapTabProvider.dart';
import 'event_card_item.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  // Use a flag to ensure getAllEvents is only called once after the first build
  // or until you explicitly want to refresh it.
  bool _didInitFetch = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // This method is called when dependencies change, including on first build.
    // It's a good place for one-time initialization that depends on context.
    if (!_didInitFetch) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final mapsProvider = Provider.of<MapsTabProvider>(context, listen: false);

      if (userProvider.currentUser != null && userProvider.currentUser!.id.isNotEmpty) {
        // Schedule the getAllEvents call to happen after the current frame is built.
        // This prevents the "setState during build" error.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mapsProvider.isLoadingEvents) { // Add this check to prevent multiple calls if a quick rebuild occurs
            print("MapTab: Scheduling getAllEvents for ID: ${userProvider.currentUser!.id}");
            mapsProvider.getAllEvents(userProvider.currentUser!.id);
            _didInitFetch = true; // Set flag so it's not called again on subsequent rebuilds
          }
        });
      } else {
        print("MapTab: User not logged in or ID is empty. Cannot fetch events.");
        // Consider showing a message to the user or a login prompt here.
        _didInitFetch = true; // Mark as true even if no fetch, to avoid repeated checks
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Listen to the provider here for UI updates
    MapsTabProvider provider = Provider.of<MapsTabProvider>(context);
    // userProvider is not directly used for UI, so listen: false is good for build performance
    // var userProvider = Provider.of<UserProvider>(context, listen: false); // Already accessed in didChangeDependencies


    // You can keep this print for debugging rebuilds, but the fetch logic is now outside build
    print("MapTab Build: events.length = ${provider.events.length}, markers.length = ${provider.markers.length}");


    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: provider.cameraPosition,
                  onMapCreated: (controller) {
                    provider.googleMapController = controller;
                    // Safely animateCamera after assignment.
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(provider.cameraPosition),
                    );
                  },
                  mapType: MapType.normal,
                  markers: provider.markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                ),
              ),
            ],
          ),
          // --- Event List View ---
          // Only show the ListView if there are events to display
          if (provider.events.isNotEmpty)
            SizedBox(
              height: 160,
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index >= provider.events.length) {
                    return const SizedBox.shrink();
                  }
                  return InkWell(
                    onTap: () {
                      provider.animateCameraToEvent(
                        LatLng(
                          provider.events[index].lat!,
                          provider.events[index].long!,
                        ),
                        provider.events[index].title,
                      );
                    },
                    child: EventCardItem(
                      event: provider.events[index], provider: provider,
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: width * .01),
                itemCount: provider.events.length,
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.getLocation();
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).secondaryHeaderColor,
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'CreateEventProvider.dart';

class PickLocationScreen extends StatelessWidget {
  static const String routeName = '/pickLocation';


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CreateEventProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: provider.cameraPosition,
              onMapCreated: (controller) {
                // Direct assignment as requested
                provider.googleMapController = controller;
              },
              mapType: MapType.normal,
              markers: provider.markers,
              onTap: (latLag) async {
                provider.changeLocation(latLag);
                await provider.convertLatLongForEvent();

                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(
              'Tap on Location To Select',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
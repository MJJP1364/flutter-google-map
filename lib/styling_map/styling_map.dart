import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_map/styling_map/styling_map_controller.dart';
import 'package:flutter_google_map/styling_map/theme_list.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StylingScreen extends StatelessWidget {
  StylingScreen({super.key});

  final StylingScreenController stylingController =
      Get.put(StylingScreenController());
  final Completer<GoogleMapController> completer = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Styling Screen', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          ThemeWidgetsList(completer: completer),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.4221, -122.0841),
          zoom: 14.0,
        ),
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(stylingController.mapTheme.value);
          completer.complete(controller);
        },
        mapToolbarEnabled: true,
        // myLocationButtonEnabled: true,
        myLocationEnabled: true,
        // compassEnabled: true,
        // zoomControlsEnabled: false,
        // rotateGesturesEnabled: true,
        // scrollGesturesEnabled: true,
        // tiltGesturesEnabled: true,
        // liteModeEnabled: false,
        // indoorViewEnabled: false,
      ),
    );
  }
}

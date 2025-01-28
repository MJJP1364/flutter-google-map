import 'package:flutter/material.dart';
import 'package:flutter_google_map/coordinate/convert_coordinate.dart';
import 'package:flutter_google_map/custom_marker/custom_marker.dart';
import 'package:flutter_google_map/home/home_controller.dart';
import 'package:flutter_google_map/order_tracking/order_tracking.dart';
import 'package:flutter_google_map/search/search_google_places.dart';
import 'package:flutter_google_map/styling_map/styling_map.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController mapController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[900],
        title: const Text(
          'Flutter Google Map',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 580,
              width: double.infinity,
              child: Obx(
                () {
                  return GoogleMap(
                    // trafficEnabled: true,
                    initialCameraPosition: mapController.cameraPosition,
                    onMapCreated: (GoogleMapController controller) {
                      mapController.completer.complete(controller);
                    },
                    markers: Set<Marker>.of(mapController.marker),
                    mapType: MapType.normal,
                    // onMapCreated: (GoogleMapController controller) {},
                  );
                },
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                      ),
                      onPressed: () => Get.to(() => ConvertCoordinate()),
                      child: const Text(
                        'Convert Coordinate',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                      ),
                      onPressed: () {
                        mapController.newLocation();
                        mapController.marker.add(
                          Marker(
                            markerId: const MarkerId('6'),
                            position: const LatLng(35.68950, 51.38900),
                            infoWindow: const InfoWindow(
                              title: 'Ardabil Location',
                            ),
                            icon: BitmapDescriptor.defaultMarkerWithHue(90),
                          ),
                        );
                      },
                      child: const Text(
                        'Ardabil Location',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                      ),
                      onPressed: () async {
                        mapController
                            .getUserCurrentLocation()
                            .then((value) async {
                          // print('Current Location ${value.toString()}');
                          mapController.marker.add(
                            Marker(
                              markerId: const MarkerId('3'),
                              position: LatLng(value.latitude, value.longitude),
                              infoWindow: const InfoWindow(
                                title: 'Current Location',
                              ),
                              icon: BitmapDescriptor.defaultMarkerWithHue(90),
                            ),
                          );

                          CameraPosition newPosition = CameraPosition(
                            target: LatLng(value.latitude, value.longitude),
                            zoom: 14.0,
                          );
                          GoogleMapController controller =
                              await mapController.completer.future;
                          controller.animateCamera(
                            CameraUpdate.newCameraPosition(
                              newPosition,
                            ),
                          );
                        });
                      },
                      child: const Text(
                        'Current Location',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                      ),
                      onPressed: () {
                        Get.to(() => SearchGooglePlaces());
                      },
                      child: const Text(
                        'Search Location',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                      ),
                      onPressed: () {
                        Get.to(() => CstomMarkerScreen());
                      },
                      child: const Text(
                        'Custom Marker',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                      ),
                      onPressed: () {
                        Get.to(() => OrderTracking());
                      },
                      child: const Text(
                        'Order Tracking',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                      ),
                      onPressed: () {
                        Get.to(() => StylingScreen());
                      },
                      child: const Text(
                        'Styling Map',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

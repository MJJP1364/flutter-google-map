import 'package:flutter/material.dart';
import 'package:flutter_google_map/order_tracking/order_tracking_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTracking extends StatelessWidget {
  OrderTracking({super.key});

  final OrderTrackingController controller1 =
      Get.put(OrderTrackingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Tracking'),
      ),
      body: OrderTrackingController.currentLocation == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  OrderTrackingController.currentLocation!.latitude!,
                  OrderTrackingController.currentLocation!.longitude!,
                ),
                zoom: 14.0,
              ),
              polylines: {
                Polyline(
                    width: 8,
                    color: Colors.blue,
                    polylineId: const PolylineId('route'),
                    points: controller1.polylineCoordinates),
              },
              onMapCreated: (GoogleMapController controller) {
                controller1.completer.complete(controller);
              },
              markers: {
                Marker(
                  markerId: const MarkerId('current location'),
                  position: LatLng(
                    OrderTrackingController.currentLocation!.latitude!,
                    OrderTrackingController.currentLocation!.longitude!,
                  ),
                  infoWindow: const InfoWindow(title: 'Current Location'),
                  icon: OrderTrackingController.currentLocationIcon,
                ),
                Marker(
                  markerId: const MarkerId('source location'),
                  position: OrderTrackingController.sourceLocation,
                  infoWindow: const InfoWindow(title: 'Source Location'),
                  icon: OrderTrackingController.sourceLocationIcon,
                ),
                Marker(
                  markerId: const MarkerId('destination location'),
                  position: OrderTrackingController.destinationLocation,
                  infoWindow: const InfoWindow(title: 'Destination Location'),
                  icon: OrderTrackingController.destinationLocationIcon,
                ),
              },
            ),
    );
  }
}

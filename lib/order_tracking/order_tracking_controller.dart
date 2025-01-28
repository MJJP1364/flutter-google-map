import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_google_map/order_tracking/constants.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderTrackingController extends GetxController {
  final Completer<GoogleMapController> completer = Completer();

  static const LatLng sourceLocation = LatLng(37.4221, -122.0852);
  static const LatLng destinationLocation = LatLng(37.4116, -122.0713);

  List<LatLng> polylineCoordinates = [];

  static LocationData? currentLocation;

  static BitmapDescriptor sourceLocationIcon = BitmapDescriptor.defaultMarker;
  static BitmapDescriptor destinationLocationIcon =
      BitmapDescriptor.defaultMarker;
  static BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void setCustomMarkerIcon() async {
    sourceLocationIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(24, 24)),
      'assets/images/source_location.png',
    ).then((icon) {
      sourceLocationIcon = icon;
      update();
      return icon;
    });

    destinationLocationIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(24, 24)),
      'assets/images/destination_location.png',
    ).then((icon) {
      destinationLocationIcon = icon;
      update();
      return icon;
    });

    currentLocationIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(24, 24)),
      'assets/images/current_location.png',
    ).then((icon) {
      currentLocationIcon = icon;
      update();
      return icon;
    });
  }

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
        update();
      },
    );
    GoogleMapController googleMapController = await completer.future;

    location.onLocationChanged.listen((location) {
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(location.latitude!, location.longitude!),
            zoom: 14.0,
          ),
        ),
      );
      currentLocation = location;
      update();
    });
    location.enableBackgroundMode(enable: true);
    if (currentLocation != null) {
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    getPolylineCoordinates();
    setCustomMarkerIcon();
  }

  void getPolylineCoordinates() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult polylineResult =
        await polylinePoints.getRouteBetweenCoordinates(
      Constants.googleApiKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
      // travelMode: TravelMode.driving,
    );
    if (polylineResult.points.isNotEmpty) {
      for (var points in polylineResult.points) {
        polylineCoordinates.add(
          LatLng(points.latitude, points.longitude),
        );
      }
    }
  }
}

import 'dart:async';

import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  final Completer<GoogleMapController> completer = Completer();

  final RxList<Marker> marker = <Marker>[].obs;
  final List<Marker> markerList = <Marker>[
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(38.066666, 46.299999),
      infoWindow: InfoWindow(
        title: 'Tabriz',
        // snippet: 'Capital of Iran',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ),
    Marker(
      markerId: const MarkerId('2'),
      position: const LatLng(38.249800, 48.293300),
      infoWindow: const InfoWindow(
        title: 'Ardabil',
      ),
      // icon: BitmapDescriptor.defaultMarker,
      icon: BitmapDescriptor.defaultMarkerWithHue(90),
    ),
  ].obs;

  List<String> images = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png',
    'assets/images/6.png',
    'assets/images/6.png',
  ];

  final List<LatLng> latlang = [
    const LatLng(25.9861, 63.0300),
    const LatLng(25.9861, 63.0417),
    const LatLng(25.9719, 63.0292),
    const LatLng(26.0006, 63.0336),
    const LatLng(25.9819, 63.0308),
    const LatLng(25.9978, 63.0450),
    const LatLng(38.066666, 46.299999),
    const LatLng(38.249800, 48.293300),
  ];

  loadData() async {
    // marker.addAll(markerList);
    for (int index = 0; index < latlang.length; index++) {
      final Uint8List markerIcons = await getByteFromAssets(images[index], 100);
      marker.add(
        Marker(
          markerId: MarkerId(index.toString()),
          position: latlang[index],
          icon: BitmapDescriptor.fromBytes(markerIcons),
          infoWindow: InfoWindow(
            title: 'Marker $index',
          ),
        ),
      );
    }
  }

  Future<Uint8List> getByteFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void onInit() {
    super.onInit();
    // marker.addAll(markerList);
    loadData();
  }

  final CameraPosition cameraPosition = const CameraPosition(
    // tabriz location-----------------------------------------------------
    target: LatLng(38.066666, 46.299999),

    zoom: 14.0,
  );
  final CameraPosition cameraPosition2 = const CameraPosition(
    // Ardabil location-----------------------------------------------------
    target: LatLng(38.249800, 48.293300),
    zoom: 14.0,
  );

  Future<void> newLocation() async {
    GoogleMapController controller = await completer.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 45.0,
          tilt: 90.0,
          // ardabil location-----------------------------------------------------
          target: markerList[1].position,
          zoom: 14.0,
        ),
      ),
    );
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {});
    return await Geolocator.getCurrentPosition();
  }
}

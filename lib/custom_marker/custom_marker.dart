import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_marker_controller.dart';

class CstomMarkerScreen extends StatelessWidget {
  CstomMarkerScreen({super.key});

  final CustomMarkerScreenController controller =
      Get.put(CustomMarkerScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Marker Screen'),
      ),
      body: const Center(
        child: Text('Custom Marker'),
      ),
    );
  }
}

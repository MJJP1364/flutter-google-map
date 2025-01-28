import 'package:flutter/material.dart';
import 'package:flutter_google_map/coordinate/convert_controller.dart';
import 'package:flutter_google_map/Widget/widgets.dart';

import 'package:get/get.dart';

class ConvertCoordinate extends StatelessWidget {
  ConvertCoordinate({super.key});

  final controller = Get.put(ConvertController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convert Coordinate'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                controller.convertAddress.value,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () async {
                  await controller.getAddressFromCoordinates(
                      35.68950, 51.38900);
                },
                child: const ConverButton(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => Text(
                controller.getCoordinatesFromTheAddress.value,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () async {
                  await controller
                      .getCoordinatesFromAddress('tehran iran city');
                },
                child: const ConverButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

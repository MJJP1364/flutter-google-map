import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ThemeWidgetsList extends StatelessWidget {
  const ThemeWidgetsList({
    super.key,
    required this.completer,
  });

  final Completer<GoogleMapController> completer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: const Text('Dark Theme'),
                onTap: () {
                  completer.future.then(
                    (value) => DefaultAssetBundle.of(Get.context!)
                        .loadString('assets/maps_theme/dark_theme.json')
                        .then(
                      (themeValue) {
                        value.setMapStyle(themeValue);
                      },
                    ),
                  );
                },
              ),
              PopupMenuItem(
                child: const Text('Standard Theme'),
                onTap: () {
                  completer.future.then(
                    (value) => DefaultAssetBundle.of(Get.context!)
                        .loadString('assets/maps_theme/standard_theme.json')
                        .then(
                      (themeValue) {
                        value.setMapStyle(themeValue);
                      },
                    ),
                  );
                },
              ),
              PopupMenuItem(
                child: const Text('Night Theme'),
                onTap: () {
                  completer.future.then(
                    (value) => DefaultAssetBundle.of(Get.context!)
                        .loadString('assets/maps_theme/night_theme.json')
                        .then(
                      (themeValue) {
                        value.setMapStyle(themeValue);
                      },
                    ),
                  );
                },
              ),
              PopupMenuItem(
                child: const Text('Retro Theme'),
                onTap: () {
                  completer.future.then(
                    (value) => DefaultAssetBundle.of(Get.context!)
                        .loadString('assets/maps_theme/retro_theme.json')
                        .then(
                      (themeValue) {
                        value.setMapStyle(themeValue);
                      },
                    ),
                  );
                },
              ),
              PopupMenuItem(
                child: const Text('Silver Theme'),
                onTap: () {
                  completer.future.then(
                    (value) => DefaultAssetBundle.of(Get.context!)
                        .loadString('assets/maps_theme/silver_theme.json')
                        .then(
                      (themeValue) {
                        value.setMapStyle(themeValue);
                      },
                    ),
                  );
                },
              ),
            ];
          },
        ),
      ],
    );
  }
}

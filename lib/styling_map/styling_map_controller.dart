import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StylingScreenController extends GetxController {
  RxString mapTheme = ''.obs;

  @override
  void onInit() {
    DefaultAssetBundle.of(Get.context!)
        .loadString('assets/maps_theme/standard_theme.json')
        .then(
      (themeValue) {
        mapTheme.value = themeValue;
      },
    );
    super.onInit();
  }
}

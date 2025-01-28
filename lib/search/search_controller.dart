import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class PlacesSearchController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  Uuid uuid = const Uuid();
  String sessionToken = '';

  Future<void> getSuggestions(String input) async {
    // Google Places API
    // Endpoint Url of Google Places API
    // Seasion token

    String googleApiKey = 'AIzaSyDsTq7VMJognkjQqXbZJLD75cADq3yauoY';

    String baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    // String request =
    //     '$baseurl?input=$input&key=$googleApiKey&sessiontoken=$sessionToken';
    String request =
        '$baseUrl?input=$input&key=$googleApiKey&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    print(response.body.toString());
  }

  void onChange() {
    if (sessionToken.isEmpty) {
      sessionToken = uuid.v4();
    } else {
      getSuggestions(searchController.text);
    }
  }

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() => onChange());
  }
}

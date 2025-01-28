import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_google_map/search/search_controller.dart';

class SearchGooglePlaces extends StatelessWidget {
  SearchGooglePlaces({super.key});

  final PlacesSearchController controller = Get.put(PlacesSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Google Places'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: controller.searchController,
              decoration: const InputDecoration(
                hintText: 'Search Google Places',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

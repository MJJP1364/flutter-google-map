import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class ConvertController extends GetxController {
  // Variable -------------------------------------------------------------
  final RxString convertAddress = ''.obs;
  final RxString getCoordinatesFromTheAddress = ''.obs;

  // Function -------------------------------------------------------------

  // Get Address From Coordinates ------------------------------------------
  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    convertAddress.value =
        '${place.street}   ${place.locality} \n ${place.administrativeArea} ${place.country}';

    return convertAddress.value;
  }

  // Get Coordinates From Address ------------------------------------------
  Future<List<Location>> getCoordinatesFromAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    getCoordinatesFromTheAddress.value =
        ' ${locations[0].latitude}  ,  ${locations[0].longitude}';
    return locations;
  }
}

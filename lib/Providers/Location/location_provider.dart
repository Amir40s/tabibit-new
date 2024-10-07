import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class LocationProvider extends ChangeNotifier{

  final searchController = TextEditingController();
  final uuid = const Uuid();

  Completer<GoogleMapController> gController = Completer();

  bool suggestions = false;
  String _countryName = "Morocco";
  String _userLocation = "";
  String _latitude = "";
  String _longitude = "";
  String? _sessionToken;
  List<dynamic> placesList = [];

  String get countryName => _countryName;
  String get userLocation => _userLocation;
  String get latitude => _latitude;
  String get longitude => _longitude;
  // bool get suggestions => _suggestions;
  String? get sessionToken => _sessionToken;
  // List<dynamic> get placeList => _placesList;

  selectCountryName(String countryName){
    _countryName = countryName;
    notifyListeners();
  }

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(31.418715, 73.079109),
    zoom: 14,
  );

  Future<Position> getUserCurrentLocation(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    // Check if location permission is already granted
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      return await Geolocator.getCurrentPosition();
    } else if (permission == LocationPermission.denied) {
      // If permission is denied, request it
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        // Permission granted after requesting
        return await Geolocator.getCurrentPosition();
      } else if (permission == LocationPermission.denied) {
        await openAppSettings();
        // If permission is denied permanently, show dialog to open app settings
        _showPermissionDialog(context);
      }
    } else if (permission == LocationPermission.deniedForever) {
      await openAppSettings();
      // Permission denied forever, user needs to manually enable it from settings
      _showPermissionDialog(context);
    }

    // Return a default position if permission is denied or not granted
    return Future.error('Location permissions are not granted.');
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission'),
        content: const Text('This app requires location permission to function. Please enable it in settings.'),
        actions: [
          TextButton(
            onPressed: () async {
              // Open app settings
              await openAppSettings();
              Navigator.of(context).pop();
            },
            child: const Text('Open Settings'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> location(context) async {
    try{
      getUserCurrentLocation(context).then((value) async {
        kGooglePlex = CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: 14,
        );
        notifyListeners();
        GoogleMapController controller = await gController.future;
        await controller.animateCamera(CameraUpdate.newCameraPosition(
            kGooglePlex = CameraPosition(
                target: LatLng(value.latitude,value.longitude),
                zoom: 14
            )
        ));
        List<Placemark> place = await placemarkFromCoordinates(value.latitude, value.longitude);
        searchController.text = "${place.reversed.last.street}, ${place.reversed.last.subLocality},"
            " ${place.reversed.last.locality}, ${place.reversed.last.postalCode} ${place.reversed.last.country}";
        notifyListeners();
      });
    }catch(e){
      log(e.toString());
    }
  }

  moveLocation(latitude,longitude,index) async {

    _latitude = latitude.toString();
    _longitude= longitude.toString();

    List<Placemark> place = await placemarkFromCoordinates(latitude, longitude);
    _userLocation = "${place.reversed.last.street}, ${place.reversed.last.subLocality},"
        " ${place.reversed.last.locality}, ${place.reversed.last.postalCode}";

    searchController.text = placesList[index]["description"];
    notifyListeners();

    kGooglePlex = CameraPosition(
        target: LatLng(latitude,longitude),
        zoom: 14
    );
    GoogleMapController controller = await gController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(latitude,longitude),
            zoom: 14
        )
    ));
    log(_userLocation);
    log(_latitude);
    log(_longitude);
    notifyListeners();
  }

  onChanged(searchResult){
    if(sessionToken == null){
      sessionToken == uuid.v4();
      notifyListeners();
    }
    getSuggestion(searchResult);
  }

  void getSuggestion(String input)async{
    String kPLACES_API_KEY = "AIzaSyCog7RsE7QqPGoGhJePgBaaXqNbuO8fDAE";
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    log("data");
    log(data);
    if(response.statusCode == 200){
      placesList = jsonDecode(response.body.toString())["predictions"];
      notifyListeners();
    }else{
      throw Exception("Failed to Load ");
    }

  }

// @override
// void dispose() {
//   if (gController.isCompleted) {
//     gController.future.then((controller) => controller.dispose());
//   }
//   super.dispose();
// }

}
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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

  void showSuggestions() {
    suggestions = true;
    notifyListeners();
  }

  void hideSuggestions() {
    suggestions = false;
    notifyListeners();
  }

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(31.418715, 73.079109),
    zoom: 14,
  );

  Future<Position> getUserCurrentLocation(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      return await Geolocator.getCurrentPosition();
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        return await Geolocator.getCurrentPosition();
      } else if (permission == LocationPermission.denied) {
        await openAppSettings();
        _showPermissionDialog(context);
      }
    } else if (permission == LocationPermission.deniedForever) {
      await openAppSettings();
      _showPermissionDialog(context);
    }
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
    }catch(e,s){
      FirebaseCrashlytics.instance.recordError(e, s);
      log(e.toString());
    }
  }

  moveLocation(latitude,longitude,index) async {

    if (latitude == null || longitude == null) {
      latitude = 31.418715;
      longitude = 73.079109;
    }

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

    if(gController.isCompleted){
      GoogleMapController controller = await gController.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(latitude,longitude),
              zoom: 14
          )
      ));
    }
    log(_userLocation);
    log(_latitude);
    log(_longitude);
    notifyListeners();
  }

  void onSearchChanged(String value) {
    onChanged(value);
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

    try {
      var response = await http.get(Uri.parse(request));
      log("Response data: ${response.body}");
      if (response.statusCode == 200) {
         placesList = jsonDecode(response.body)["predictions"];
        notifyListeners();
      } else {
        throw Exception("Failed to load suggestions");
      }
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      log('Error occurred: $e', error: e, stackTrace: s);
      rethrow;
    }

  }

@override
void dispose() {
  if (gController.isCompleted) {
    gController.future.then((controller) => controller.dispose());
  }
  super.dispose();
}

}
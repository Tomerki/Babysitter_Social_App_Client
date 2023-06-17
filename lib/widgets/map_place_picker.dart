import 'dart:developer';

import 'package:baby_sitter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';

class MapPlacePicker extends StatefulWidget {
  static final routeName = 'picker';

  MapPlacePicker({
    super.key,
  });

  @override
  State<MapPlacePicker> createState() => _MapPlacePickerState();
}

class _MapPlacePickerState extends State<MapPlacePicker> {
  String address = 'Pick location';
  String autocompletePlace = '';
  double latitude = 29.121599;
  double longitude = 76.396698;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Check the current location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Location permission denied, request permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permission still denied, handle accordingly
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Location permission denied permanently, handle accordingly
      return;
    }

    // Get the user's current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      this.latitude = position.latitude;
      this.longitude = position.longitude;
    });

    // Do something with the obtained latitude and longitude
  }

  @override
  Widget build(BuildContext context) {
    return MapLocationPicker(
      padding: const EdgeInsets.all(20.0),
      apiKey: "AIzaSyAATmkFbdy8cMiF5lPaFEZ9qBNSkty8OEA",
      canPopOnNextButtonTaped: true,
      currentLatLng: LatLng(latitude, longitude),
      onNext: (GeocodingResult? result) {
        if (result != null) {
          setState(
            () {
              address = result.formattedAddress ?? "";
            },
          );
          Function func =
              ModalRoute.of(context)!.settings.arguments as Function;
          func(address);
        }
      },
      onSuggestionSelected: (PlacesDetailsResponse? result) {
        if (result != null) {
          setState(
            () {
              autocompletePlace = result.result.formattedAddress ?? "";
              address = autocompletePlace;
              Function func =
                  ModalRoute.of(context)!.settings.arguments as Function;
              func(address);
            },
          );
        }
      },
    );
  }
}

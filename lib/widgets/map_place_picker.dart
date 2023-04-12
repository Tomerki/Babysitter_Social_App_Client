import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';

class MapPlacePicker extends StatefulWidget {
  static final routeName = 'picker';
  const MapPlacePicker({super.key});

  @override
  State<MapPlacePicker> createState() => _MapPlacePickerState();
}

class _MapPlacePickerState extends State<MapPlacePicker> {
  String address = 'Pick location';
  String autocompletePlace = '';

  @override
  Widget build(BuildContext context) {
    return MapLocationPicker(
      apiKey: "AIzaSyD4ZNBsUrpwesGvU3S_3Hoxgkq7JdhdL2g",
      canPopOnNextButtonTaped: true,
      currentLatLng: const LatLng(29.121599, 76.396698),
      onNext: (GeocodingResult? result) {
        if (result != null) {
          setState(() {
            address = result.formattedAddress ?? "";
          });
        }
      },
      onSuggestionSelected: (PlacesDetailsResponse? result) {
        if (result != null) {
          setState(() {
            autocompletePlace = result.result.formattedAddress ?? "";
          });
        }
      },
    );
  }
}

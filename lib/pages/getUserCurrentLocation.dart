// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_place_picker/flutter_place_picker.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import '../Controller/pickupLocationController.dart';

class getUserCurrentLocation extends StatefulWidget {
  getUserCurrentLocation({Key? key}) : super(key: key);

  static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;

  @override
  State<getUserCurrentLocation> createState() => _getUserCurrentLocationState();
}

class _getUserCurrentLocationState extends State<getUserCurrentLocation> {
  // PickResult? selectedPlace;

  final PickupLocationController pickupLocationController =
      Get.put(PickupLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:FlutterPlacePicker(
          apiKey:
          "AIzaSyDORAiwsJBUe0hBl6ViXWmf97aVT3VnYqg", // Needed to display google maps and
          initialPosition: getUserCurrentLocation.kInitialPosition,
          useCurrentLocation: true,
          selectInitialPosition: true,
          usePlaceDetailSearch: false,
          region: 'gh',
          strictBounds: true,
          onPlacePicked: (result) async {
            // selectedPlace = result;

                print("Place picked: ${result.formattedAddress}");
                print("Latitude: ${result.geometry?.location.lat}");
                print("Longitude: ${result.geometry?.location.lng}");
                pickupLocationController.setAddress(
                    result.formattedAddress.toString(),
                    result.geometry!.location.lat.toString(),
                    result.geometry!.location.lng.toString());
            Navigator.of(context).pop();
            setState(() {});
          },
          // serverUrl: "https://www.your-server.com/api/",
          //automaticallyImplyAppBarLeading: false,
          // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
          //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
          //   return isSearchBarFocused
          //       ? Container()
          //       : FloatingCard(
          //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
          //           leftPosition: 0.0,
          //           rightPosition: 0.0,
          //           width: 500,
          //           borderRadius: BorderRadius.circular(12.0),
          //           child: state == SearchingState.Searching
          //               ? Center(child: CircularProgressIndicator())
          //               : RaisedButton(
          //                   child: Text("Pick Here"),
          //                   onPressed: () {
          //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
          //                     //            this will override default 'Select here' Button.
          //                     print("do something with [selectedPlace] data");
          //                     Navigator.of(context).pop();
          //                   },
          //                 ),
          //         );
          // },
          // pinBuilder: (context, state) {
          //   if (state == PinState.Idle) {
          //     return Icon(Icons.favorite_border);
          //   } else {
          //     return Icon(Icons.favorite);
          //   }
          // },
        ),
        // child: PlacePicker(
        //   resizeToAvoidBottomInset:
        //       false, // only works in page mode, less flickery
        //   apiKey: Platform.isAndroid
        //       ? "AIzaSyDORAiwsJBUe0hBl6ViXWmf97aVT3VnYqg"
        //       : "",
        //   hintText: "Find a place ...",
        //   searchingText: "Please wait ...",
        //   selectText: "Select place",
        //   outsideOfPickAreaText: "Place not in area",
        //   initialPosition: getUserCurrentLocation.kInitialPosition,
        //   useCurrentLocation: true,
        //   selectInitialPosition: true,
        //   usePinPointingSearch: true,
        //   usePlaceDetailSearch: true,
        //   zoomGesturesEnabled: true,
        //   zoomControlsEnabled: true,
        //   onMapCreated: (GoogleMapController controller) {
        //     print("Map created");
        //   },
        //   onPlacePicked: (PickResult result) async {
        //     print("Place picked: ${result.formattedAddress}");
        //     print("Latitude: ${result.geometry?.location.lat}");
        //     print("Longitude: ${result.geometry?.location.lng}");
        //     pickupLocationController.setAddress(
        //         result.formattedAddress.toString(),
        //         result.geometry!.location.lat.toString(),
        //         result.geometry!.location.lng.toString());
        //     Get.back();
        //   },
        // ),
      ),
    );
  }
}

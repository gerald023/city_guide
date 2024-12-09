import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  LatLng _markerPosition = LatLng(4.8353, 7.0210); // Default location

  void _onSearch(double lat, double lng) {
    setState(() {
      _markerPosition = LatLng(lat, lng);
    });
    _mapController.animateCamera(CameraUpdate.newLatLng(_markerPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search & Display on Map")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GooglePlaceAutoCompleteTextField(
              textEditingController: TextEditingController(),
              googleAPIKey: "AIzaSyBob7q890UJ7WjKAYCa6pxkvIF3cxT5WYI",
              inputDecoration: InputDecoration(
                hintText: "Search location...",
                border: OutlineInputBorder(),
              ),
              debounceTime: 600, // Delay for search queries
              countries: ["us"], // Restrict search to specific countries
              getPlaceDetailWithLatLng: (prediction) {
                if (prediction != null) {
                  _onSearch(prediction.lat! as double, prediction.lng! as double);
                }
              },
              isLatLngRequired: true, // Ensure lat/lng is provided
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _markerPosition,
                zoom: 12,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("search_marker"),
                  position: _markerPosition,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_integration/CustomeInfoWindow.dart';
import 'package:google_maps_integration/GetUserCurrentPosition.dart';
import 'package:google_maps_integration/MapStyling.dart';
import 'package:google_maps_integration/PolyLine.dart';
import 'package:google_maps_integration/Polygon.dart';
import 'package:google_maps_integration/SearchPlaces.dart';
import 'Add_Mutltiple_Custom_Marker.dart';
import 'GoogleMaps.dart';
import 'LatLngToAddress.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapStyless(),
    );
  }
}

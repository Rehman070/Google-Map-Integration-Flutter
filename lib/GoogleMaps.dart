import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  //Controller
  final Completer<GoogleMapController> _completer =
      Completer<GoogleMapController>();

//Initial Camera Position
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(33.954118, 72184021), zoom: 14);

//Adding Multiple Markers
  List<Marker> markers = [];
  List<Marker> multipleMarker = [
    const Marker(
        position: LatLng(33.954118, 72184021),
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId('1'),
        infoWindow: InfoWindow(title: 'Current Location')),
    const Marker(
        position: LatLng(33.969924, 72181049),
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId('2'),
        infoWindow: InfoWindow(title: 'Aimal Ground')),
    const Marker(
        position: LatLng(37.0902, 95.7129),
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId('2'),
        infoWindow: InfoWindow(title: 'United State')),
    const Marker(
        position: LatLng(23.6345, 102.5528),
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId('2'),
        infoWindow: InfoWindow(title: 'Mexico')),
    const Marker(
        position: LatLng(33.9833, 72.1833),
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId('2'),
        infoWindow: InfoWindow(title: 'Shaidu'))
  ];
  @override
  void initState() {
    //Add in markers in List
    markers.addAll(multipleMarker);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(markers),
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: ((controller) {
          _completer.complete(controller);
        }),
        myLocationEnabled: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //Animate the Camera from one marker to another marker
          GoogleMapController controller = await _completer.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              const CameraPosition(target: LatLng(33.9833, 72.1833))));
          setState(() {});
        },
        child: const Icon(Icons.location_history_outlined),
      ),
    );
  }
}

import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLinee extends StatefulWidget {
  const PolyLinee({super.key});

  @override
  State<PolyLinee> createState() => _PolyLineeState();
}

class _PolyLineeState extends State<PolyLinee> {
  //Controller
  final Completer<GoogleMapController> _completer =
      Completer<GoogleMapController>();

//Initial Camera Position
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(33.954118, 72184021), zoom: 2);

//Adding Multiple Markers
  final Set<Marker> _markers = HashSet();
  Set<Polyline> polyline = HashSet();
  List<LatLng> latlng = <LatLng>[
    const LatLng(33.954118, 7218402),
    const LatLng(33.969924, 7218104),
    const LatLng(37.0902, 95.7129),
    const LatLng(23.6345, 102.5528),
  ];
  @override
  void initState() {
    loaddata();
    super.initState();
  }

  void loaddata() {
    for (int i = 0; i < latlng.length; i++) {
      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: latlng[i],
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'Place No$i')));
      polyline.add(Polyline(
        polylineId: PolylineId(i.toString()),
        points: latlng,
        color: Colors.purple,
        width: 3,
      ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: _markers,
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: ((controller) {
          _completer.complete(controller);
        }),
        myLocationEnabled: true,
        polylines: polyline,
      ),
    );
  }
}

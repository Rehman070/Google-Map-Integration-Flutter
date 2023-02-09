import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DrawPolygon extends StatefulWidget {
  const DrawPolygon({super.key});

  @override
  State<DrawPolygon> createState() => _DrawPolygonState();
}

class _DrawPolygonState extends State<DrawPolygon> {
  //Controller
  final Completer<GoogleMapController> _completer =
      Completer<GoogleMapController>();

//Initial Camera Position
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(33.954118, 72184021), zoom: 14);

//Adding Multiple Markers
  Set<Polygon> polygon = HashSet();
  List<LatLng> latlng = <LatLng>[
    const LatLng(33.954118, 72184021),
    const LatLng(33.969924, 72181049),
    const LatLng(37.0902, 95.7129),
    const LatLng(23.6345, 102.5528),
    const LatLng(33.9833, 72.1233),
    const LatLng(33.954118, 72184021),
  ];
  @override
  void initState() {
    //Add in markers in List
    loaddata();
    super.initState();
  }

  void loaddata() {
    for (int i = 0; i < latlng.length; i++) {
      polygon.add(Polygon(
        polygonId: PolygonId(i.toString()),
        points: latlng,
        fillColor: Colors.red.shade200,
        geodesic: true,
        strokeColor: Colors.red.shade800,
        strokeWidth: 3,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: ((controller) {
          _completer.complete(controller);
        }),
        myLocationEnabled: true,
        polygons: polygon,
      ),
    );
  }
}

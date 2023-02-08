import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

class MultipleCustomMarker extends StatefulWidget {
  const MultipleCustomMarker({super.key});

  @override
  State<MultipleCustomMarker> createState() => _MultipleCustomMarkerState();
}

class _MultipleCustomMarkerState extends State<MultipleCustomMarker> {
  //UnistList is Specific length of list (8 bytes)
  Uint8List? images;
  //Controller
  final Completer<GoogleMapController> _completer =
      Completer<GoogleMapController>();

//Initial Camera Position
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(33.954118, 72184021), zoom: 14);

//Create a Custome Marker List
  List<String> customicon = <String>[
    'Assets/Images/bicycle.png',
    'Assets/Images/cafe.png',
    'Assets/Images/education.png',
    'Assets/Images/school.png',
    'Assets/Images/sport-car.png',
  ];

//Adding Multiple Markers
  List<Marker> markers = [];
//List of LatLng Position
  List<LatLng> latlng = <LatLng>[
    const LatLng(33.6941, 72.9734),
    const LatLng(33.7008, 72.9682),
    const LatLng(33.6992, 72.9744),
    const LatLng(33.6910, 72.9007),
    const LatLng(33.7036, 72.9785),
  ];

  Future<Uint8List> getBytesfromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo info = await codec.getNextFrame();
    return (await info.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    //Call the Function LoadData()
    loadData();
    super.initState();
  }

  void loadData() async {
    for (int i = 0; i < latlng.length; i++) {
      final Uint8List markerlist = await getBytesfromAssets(customicon[i], 100);
      markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: latlng[i],
          icon: BitmapDescriptor.fromBytes(markerlist),
          infoWindow: InfoWindow(title: 'Pos no$i')));
    }
    setState(() {});
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
    );
  }
}

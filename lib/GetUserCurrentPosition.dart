import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GetCurrentPosition extends StatefulWidget {
  const GetCurrentPosition({super.key});

  @override
  State<GetCurrentPosition> createState() => _GetCurrentPositionState();
}

class _GetCurrentPositionState extends State<GetCurrentPosition> {
  //Camera Position
  final CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(52.2165157, 6.9437819), zoom: 14);

//Google Map Controller
  final Completer<GoogleMapController> _completer =
      Completer<GoogleMapController>();

  List<Marker> markers = [];
  List<Marker> multiplemarkers = [
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(52.2165157, 6.9437819),
        infoWindow: InfoWindow(title: 'NetherLand'),
        icon: BitmapDescriptor.defaultMarker),
  ];

  void loadloc() {
    getCurrentPosition().then((value) async {
      markers.add(Marker(
          markerId: const MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: 'Current Position'),
          icon: BitmapDescriptor.defaultMarker));

      GoogleMapController controller = await _completer.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(value.latitude, value.longitude),
      )));
    });
  }

  @override
  void initState() {
    loadloc();
    markers.addAll(multiplemarkers);
    super.initState();
  }

  Future<Position> getCurrentPosition() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
    });

    return Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Google Maps',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 650,
            width: double.infinity,
            child: GoogleMap(
              markers: Set<Marker>.of(markers),
              initialCameraPosition: cameraPosition,
              mapType: MapType.normal,
              myLocationEnabled: true,
              onMapCreated: ((controller) {
                _completer.complete(controller);
              }),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    GoogleMapController controller = await _completer.future;
                    controller.animateCamera(
                        CameraUpdate.newCameraPosition(const CameraPosition(
                      target: LatLng(52.2165157, 6.9437819),
                    )));
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20)),
                  child: const Text('GetCurrent Location'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

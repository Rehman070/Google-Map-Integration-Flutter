import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LatLngToAddress extends StatefulWidget {
  const LatLngToAddress({super.key});

  @override
  State<LatLngToAddress> createState() => _LatLngToAddressState();
}

class _LatLngToAddressState extends State<LatLngToAddress> {
  var staddress = '';
  var stLatLng = '';

  //Camera Position
  final CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(52.2165157, 6.9437819), zoom: 14);

//Google Map Controller
  Completer<GoogleMapController> completer = Completer();

  List<Marker> markers = [];
  List<Marker> multiplemarkers = [
    const Marker(markerId: MarkerId('1'),
    position: LatLng(52.2165157, 6.9437819),
    infoWindow: InfoWindow(title: 'NetherLand'),
    icon: BitmapDescriptor.defaultMarker
    
    )
  ];

  

//Convert LatLng to Address
  void addressFromCoordinates() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(52.2165157, 6.9437819);

    setState(() {
      staddress = placemarks[0].country!.toString() +
          placemarks[0].postalCode.toString() +
          placemarks[0].street.toString();
    });
  }

//Convert Address to LatLng
  Future<void> coordinatesFromAddress() async {
    const address = 'Netherlands';
    var corrdinates = await locationFromAddress(address);

    setState(() {
      stLatLng =
          '${corrdinates[0].latitude},${corrdinates[0].longitude},${corrdinates[0].timestamp.year}';
    });
  }

  @override
  void initState() {
    markers.addAll(multiplemarkers);
    super.initState();
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
            height: 600,
            width: double.infinity,
            child: GoogleMap(
              markers: Set<Marker>.of(markers),
              initialCameraPosition: cameraPosition,
              mapType: MapType.normal,
              myLocationEnabled: true,
              onMapCreated: (controller) => completer,
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
                  onPressed: addressFromCoordinates,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20)),
                  child: const Text('Address'),
                ),
                ElevatedButton(
                  onPressed: coordinatesFromAddress,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20)),
                  child: const Text('LatLng'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Address :$staddress',
            style: style,
          ),
          const SizedBox(
            height: 3,
          ),
          Text('LatLng :$stLatLng', style: style),
        ],
      ),
    );
  }
}

TextStyle style = const TextStyle(
    fontSize: 19, fontWeight: FontWeight.w400, color: Colors.black);

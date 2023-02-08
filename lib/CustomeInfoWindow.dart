import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomInfoWindowss extends StatefulWidget {
  const CustomInfoWindowss({super.key});

  @override
  State<CustomInfoWindowss> createState() => _CustomInfoWindowssState();
}

class _CustomInfoWindowssState extends State<CustomInfoWindowss> {
  //CustomInfowindow Controller
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

//Initial Camera Position
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(33.954118, 72184021), zoom: 14);

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

  @override
  void initState() {
    //Call the Function LoadData()
    loadData();
    super.initState();
  }

  void loadData() {
    for (int i = 0; i < latlng.length; i++) {
      markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: latlng[i],
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    height: 100,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Image.network(
                          'https://images.unsplash.com/photo-1556905200-279565513a2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGxhY2VzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                          height: 50,
                          width: 150,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('sagy sajba svca ba sc aschj abs chjb asca')
                      ],
                    ),
                  ),
                ),
                latlng[i]);
          }));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          markers: Set<Marker>.of(markers),
          initialCameraPosition: cameraPosition,
          mapType: MapType.normal,
          onMapCreated: ((controller) {
            _customInfoWindowController.googleMapController = controller;
          }),
          myLocationEnabled: true,
          onTap: (Position) {
            _customInfoWindowController.hideInfoWindow!();
          },
          onCameraMove: (Position) {
            _customInfoWindowController.onCameraMove!();
          },
        ),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          height: 150,
          width: 200,
          offset: 35,
        )
      ]),
    );
  }
}

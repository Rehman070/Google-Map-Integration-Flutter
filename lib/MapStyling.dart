import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapStyless extends StatefulWidget {
  const MapStyless({super.key});

  @override
  State<MapStyless> createState() => _MapStylessState();
}

String maptheme = '';

class _MapStylessState extends State<MapStyless> {
  //Controller
  final Completer<GoogleMapController> _completer =
      Completer<GoogleMapController>();

//Initial Camera Position
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(33.954118, 72184021), zoom: 1);

  @override
  void initState() {
    DefaultAssetBundle.of(context)
        .loadString('Assets/MapStyles/Standard_Style.json')
        .then((value) {
      maptheme = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Styles'),
        actions: [
          PopupMenuButton(
              itemBuilder: (_) => [
                    PopupMenuItem(
                      onTap: () {
                        _completer.future.then((value) => {
                              DefaultAssetBundle.of(context)
                                  .loadString(
                                      'Assets/MapStyles/Silver_Style.json')
                                  .then((string) {
                                value.setMapStyle(string);
                              })
                            });
                      },
                      child: const Text('Silver Style'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        _completer.future.then((value) => {
                              DefaultAssetBundle.of(context)
                                  .loadString(
                                      'Assets/MapStyles/Retro_Style.json')
                                  .then((string) {
                                value.setMapStyle(string);
                              })
                            });
                      },
                      child: const Text('Retro Style'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        _completer.future.then((value) => {
                              DefaultAssetBundle.of(context)
                                  .loadString(
                                      'Assets/MapStyles/Night_Style.json')
                                  .then((string) {
                                value.setMapStyle(string);
                              })
                            });
                      },
                      child: const Text('Night Style'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        _completer.future.then((value) => {
                              DefaultAssetBundle.of(context)
                                  .loadString(
                                      'Assets/MapStyles/Dark_Style.json')
                                  .then((string) {
                                value.setMapStyle(string);
                              })
                            });
                      },
                      child: const Text('Dark Style'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        _completer.future.then((value) => {
                              DefaultAssetBundle.of(context)
                                  .loadString(
                                      'Assets/MapStyles/Aubergine_Style.json')
                                  .then((string) {
                                value.setMapStyle(string);
                              })
                            });
                      },
                      child: const Text('Aubergine Style'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        _completer.future.then((value) => {
                              DefaultAssetBundle.of(context)
                                  .loadString(
                                      'Assets/MapStyles/Standard_Style.json')
                                  .then((string) {
                                value.setMapStyle(string);
                              })
                            });
                      },
                      child: const Text('Standard Style'),
                    ),
                  ])
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        onMapCreated: ((controller) {
          _completer.complete(controller);
          controller.setMapStyle(maptheme);
        }),
        myLocationEnabled: true,
      ),
    );
  }
}

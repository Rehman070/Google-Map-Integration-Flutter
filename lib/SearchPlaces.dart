import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchPlaces extends StatefulWidget {
  const SearchPlaces({super.key});

  @override
  State<SearchPlaces> createState() => _SearchPlacesState();
}

class _SearchPlacesState extends State<SearchPlaces> {
  TextEditingController controller = TextEditingController();

  String sessionToken = '123456';
  var uuid = const Uuid();
  List<dynamic> places = [];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      onchange();
    });
  }

  void onchange() {
    if (sessionToken == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    }
    getsuggestions(controller.text);
  }

  void getsuggestions(String placename) async {
    String placemapapi = 'AIzaSyDNaftVmm_yr5BdIvIJYQZYGpZcPC6L2z0';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$placename&key=$placemapapi&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print(data);

    if (response.statusCode == 200) {
      places = jsonDecode(response.body.toString())['predictions'];
    } else {
      throw Exception('Not Found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Places',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: 'Search a Place',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  )),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: places.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      var corrdinates = await locationFromAddress(
                          places[index]['description']);
                      print(corrdinates);
                    },
                    child: ListTile(
                      subtitle: Text(places[index]['description']),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

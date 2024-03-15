import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientHomePage.dart';
import 'package:healing_hand/modelclass/nearby_response.dart';
import 'package:http/http.dart' as http;
//import 'package:sid/screens/current_location_screen.dart';

class NearByPlacesScreen extends StatefulWidget {
  const NearByPlacesScreen({Key? key}) : super(key: key);

  @override
  State<NearByPlacesScreen> createState() => _NearByPlacesScreenState();
}

class _NearByPlacesScreenState extends State<NearByPlacesScreen> {

  String apiKey = "AIzaSyDz1yuC4lv3zAQXbffeFUo85KMw77T6_4Y";
  String radius = "500";

  double latitude = double.parse(lang1.toString());
  double longitude = double.parse(long1.toString());

  NearbyPlacesResponse nearbyPlacesResponse = NearbyPlacesResponse();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Places'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){

              getNearbyPlaces();

            }, child: const Text("Get Nearby Places")),

            if(nearbyPlacesResponse.results != null)
              for(int i = 0 ; i < nearbyPlacesResponse.results!.length; i++)
                nearbyPlacesWidget(nearbyPlacesResponse.results![i])
          ],
        ),
      ),
    );
  }

  void getNearbyPlaces() async {

    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' + latitude.toString() + ','
    + longitude.toString() + '&radius=' + radius + '&key='+apiKey+'&type=hospital|pharmacy|doctor'
    );

    var response = await http.post(url);

    nearbyPlacesResponse = NearbyPlacesResponse.fromJson(jsonDecode(response.body));

    setState(() {});

  }

  Widget nearbyPlacesWidget(Results results) {

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10,left: 10,right: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text("Name: " + results.name!),
          //Text(results..toString()),
          Text("Location: " + results.geometry!.location!.lat.toString() + " , " + results.geometry!.location!.lng.toString()),
          Text(results.openingHours != null ? "Open" : "Closed"),
        ],
      ),
    );

  }
}

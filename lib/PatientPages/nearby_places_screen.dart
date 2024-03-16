import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientHomePage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/modelclass/nearby_response.dart';
import 'package:http/http.dart' as http;


class NearByPlacesScreen extends StatefulWidget {
  const NearByPlacesScreen({Key? key}) : super(key: key);

  @override
  State<NearByPlacesScreen> createState() => _NearByPlacesScreenState();
}

class _NearByPlacesScreenState extends State<NearByPlacesScreen> {

  String apiKey = "AIzaSyDz1yuC4lv3zAQXbffeFUo85KMw77T6_4Y";
  String radius = "500";
  bool justOpenrd = true;
  double latitude = double.parse(lang1.toString());
  double longitude = double.parse(long1.toString());

  NearbyPlacesResponse nearbyPlacesResponse = NearbyPlacesResponse();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Hostpitals'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (context){
              return [
                PopupMenuItem(child: Text('Under 500m', style: TextStyle(color: radius != '500'? Colors.grey: Colors.green),), value: '500',),
                PopupMenuItem(child: Text('Under 1km', style: TextStyle(color: radius != '1000'? Colors.grey: Colors.green),), value: '1000',),
                PopupMenuItem(child: Text('Under 2m', style: TextStyle(color: radius != '2000'? Colors.grey: Colors.green),), value: '2000',),
                PopupMenuItem(child: Text('Under 5km', style: TextStyle(color: radius != '5000'? Colors.grey: Colors.green),), value: '5000',),
              ];
            },
            onSelected: (value){
                radius = value;
            },
            icon: Icon(Icons.tune),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: (){

                getNearbyPlaces();

              }, child: justOpenrd? const Text("Get Nearby Places"): const Text('Get More Places')),

              if(nearbyPlacesResponse.results != null)
                for(int i = 0 ; i < nearbyPlacesResponse.results!.length; i++)
                  nearbyPlacesWidget(nearbyPlacesResponse.results![i])
            ],
          ),
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
      //decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(10)),
      child: WhiteContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Name: " + results.name!, style: TextStyle(fontSize: 17),textAlign: TextAlign.center,),
              //Text(results..toString()),
              Text("Location: " + results.geometry!.location!.lat.toString() + " , " + results.geometry!.location!.lng.toString(), style: TextStyle(fontSize: 17),textAlign: TextAlign.center,),
              Text(results.openingHours != null ? "Open" : "Closed", style: TextStyle(fontSize: 17),textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );

  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/AppointmentRequestPage.dart';
import 'package:healing_hand/PatientPages/CategoryViewPage.dart';
import 'package:healing_hand/PatientPages/DoctorViewPage.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/PatientPages/SearchPage.dart';
import 'package:healing_hand/PatientPages/nearby_places_screen.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/firebase/AuthServices.dart';
import 'package:geolocator/geolocator.dart';

String? lang1,long1;

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          AppBar(
            leadingWidth: 300,
            toolbarHeight: 150,
            leading: FutureBuilder(
              future: firestore.collection('Patient').doc(currentUserId).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text('No data found for this doctor.'));
                }
                else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  else {
                    Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PatientAccountRequest()));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          userData['profile'] == null ?
                          CircleImage(image: const AssetImage('assets/images/default_dp.jpg')) :
                          CircleImage(image: NetworkImage(userData['profile'])),
                          const Text('Welcome back,'),
                          Text(userData['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 25),)
                        ],
                      ),
                    );
                  }
                }
              }
            ),
            actionsIconTheme: const IconThemeData(
              size: 30,
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AppointmentRequestPage()));
                  },
                  icon: const Icon(Icons.notifications)
              ),
            ],
          ),
          Expanded(
            //color: Colors.black,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  WhiteContainer(
                    child: InkWell(
                        onTap: (){
                          print('Search pressed');
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const SearchPage()));
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.search, color: Colors.black54,),
                            Expanded(child: Text('Search..', style: TextStyle(color: Colors.black54,),)),
                            Icon(Icons.tune, color: Colors.black54,)
                          ],
                        )
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Available Doctors', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),),
                    ],
                  ),
                  Container(
                    height: 120.0,
                    child: StreamBuilder(
                      stream: firestore.collection('Doctor').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator(); // Or any other loading indicator
                        }
                        var doctors = snapshot.data!.docs;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: doctors.length,
                          itemBuilder: (context, index) {
                            var doctor = doctors[index].data(); // Get data of the doctor
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CircleImage(
                                    image: NetworkImage(doctor['profile']),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DoctorViewPage(
                                            uid: doctor['uid'],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 85,
                                    child: Center(
                                      child: Text(
                                        doctor['name'],
                                        style: const TextStyle(color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Categories', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),),
                    ],
                  ),
                  SizedBox(
                    height: 120.0, // Adjust the height of the scrollable list
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CircleImage(
                                image: const AssetImage('assets/images/physician.jpg'),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryViewPage(category: DoctorCategories[index])));
                                },
                              ),
                              SizedBox(width: 85, child: Center(child: Text(DoctorCategories[index],overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white),)))
                            ],
                          ),
                        );
                      },
                      itemCount: DoctorCategories.length,
                    ),
                  ),
                  WhiteContainer(
                      child: Column(
                        children: [
                          const Text('Emergency?', style: TextStyle(fontSize: 25, color: Colors.red, fontWeight: FontWeight.w700),),
                          const Text('Find nearest Doctors,Hospitals and Ambulance',textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 10,),
                          Image.asset('assets/images/emergency.jpg'),
                          const SizedBox(height: 10,),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.red.shade100,
                                  foregroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50)
                              ),
                              onPressed: ()async{
                                await _determinePosition();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const NearByPlacesScreen()));
                                print('Go to Google Map');
                              },
                              child: const Text('Find now', style: TextStyle(color: Colors.red),)
                          )
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();
    lang1=position.latitude.toString();
    long1=position.longitude.toString();
    return position;
  }
}

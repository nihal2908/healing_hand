import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/AppointmentRequestPage.dart';
import 'package:healing_hand/PatientPages/CategoryViewPage.dart';
import 'package:healing_hand/PatientPages/DoctorViewPage.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/PatientPages/SearchPage.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/Providers/PatientProvider.dart';
import 'package:healing_hand/customWidgets/AppointmentContainer.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:provider/provider.dart';


class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  bool gotLocation = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            leadingWidth: 300,
            toolbarHeight: 130,
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleImage(imagePath: 'assets/images/demo_user.jpg'),
                Text('Welcome back,'),
                Text(PatientUser.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),)
              ],
            ),
            actionsIconTheme: IconThemeData(
              size: 30,
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    //add here google map functionality
                  },
                  icon: Icon(Icons.location_pin)
              ),
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AppointmentRequestPage()));
                  },
                  icon: Icon(Icons.notifications)
              ),
            ],
          ),
          Expanded(
            //color: Colors.black,
            child: Consumer<DoctorProvider>(
              builder: (context, DoctorModel, child) =>
              SingleChildScrollView(
                child: Column(
                  children: [
                    WhiteContainer(
                      child: InkWell(
                          onTap: (){
                            print('Search pressed');
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.black54,),
                              Expanded(child: Text('Search..', style: TextStyle(color: Colors.black54,),)),
                              Icon(Icons.tune, color: Colors.black54,)
                            ],
                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Available Doctors', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),),
                      ],
                    ),
                    Container(
                      height: 120.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: doctors.length,
                        itemBuilder: (context,index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CircleImage(
                                  imagePath: 'assets/images/doctor.png',
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorViewPage(doc: doctors[index])));
                                  },
                                ),
                                SizedBox(width: 85, child: Text(doctors[index].name, style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,))
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Categories', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),),
                      ],
                    ),
                    Container(
                      height: 120.0, // Adjust the height of the scrollable list
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                        return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CircleImage(
                                    imagePath: 'assets/images/physician.jpg',
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryViewPage(category: DoctorCategories[index])));
                                    },
                                  ),
                                  SizedBox(width: 85, child: Center(child: Text(DoctorCategories[index],overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white),)))
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
                            Text('Emergency?', style: TextStyle(fontSize: 25, color: Colors.red, fontWeight: FontWeight.w700),),
                            Text('Find nearest Doctors,Hospitals and Ambulance',textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                            SizedBox(height: 10,),
                            Image.asset('assets/images/emergency.jpg'),
                            SizedBox(height: 10,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.red.shade100,
                                foregroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50)
                              ),
                                onPressed: (){
                                  print('Go to Google Map');
                                },
                                child: Text('Find now', style: TextStyle(color: Colors.red),)
                            )
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/PatientPages/SearchPage.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/customWidgets/AppointmentContainer.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';

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
                Text('Nihal Yadav', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),)
              ],
            ),
            actionsIconTheme: IconThemeData(
              size: 30,
            ),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.location_pin)
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.notifications)
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
                      TextButton(onPressed: (){print('Show all doctors');}, child: Text('See All', style: TextStyle(color: Colors.blue),))
                    ],
                  ),
                  Container(
                    height: 120.0, // Adjust the height of the scrollable list
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context,index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CircleImage(imagePath: 'assets/images/demo_user.jpg'),
                              Text('Dr. Aman', style: TextStyle(color: Colors.white),)
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
                      //TextButton(onPressed: (){print('Show all doctors');}, child: Text('See All', style: TextStyle(color: Colors.blue),))
                    ],
                  ),
                  Container(
                    height: 120.0, // Adjust the height of the scrollable list
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context,index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CircleImage(imagePath: 'assets/images/dental.png'),
                              Text('Category', style: TextStyle(color: Colors.white),)
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  WhiteContainer(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Upcoming Appointments', style: nameSytle),
                              TextButton(onPressed: (){print('Show all appointments');}, child: Text('See All', style: TextStyle(color: Colors.blue),))
                            ],
                          ),
                          AppointmentContainer(appointment: sampleAppointment),
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
}

import 'package:flutter/material.dart';
import 'package:healing_hand/customWidgets/roundedImageBox.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  bool gotLocation = false;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              height: 10,
              width: 10,
              color: Colors.white,
            )
          ],
        ),
      ),
    );











    // return Scaffold(
    //   backgroundColor: Colors.deepPurple,
    //   appBar: AppBar(
    //     foregroundColor: Colors.white,
    //     backgroundColor: Colors.transparent,
    //     leading: RoundedImageBox(imagePath: 'assets/images/doctor.png',),
    //     title: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text('Hii,', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, ),),
    //         Text('Nihal Yadav', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, ),)
    //       ],
    //     ),
    //     actions: [
    //       IconButton(
    //           style: IconButton.styleFrom(
    //               foregroundColor: Colors.white
    //           ),
    //           onPressed: (){
    //             //show map to select location
    //             //if location selected successfully, change gotLocation
    //             setState(() {
    //               gotLocation = !gotLocation;
    //             });
    //           },
    //           icon: gotLocation?
    //           Icon(Icons.not_listed_location_rounded) :
    //           Icon(Icons.location_on_rounded)
    //       ),
    //       IconButton(
    //           style: IconButton.styleFrom(
    //               foregroundColor: Colors.white
    //           ),
    //           onPressed: (){},
    //           icon: Icon(Icons.notifications)
    //       )
    //     ],
    //   ),
    //   body: SingleChildScrollView(
    //     child: Padding(
    //       padding: EdgeInsets.all(15),
    //       child: Column(
    //         children: [
    //
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/PatientPages/SearchPage.dart';
import 'package:healing_hand/customWidgets/AppointmentContainer.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';

class Hospital{
  String name;
  String location;

  Hospital({required this.name, required this.location});
}

List<Hospital> hospitals = [
  Hospital(name: 'Shanti Hospital', location: 'Civil lines, Prayagraj'),
  Hospital(name: 'Vedanta Nursing Home', location: 'Teliyarganj, Prayagraj'),
  Hospital(name: 'Midwell Hospital', location: 'Shahid chauk, Prayagraj'),
  Hospital(name: 'Krishna Nursing home', location: 'Bank Road, Prayagraj')
];

class PatientSchedulePage extends StatefulWidget {
  const PatientSchedulePage({super.key});

  @override
  State<PatientSchedulePage> createState() => _PatientSchedulePageState();
}

class _PatientSchedulePageState extends State<PatientSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Center(child: Text('Emergency', style: titleStyle,)),
            ),
            WhiteContainer(
              child: InkWell(
                  onTap: (){
                    print('Search pressed');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.black54,),
                      Expanded(child: Text('Search for Hospital & Ambulance..', style: TextStyle(color: Colors.black54,),)),
                      Icon(Icons.tune, color: Colors.black54,)
                    ],
                  )
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nearest Ambulance', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),),
                TextButton(onPressed: (){print('Show all doctors');}, child: Text('See All', style: TextStyle(color: Colors.blue),))
              ],
            ),
            Container(
              height: 130.0, // Adjust the height of the scrollable list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (context,index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircleImage(imagePath: 'assets/images/ambulance.jpg'),
                        Container(
                          width: 90,
                          child: Text(
                            'Apolo Hospital',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20,),
            WhiteContainer(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('24*7 Clinics & Hospitals', style: nameSytle),
                        TextButton(onPressed: (){print('Show all appointments');}, child: Text('See All', style: TextStyle(color: Colors.blue),))
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: ListTile(
                              leading: CircleImage(imagePath: 'assets/images/hospital.png',),
                              title: Text(hospitals[index].name, overflow: TextOverflow.ellipsis,),
                              subtitle: Text(hospitals[index].location, overflow: TextOverflow.ellipsis,),
                            ),
                          ),
                        );
                      },
                      itemCount: 4,
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}

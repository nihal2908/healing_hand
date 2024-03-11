import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/PatientProvider.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:provider/provider.dart';

class PatientViewPage extends StatelessWidget {
  Patient patient;
  PatientViewPage({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Consumer<PatientProvider>(
          builder: (context, UserModal, child){
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 100,),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  height: 250,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                      Text(patient.name, style: nameSytle,),
                                      Text('${patient.age} years', style: profileStyle,),
                                      Text(patient.gender, style: profileStyle),
                                      Text(patient.phone, style: profileStyle),
                                      Text(patient.email, style: profileStyle),
                                      Text('Aadhaar: Not available', style: profileStyle),
                                      Text('${patient.height}cm / ${patient.weight}Kg', style: profileStyle)
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          //height: 200,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Medical History', style: nameSytle,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                //height: 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index){
                                    return Text(history[index], style: profileStyle,);
                                  },
                                  itemCount: history.length,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 67,
                          child: Center(
                              child: Text(
                                  patient.name,
                                  style: titleStyle
                              )
                          ),
                        ),
                        CircleImage(imagePath: 'assets/images/demo_user.jpg'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}

TextStyle nameSytle = const TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontWeight: FontWeight.w600
);

TextStyle profileStyle =  const TextStyle(
    fontSize: 15,
    color: Colors.black87,
    fontWeight: FontWeight.w400
);

TextStyle titleStyle = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white
);

List<String> history = ['Cough', 'Fever', 'Appendicitis', 'Dengue'];
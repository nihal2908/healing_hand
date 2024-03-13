import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/PatientProvider.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/DoctorTile.dart';
import 'package:provider/provider.dart';
String? user_name1;
  String? user_email1;
  String? pass1;
  String? phone1;
  String? weight1;
  String? height1;
  String? age1;
  String? gender1;

class PatientViewPage extends StatelessWidget {
 PatientViewPage(String? user_name,
  String? user_email,
  String? pass,
  String? phone,
  String? weight,
  String? height,
  String? age,
  String? gender,)
 {
user_name1=user_name;
user_email1=user_email;
pass1=pass;
phone1=phone;
weight1=weight;
height1=height;
age1=age;
gender1=gender;
 }

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
                                      Text(name1.toString(), style: nameSytle,),
                                      Text('${age1.toString()} years', style: profileStyle,),
                                      Text(gender1.toString(), style: profileStyle),
                                      Text(phone1.toString(), style: profileStyle),
                                      Text(email1.toString(), style: profileStyle),
                                      Text('Aadhaar: Not available', style: profileStyle),
                                      Text('${height1}cm / ${weight1}Kg', style: profileStyle)
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
                                  name1.toString(),
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
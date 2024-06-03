import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';

class PatientViewPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String uid;
  PatientViewPage({required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
              future: firestore.collection('Patient').doc(uid).get(),
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  else {
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 100,),
                            WhiteContainer(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      height: 250,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20,),
                                          Text(data['name'], style: nameSytle,),
                                          Text('${data['age']} years', style: profileStyle,),
                                          Text(data['gender'], style: profileStyle),
                                          Text(data['phone'], style: profileStyle),
                                          Text(data['email'], style: profileStyle),
                                          Text('${data['height']}cm / ${data['weight']}Kg', style: profileStyle)
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
                                  ),
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
                                      data['name'],
                                      style: titleStyle
                                  )
                              ),
                            ),
                            CircleImage(image: AssetImage('assets/images/demo_user.jpg')),
                          ],
                        ),
                      ],
                    );
                  }
                }
              }
            )
          ),
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
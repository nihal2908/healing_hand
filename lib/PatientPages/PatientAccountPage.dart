import 'package:flutter/material.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';

class PatientAccountPage extends StatefulWidget {
  const PatientAccountPage({super.key});

  @override
  State<PatientAccountPage> createState() => _PatientAccountPageState();
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

class _PatientAccountPageState extends State<PatientAccountPage> {
  @override
  Widget build(BuildContext context) {
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
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: (){
                                    print('Edit button pressed');
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                              ),
                              Text('Nihal Yadav', style: nameSytle,),
                              Text('21 years', style: profileStyle,),
                              Text('Male', style: profileStyle),
                              Text('9174635352', style: profileStyle),
                              Text('nihalmail.123@gmail.com', style: profileStyle),
                              Text('Aadhaar: 9191 2323 6252', style: profileStyle),
                              Text('175cm / 55Kg', style: profileStyle)
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
                SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: InkWell(
                      onTap: (){
                        print('Change password');
                      },
                      child: Center(child: Text('Change Password', style: nameSytle,))
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: InkWell(
                      onTap: (){
                        print('Logout pressed');
                      },
                      child: Center(child: Text('Log-out', style: nameSytle,))
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: 67,
                  child: Center(
                    child: Text(
                      'Your Profile',
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
}
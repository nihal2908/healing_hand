import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientProfileEditPage.dart';
import 'package:healing_hand/PatientPages/PatientSignupPage.dart';
import 'package:healing_hand/Providers/PatientProvider.dart';
import 'package:healing_hand/apiconnection/doctorview.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/modelclass/userer.dart';
import 'package:provider/provider.dart';
import 'package:healing_hand/PatientPages/PatientProfileEditPage.dart' as dd;
httpServices13 http=new httpServices13();

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
    // return Consumer<PatientProvider>(
      // builder: (context, UserModal, child){
        return FutureBuilder<List<prodModal3>>(
      future: http.getAllPost5(remember),
      builder: ((context, snapshot) {
        
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Scaffold(
              body:
                  Center(heightFactor: 1.4, child: CircularProgressIndicator()),
            );
          case ConnectionState.waiting:
            return Scaffold(
              body:
                  Center(heightFactor: 0.4, child: CircularProgressIndicator()),
            );
          case ConnectionState.active:
            return ShowPostList(context, snapshot.data!);

          case ConnectionState.done:

            //return CircularProgressIndicator();
            return ShowPostList(context, snapshot.data!);
        }
        //}

        //else{
        //return CircularProgressIndicator();
        //}

        //  return CircularProgressIndicator();
      }),
    ); 
      }

    // );
    Widget ShowPostList(BuildContext context,List<prodModal3> posts )
    {
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
                                      dd.password=posts[0].pass.toString();  
                                        dd.nameController.text=posts[0].user_name.toString();
                                        dd.emailController.text=posts[0].user_email.toString();
                                        dd.selectedGender=posts[0].gender.toString();
                                        dd.heightController.text=posts[0].height.toString();
                                        dd.weightController.text=posts[0].weight.toString();
                                        dd.phoneController.text=remember.toString();
                                        dd.ageController.text=24.toString();
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientProfileEditPage()));
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                  ),
                                  Text(posts[0].user_name.toString(), style: nameSytle,),
                                  Text('${posts[0].age} years', style: profileStyle,),
                                  Text(posts[0].gender.toString(), style: profileStyle),
                                  Text(remember, style: profileStyle),
                                  Text(posts[0].user_email.toString(), style: profileStyle),
                                  Text('${posts[0].height}cm / ${posts[0].weight}Kg', style: profileStyle)
                                ],
                              ),
                            ),
                          ],
                        )
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
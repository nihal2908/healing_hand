import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healing_hand/PatientPages/PatientProfileEditPage.dart';
import 'package:healing_hand/PatientPages/PatientSignupPage.dart';
import 'package:healing_hand/Providers/PatientProvider.dart';
import 'package:healing_hand/apiconnection/doctorview.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/modelclass/userer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:healing_hand/PatientPages/PatientProfileEditPage.dart' as dd;
import 'package:shared_preferences/shared_preferences.dart';

import '../customWidgets/styles.dart';
httpServices13 http=new httpServices13();

class PatientAccountPage extends StatefulWidget {
  const PatientAccountPage({super.key});

  @override
  State<PatientAccountPage> createState() => _PatientAccountPageState();
}


Image content = Image.asset('assets/images/demo_user.jpg', fit: BoxFit.fill,);


class _PatientAccountPageState extends State<PatientAccountPage> {
  @override
  Widget build(BuildContext context) {

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
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 100,),
                      WhiteContainer(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: (){
                                      dd.password=posts[0].pass.toString();
                                        dd.nameController.text=posts[0].user_name.toString();
                                        dd.emailController.text=posts[0].user_email.toString();
                                        dd.editedGender=posts[0].gender.toString();
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
                            ],
                          )
                      ),
                      SizedBox(height: 20,),
                      WhiteContainer(
                        child: Container(
                          height: 30,
                          child: InkWell(
                              onTap: (){
                                changePassword();
                                print('Change password');
                              },
                              child: Center(child: Text('Change Password', style: nameSytle,))
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      WhiteContainer(
                        child: Container(
                          height: 30,
                          child: InkWell(
                              onTap: (){
                                print('Logout pressed');
                              },
                              child: Center(child: Text('Log-out', style: nameSytle,))
                          ),
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
                      CircleImage(
                        image: PatientUser.profile.image,
                        onTap: (){
                          showImage();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      );
    }




  void showImage() {
    showDialog(context: context, builder: (context){
      return StatefulBuilder(
          builder: (context, dpState) {

            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Your Profile Image'),
                  IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close))
                ],
              ),
              content: content,
              actions: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: ()async{
                          Uint8List? _imageBytes;
                          final picker = ImagePicker();
                          final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                          dpState(() {
                            if (pickedFile != null){
                              _imageBytes = File(pickedFile.path).readAsBytesSync();
                              content = Image.memory(_imageBytes!);
                            } else {
                              print('No image selected.');
                            }
                          });
                        },
                        child: Text('Change Image')
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text('Cancel')
                        ),
                        ElevatedButton(
                          onPressed: (){
                            setState(() {
                              PatientUser.profile = content;
                            });
                            Navigator.pop(context);
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            );
          }
      );
    });
  }



  void changePassword(){
    showDialog(context: context, builder: (context){
      TextEditingController curPassController = TextEditingController();
      TextEditingController newPassController1 = TextEditingController();
      TextEditingController newPassController2 = TextEditingController();
      return AlertDialog(
        title: Text('Enter current and new passwrd'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: curPassController,
              decoration: InputDecoration(hintText: 'Current Password'),
            ),
            TextField(
              controller: newPassController1,
              decoration: InputDecoration(hintText: 'New Password'),
            ),
            TextField(
              controller: newPassController2,
              decoration: InputDecoration(hintText: 'Re-enter new Password'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Cancel')
          ),
          ElevatedButton(
              onPressed: () {
                //check whether password is correct and both new one are
                //then send request to change password
                print('Change password in database.......');
                Navigator.pop(context);
              },
              child: Text('Change', style: TextStyle(color: Colors.red),)
          ),
        ],
      );
    });
  }


}
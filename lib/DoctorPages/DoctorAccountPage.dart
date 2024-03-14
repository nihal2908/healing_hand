import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healing_hand/DoctorPages/DoctorProfileEditPage.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../customWidgets/styles.dart';

Image dpContent = Image.asset('assets/images/doctor.png', fit: BoxFit.fill,);

class DoctorAccountPage extends StatefulWidget {
  final Doctor doc;
  DoctorAccountPage({super.key, required this.doc});

  @override
  State<DoctorAccountPage> createState() => _DoctorAccountPageState(doc: doc);
}

class _DoctorAccountPageState extends State<DoctorAccountPage> {
  final Doctor doc;
  _DoctorAccountPageState({required this.doc});
  bool showAllReviews = false;

  @override
  Widget build(BuildContext context) {

    bool noReview = (doc.reviews == null);

    return Scaffold(
      appBar: AppBar(
      ),
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: (){

                                //pass the current values to the edit page

                                Navigator.push(context, MaterialPageRoute(builder: (context)=> DoctorProfileEditPage()));
                              },
                              icon: Icon(Icons.edit)
                            ),
                          ),
                          Text(doc.name, style: nameSytle,),
                          Text(doc.category.toString(), style: profileStyle),
                          Text('${doc.age} years', style: profileStyle,),
                          Text(doc.gender.toString(), style: profileStyle),
                          Text(doc.email.toString(), style: profileStyle),
                          RatingBar.builder(
                            initialRating: doc.rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            ignoreGestures: true,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (newRating) {
                              setState(() {
                                doc.rating = newRating;
                              });
                            },
                          ),
                          Text('${doc.rating} / 5', style: profileStyle),
                        ],
                      )
                  ),
                  const SizedBox(height: 20,),
                  WhiteContainer(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Customer reviews', style: nameSytle,),
                            if (widget.doc.reviews!.length > 2)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    showAllReviews = !showAllReviews;
                                  });
                                },
                                child: Text(showAllReviews ? 'Hide' : 'See all'),
                              ),
                          ],
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                noReview? Padding(padding: EdgeInsets.all(10), child: Text('No recent Reviews')):
                                Column(
                                  children: [
                                    // Display two recent reviews
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: showAllReviews ? doc.reviews!.length : doc.reviews!.length>=2 ? 2 : doc.reviews!.length,
                                      itemBuilder: (context, index) {
                                        String review = doc.reviews![index];
                                        List<String> parts = review.split(': ');

                                        return ListTile(
                                          title: Text(parts[0]),
                                          subtitle: Text(parts[1]),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )

                        )
                      ],
                    ),
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
                      image: DoctorUser.profile.image,
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
              content: dpContent,
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
                          dpState(() { //refresh the alert box
                            if (pickedFile != null){
                              _imageBytes = File(pickedFile.path).readAsBytesSync();
                              dpContent = Image.memory(_imageBytes!);
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
                              DoctorUser.profile = dpContent;
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
        surfaceTintColor: Colors.deepPurple,
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

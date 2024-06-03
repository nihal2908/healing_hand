import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healing_hand/DoctorPages/DoctorProfileEditPage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/customWidgets/circularIndicator.dart';
import 'package:healing_hand/firebase/AuthServices.dart';
import 'package:image_picker/image_picker.dart';

Image content = Image.asset('assets/images/default_dp.jpg');
ImageProvider<Object>? currentDp;

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

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class DoctorAccountRequest extends StatelessWidget {
  const DoctorAccountRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firestore.collection('Doctor').doc(currentUserId).get(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            else {
              Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
              return DoctorAccountPage(data: userData);
            }
          }
        }
    );
  }
}


class DoctorAccountPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const DoctorAccountPage({required this.data, super.key});

  @override
  State<DoctorAccountPage> createState() => _DoctorAccountPageState();
}

class _DoctorAccountPageState extends State<DoctorAccountPage> {
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    loadProfileImage();
  }

  Future<void> loadProfileImage() async {
    try {
      // Retrieve profile image URL from Firestore
      DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('Doctor').doc(currentUserId).get();
      setState(() {
        _profileImageUrl = userSnapshot['profile'];
      });
    } catch (error) {
      print('Error loading profile image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String , dynamic> data = widget.data;
    if(data['profile']==null){
      currentDp = const AssetImage('assets/images/default_dp.jpg');
    }
    else{
      currentDp = NetworkImage(data['profile']);
    }
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorProfileEditPage(
                                name: data['name'],
                                age: data['age'],
                                gender: data['gender'],
                                phone: data['phone'],
                                address: data['address'],
                                bio: data['bio'],
                                category: data['category'],
                              )));
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                        Text(data['name'], style: nameSytle,),
                        Text(data['category'], style: profileStyle),
                        Text('${data['age']} years', style: profileStyle,),
                        Text(data['gender'], style: profileStyle),
                        Text(data['phone'], style: profileStyle),
                        Text(data['email'], style: profileStyle),
                        Text(data['bio'], style: profileStyle),
                        Text(data['address'], style: profileStyle),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
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
                          forgotPassword(context);
                        },
                        child: Center(child: Text('Change Password', style: nameSytle,))
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: InkWell(
                        onTap: () async {
                          print('Logout pressed');
                          logOut();
                        },
                        child: Center(child: Text('Log-out', style: nameSytle,))
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 65,
                    child: Center(
                        child: Text(
                            'Your Profile',
                            style: titleStyle
                        )
                    ),
                  ),
                  Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => _buildChangeImageDialog(),
                          );
                        },
                        child: _profileImageUrl != null ?
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(_profileImageUrl!),
                        ) :
                        const CircleAvatar(
                          radius: 35,
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChangeImageDialog() {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Your Profile Image'),
          IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.close))
        ],
      ),
      content: SizedBox(
        height: 200,
        width: 200,
        child: _profileImageUrl != null
            ? Image.network(
          _profileImageUrl!,
          height: 200,
          width: 200,
          fit: BoxFit.fitHeight,
        )
            : Icon(Icons.person, size: 180, color: Colors.grey.shade700,),
      ),
      actions: [
        IconButton(
          onPressed: (){
            pickImage().then((imageFile) {
              if (imageFile != null) {
                Navigator.pop(context);
                uploadImage(imageFile).then((imageUrl) {
                  setState(() {
                    _profileImageUrl = imageUrl;
                  });
                });
              }
            });
          },
          icon: const Icon(Icons.edit,),
        ),
        IconButton(
          onPressed: (){
            confirmDelete();
          },
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      return null;
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    showCircularProgressIndicator(context);
    try {
      // Upload image to Firebase Storage
      String imageName = '${currentUserId}_profile_picture.jpg'; // You can use a unique name for the image
      firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref().child('images').child(imageName);
      await ref.putFile(imageFile);

      // Get download URL of the uploaded image
      String downloadURL = await ref.getDownloadURL();

      // Update profile image URL in Firestore
      await FirebaseFirestore.instance.collection('Doctor').doc(currentUserId).update({
        'profile': downloadURL,
      });
      Navigator.pop(context);
      return downloadURL;
    } catch (error) {
      print('Error uploading image: $error');
      return null;
    }
  }

  Future<void> confirmDelete() async {
    showDialog(
        context: context,
        builder: (context)=>
            AlertDialog(
              content: const Text('Do you wnat to remove your Profile Picture?'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(onPressed: () async {
                      Navigator.pop(context);
                      showCircularProgressIndicator(context);
                      await deleteProfileImage().then((_) {
                        setState(() {
                          _profileImageUrl = null;
                        });
                        Navigator.pop(context);
                      });
                    }, child: const Text('Delete')),
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: const Text('Cancel'))
                  ],
                )
              ],
            )
    );
  }

  Future<void> deleteProfileImage() async {
    try {
      // Remove 'profile' field from the user's document
      await FirebaseFirestore.instance.collection('Doctor').doc(currentUserId).update({
        'profile': FieldValue.delete(),
      });
      print('Profile image deleted');
    } catch (error) {
      print('Error deleting profile image: $error');
    }
  }

  void logOut(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: const Text('Do you want to Log-out? This will close the app.'),
        actions: [
          ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text('Cancel')
          ),
          ElevatedButton(
              onPressed: () async {
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // prefs.setString('FIRST_PAGE', 'userselection');

                if (Platform.isAndroid) {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
              child: const Text('Log-out', style: TextStyle(color: Colors.red),)
          ),
        ],
      );
    });
  }

  void forgotPassword(BuildContext context){
    showDialog(
        context: context,
        builder: (context){
          TextEditingController forgotController = TextEditingController();
          String message = 'Email Sent';
          return AlertDialog(
            title: const Text('Forgot Password'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Enter your email, a password reset link will be sent to your email'),
                TextField(
                  controller: forgotController,
                ),
                ElevatedButton(onPressed: () async {
                  try {
                    await firebaseAuth.sendPasswordResetEmail(
                        email: forgotController.text.trim());
                  }
                  catch (e){
                    message = e.toString();
                  }
                  print(message);
                }, child: const Text('Confirm'))
              ],
            ),
          );
        }
    );
  }
}
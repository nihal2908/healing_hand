import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healing_hand/firebase/AuthServices.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      await FirebaseFirestore.instance.collection('Patient').doc(currentUserId).get();
      setState(() {
        _profileImageUrl = userSnapshot['profile'];
      });
    } catch (error) {
      print('Error loading profile image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => _buildChangeImageDialog(),
            );
          },
          child: _profileImageUrl != null
              ? CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(_profileImageUrl!),
          )
              : CircleAvatar(
            radius: 50,
            child: Icon(Icons.person),
          ),
        ),
      ),
    );
  }

  Widget _buildChangeImageDialog() {
    return AlertDialog(
      title: Text('Change Profile Image'),
      content: _profileImageUrl != null
          ? Image.network(
        _profileImageUrl!,
        height: 200,
        width: 200,
        fit: BoxFit.cover,
      )
          : Container(),
      actions: [
        TextButton(
          onPressed: () {
            // Open image picker to select a new image
            pickImage().then((imageFile) {
              if (imageFile != null) {
                // Upload new image to Firebase Storage and update profile image URL
                uploadImage(imageFile).then((imageUrl) {
                  setState(() {
                    _profileImageUrl = imageUrl;
                  });
                });
              }
            });
          },
          child: Text('Change Image'),
        ),
        TextButton(
          onPressed: () {
            // Close dialog box
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
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
    try {
      // Upload image to Firebase Storage
      String imageName = 'profile_picture.jpg'; // You can use a unique name for the image
      firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref().child('images').child(imageName);
      await ref.putFile(imageFile);

      // Get download URL of the uploaded image
      String downloadURL = await ref.getDownloadURL();

      // Update profile image URL in Firestore
      await FirebaseFirestore.instance.collection('Patient').doc(currentUserId).update({
        'profile': downloadURL,
      });

      return downloadURL;
    } catch (error) {
      print('Error uploading image: $error');
      return null;
    }
  }
}
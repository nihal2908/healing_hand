import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/DoctorLandingPage.dart';
import 'package:healing_hand/firebase/user_manager.dart';

class AuthServices{

  //instance
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //get current user
  User? getCurentUser (){
    return auth.currentUser;
  }

  //signout
  Future<void> signOut () async {
    await auth.signOut();
    UserManager.signOut();
    return;
  }

  Future<UserCredential?> login({
    required BuildContext context,
    required String email,
    required String password
  }) async {
    try {
      _showLoadingDialog(context);
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.of(context).pop();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      _showErrorDialog(context, e.message!);
      throw Exception(e.code);
    }
  }

  Future<UserCredential> register({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String gender,
  }) async {
    try {
      _showLoadingDialog(context);
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'name': name,
        'gender': gender,
        'accountDate': FieldValue.serverTimestamp()
      });
      Navigator.of(context).pop();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      _showErrorDialog(context, e.message!);
      throw Exception(e.code);
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Center(child: CircularProgressIndicator(color: Colors.white,)),
        );
      },
    );
  }

/*
  void _showEmailVerify(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Email not verified'),
          content: const Text('A verification link is sent to your email. Please verify it\'s you.'),
          actions: [
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text('Retry')),
          ],
        );
      },
    );
  }
*/

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //////////////////////////////////////////////// for doctor ////////////////////////////////////////////////////

  //doctor login
  Future<UserCredential> doctorLogin({
    required BuildContext context,
    required String email,
    required String password
  }) async {
    try {
      _showLoadingDialog(context);
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        final uid = user.uid;
        final doc = await firestore.collection('Doctor').doc(uid).get();
        if (doc.exists) {
          await UserManager.initializeUserId(usertype: 'Doctor');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DoctorLandingPage()),
          );
        } else {
          _showMessage(context: context, message: 'No Doctor found for this credential.');
        }
      }
      Navigator.of(context).pop();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      _showErrorDialog(context, e.message!);
      throw Exception(e.code);
    }
  }

  void _showMessage({required BuildContext context, required String message}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //doctor signup
  Future<UserCredential> doctorSignin ({
    required String email,
    required String password,
    required String name,
    required String gender,
    required String phone,
    required int age,
    required double rating,
    required List<String> reviews,
    required String category,
    required String bio,
    required String address,
  }) async {
    try{
      UserCredential userCredential =  await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //add it to the list of users
      firestore.collection('Doctor').doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
            'name' : name,
            'phone': phone,
            'age': age,
            'gender': gender,
            'category': category,
            'bio': bio,
            'address': address,
            'rating': rating,
            'reviews': reviews,
          }
      );

      await UserManager.initializeUserId(usertype: 'Doctor');
      return userCredential;
    }
    on FirebaseAuthException catch (e){
      //print('kuchh gadbad hai daya ');
      throw Exception(e.code);
    }
  }

  Future<void> editDocRecord({
    required String name,
    required String phone,
    required String bio,
    required String address,
    required String category,
    required int age,
    required String gender,
  }) async {
    await firestore.collection('Doctor').doc(UserManager.userId).update(
        {
          'name' : name,
          'phone': phone,
          'age': age,
          'gender': gender,
          'bio': bio,
          'address': address,
          'category' : category,
        }
    );
  }



  //////////////////////////////////////////////// for patient ////////////////////////////////////////////////////

  //patient login
  Future<UserCredential> patientLogin(String email, String password) async {

    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      await UserManager.initializeUserId(usertype: 'Patient');
      return userCredential;
    }
    on FirebaseAuthException catch (e) {
      print(e.code);
      throw Exception(e.toString());
    }
  }

  //patient signup
  Future<UserCredential> patientSignin ({
    required String email,
    required String password,
    required String name,
    required String phone,
    required int age,
    required String gender,
    required double height,
    required double weight,
  }) async {
    try{
      UserCredential userCredential =  await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //add it to the list of users
      firestore.collection('Patient').doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
            'name' : name,
            'phone': phone,
            'age': age,
            'gender': gender,
            'height': height,
            'weight': weight,
          }
      );
      await UserManager.initializeUserId(usertype: 'Patient');
      return userCredential;
    }
    on FirebaseAuthException catch (e){
      //print('kuchh gadbad hai daya ');
      throw Exception(e.code);
    }
  }

  Future<void> editPatRecord({
    required String name,
    required String phone,
    required int age,
    required String gender,
    required double height,
    required double weight,
  }) async {
    await firestore.collection('Patient').doc(UserManager.userId).update(
        {
          'name' : name,
          'phone': phone,
          'age': age,
          'gender': gender,
          'height': height,
          'weight': weight,
        }
    );
  }

  ///////////////////////// notes ////////////////////////////
  Future<void> createNote({required String docId, required String patId, required String note}) async {
    await firestore.collection('Notes').add(
      {
        'docId': docId,
        'patId': patId,
        'note': note
      }
    );
  }
}
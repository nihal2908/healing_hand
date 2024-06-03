import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';

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
    return await auth.signOut();
  }


  //////////////////////////////////////////////// for doctor ////////////////////////////////////////////////////

  //doctor login
  Future<UserCredential> doctorLogin(String email, String password) async {
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      print('credentials sahi hain');
      currentUserId = await  userCredential.user!.uid;
      currentUserEmail = await userCredential.user!.email!;
      print(currentUserId);
      print(currentUserId.runtimeType);
      print(currentUserEmail);
      return userCredential;
    }
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
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
      print('bana diya doctor ka naya account');

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

      currentUserId = await  userCredential.user!.uid;
      currentUserEmail = await userCredential.user!.email!;
      print(currentUserId);
      print(currentUserEmail);
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
    await firestore.collection('Doctor').doc(currentUserId).update(
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
      print('credentials sahi hain');
      currentUserId = await  userCredential.user!.uid;
      currentUserEmail = await userCredential.user!.email!;
      print(currentUserId);
      print(currentUserEmail);
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
      print('bana diya patient ka naya account');

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
      currentUserId = await  userCredential.user!.uid;
      currentUserEmail = await userCredential.user!.email!;
      print(currentUserId);
      print(currentUserEmail);
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
    await firestore.collection('Patient').doc(currentUserId).update(
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

String currentUserId = '';
String currentUserEmail = '';
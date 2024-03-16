import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{

  //instance
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  //get current user
  User? getCurentUser (){
    return auth.currentUser;
  }


  //signin
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try{
       UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      print('credentials sahi hain');
      //add it to the list of users
      firestore.collection('Users').doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email
          }
      );
       return userCredential;
    }
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  //signup
  Future<UserCredential> signUpWithEmailPassword (String email, String password) async {
    try{
      UserCredential userCredential =  await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('bana diya naya account');

      //add it to the list of users
      firestore.collection('Users').doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email
        }
      );

      return userCredential;
    }
    on FirebaseAuthException catch (e){
      //print('kuchh gadbad hai daya ');
      throw Exception(e.code);
    }
  }
  //erroes


  //signout
  Future<void> signOut () async {
    return await auth.signOut();
  }






  //////////////////////////////////////////////// for doctor ////////////////////////////////////////////////////

  //doctor login
  Future<UserCredential> doctorLogin(String email, password) async {
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      print('credentials sahi hain');
      //add it to the list of users
      // firestore.collection('Doctor').doc(userCredential.user!.uid).set(
      //     {
      //       'uid': userCredential.user!.uid,
      //       'email': email,
      //       'name' : name,
      //       'patients': patients,
      //     }
      // );
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
  Future<UserCredential> doctorSignin (String email, String password, String name, List<String> patients) async {
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
            'patients': patients,
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





  //////////////////////////////////////////////// for patient ////////////////////////////////////////////////////

  //doctor login
  Future<UserCredential> patientLogin(String email, password) async {
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      print('credentials sahi hain');
      //add it to the list of users
      // firestore.collection('Doctor').doc(userCredential.user!.uid).set(
      //     {
      //       'uid': userCredential.user!.uid,
      //       'email': email,
      //       'name' : name,
      //       'patients': patients,
      //     }
      // );
      currentUserId = await  userCredential.user!.uid;
      currentUserEmail = await userCredential.user!.email!;
      print(currentUserId);
      print(currentUserEmail);
      return userCredential;
    }
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //doctor signup
  Future<UserCredential> patientSignin (String email, String password, String name, List<String> doctors) async {
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
            'doctors': doctors,
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




}

String currentUserId = '';
String currentUserEmail = '';
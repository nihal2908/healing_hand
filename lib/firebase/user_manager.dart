import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManager {
  static String? _userId;
  static String? _emailId;
  static String? _userType;
  static Map<String, dynamic>? _userData;

  static Future<void> initializeUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userId = user.uid;
      _emailId = user.email;
      await _retrieveUserType();
      await _retrieveUserData();
    } else {
      // Handle the case where there is no logged-in user
      _userId = null;
      _emailId = null;
      _userType = null;
      _userData = null;
    }
  }

  static Future<void> _retrieveUserType() async {
    if (_userId != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(_userId).get();
      _userType = doc['usertype'];
    }
  }

  static Future<void> _retrieveUserData() async {
    if (_userId != null && _userType != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection(_userType!).doc(_userId).get();
      _userData = doc.data() as Map<String, dynamic>?;
    }
  }

  static String? get userId => _userId;
  static String? get emailId => _emailId;
  static String? get userType => _userType;
  static Map<String, dynamic>? get userData => _userData;

  // Call this function during signout
  static void signOut() {
    _userId = null;
    _emailId = null;
    _userType = null;
    _userData = null;
  }
}

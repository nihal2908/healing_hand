import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healing_hand/firebase/AuthServices.dart';
import 'package:http/http.dart' as http;

class PushNotification{
  //instance
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

}

void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if(settings.authorizationStatus == AuthorizationStatus.authorized){
    print('Granted Noti. perm.');
  }
  else if(settings.authorizationStatus == AuthorizationStatus.provisional){
    print('Provisional perm.');
  }
  else {
    print('User declined perm.');
  }
}

void getToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print('Token is $token');
  saveToken(token!);
}

void saveToken(String token) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = AuthServices();
  firestore.collection('user_tokens').doc(auth.getCurentUser()!.uid).set({
    'token': token
  });
}

void sendPushMessage(String recieverId, String message, String name) async {
  try{
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key='
      }
    );
  }
  catch(e){}
}
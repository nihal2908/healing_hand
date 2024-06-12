import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healing_hand/firebase/AuthServices.dart';
import 'package:healing_hand/firebase/message.dart';

class ChatService{

  //get instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;


  //get user stream (not used)
  Stream<List<Map<String, dynamic>>> getUserStream(){
    return firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc){
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String recieverId, message) async {
    //get current user info
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String currentUserId = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();


    //create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      recieverId: recieverId,
      message: message,
      timestamp: timestamp,
    );

    //construct a chat room id
    List<String> ids = [currentUserId, recieverId];
    // making the chat room id by joing the user ids of the sender, reciever
    ids.sort();
    String chatRoomID = ids.join('_');

    //add new message to database
    await firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap()
    );
  }

  //get message
  //getting messages
  Stream<QuerySnapshot> getMessages(String userId, otherUserId){
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }




// Function to retrieve UID based on email
  Future<String> getUIDFromEmail(String email) async {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Doctor")
          .where("email", isEqualTo: email)
          .get();

        return querySnapshot.docs.first.id;
  }







  Future<void> sendMessage2(String senderemail, recieveremail, message) async {
    //get current user info
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    //create a new message
    Message2 newMessage = Message2(
      senderemail: senderemail,
      recieveremail: recieveremail,
      message: message,
      timestamp: FieldValue.serverTimestamp(),
    );

    //construct a chat room id
    List<String> ids = [senderemail, recieveremail];
    // making the chat room id by joing the user ids of the sender, reciever
    ids.sort();
    String chatRoomID = ids.join('_');

    //add new message to database
    await firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap()
    );
    //add the id as a member of that collection
    // await firestore
    //     .collection('chat_rooms')
    //     .doc(chatRoomID)
    //     .update({
    //       'rid' :
    //     })
    //     //.set(newMessage.toMap()
    // );
  }




  Stream<QuerySnapshot> getMessages2(String senderemail, recieveremail){
    List<String> ids = [senderemail, recieveremail];
    ids.sort();
    String chatRoomId = ids.join('_');

    return firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Stream<List<Map<String, dynamic>>> getPatientStream(){
    return firestore.collection('Patient').snapshots().map((snapshot) {
      return snapshot.docs.map((doc){
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> getDoctorStream(){
    return firestore.collection('Doctor').snapshots().map((snapshot) {
      return snapshot.docs.map((doc){
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> getRoomStream(){
    return firestore.collection('chat_rooms').snapshots().map((snapshot) {
      return snapshot.docs.map((doc){
        final user = doc.data();
        return user;
      }).toList();
    });
  }

}

class Message2{
  final String message;
  final String senderemail;
  final String recieveremail;
  final dynamic timestamp;

  Message2({
    required this.message,
    required this.senderemail,
    required this.recieveremail,
    required this.timestamp
  });

  Map<String, dynamic> toMap(){
    return{
      'message': message,
      'sender': senderemail,
      'reciever': recieveremail,
      'timestamp': timestamp
    };
  }

}
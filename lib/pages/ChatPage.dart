import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/chat_services/chatServices.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/customWidgets/styles.dart';
import 'package:healing_hand/firebase/AuthServices.dart';
import 'package:healing_hand/pages/ChatRoom.dart';

final AuthServices auth = AuthServices();


class UserTile extends StatelessWidget{

  final String text;
  final void Function()? onTap;

  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: GestureDetector(
        child: WhiteContainer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300
                    ),
                    child: Icon(Icons.person)
                ),
                SizedBox(width: 10,),
                Text(text),
              ],
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

}


class ChatPage2 extends StatelessWidget {
  ChatPage2({super.key, required this.usertype});
  final String usertype;
  //geting instance of services
  final ChatService chatService = ChatService();
  final AuthServices authServices = AuthServices();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return usertype == 'doctor' ? buildUserList2(): buildUserList3();
  }

  // geting all the patients on doctor side
  Widget buildUserList2(){
    return StreamBuilder(
        stream: chatService.getPatientStream(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text('Error');
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return Text('Loading...');
          }
          else{
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: Text('Chat with your Patients', style: titleStyle,)
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.map<Widget>((userData) => buildUserListItem2(userData, context)).toList(),
                  ),
                ],
              ),
            );
          }
        }
    );
  }

  // geting all the doctors on patient side
  Widget buildUserList3(){
    return StreamBuilder(
        stream: chatService.getDoctorStream(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text('Error');
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return Text('Loading...');
          }
          else{
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 100,
                    child: Center(child: Text('Chat with Doctors', style: titleStyle,)),
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.map<Widget>((userData) => buildUserListItem3(userData, context)).toList(),
                  ),
                ],
              ),
            );
          }
        }
    );
  }



  // // list of all the chat rooms
  // Widget buildUserList4(){
  //   return StreamBuilder(
  //       stream: chatService.getRoomStream(),
  //       builder: (context, snapshot){
  //         if(snapshot.hasError){
  //           return Text('Error');
  //         }
  //         else if(snapshot.connectionState == ConnectionState.waiting){
  //           return Text('Loading...');
  //         }
  //         else{
  //           return ListView(
  //             children: snapshot.data!.map<Widget>((userData) => buildUserListItem4(userData, context)).toList(),
  //           );
  //         }
  //       }
  //   );
  // }



  // build the list of patients
  Widget buildUserListItem2(Map<String, dynamic> userData, BuildContext context) {
    // tempUserData = userData;
    //List<String> doctors = userData['doctors'].cast<String>().toList();
    //if(doctors.contains(currentUserId)){
    String name = userData['name'];
    return UserTile(
          text: name,
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=>
                    ChatRoom3(senderemail: currentUserEmail, recieveremail: userData['email'],name: name,)
            ));
          }
      );
    }
    // else{
    //   return Container(
    //     height: 30,
    //     width: 30,
    //     color: Colors.red,
    //   );
    // }
  }

  // build all the doctors list on patient side
  Widget buildUserListItem3(Map<String, dynamic> userData, BuildContext context) {
    String name = userData['name'];
    return UserTile(
        text: name,
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>
                  ChatRoom3(senderemail: currentUserEmail, recieveremail: userData['email'], name: name,)
          ));
        }
    );
  }

  // all chat rooms in which that doctor is
  Widget buildUserListItem4(Map<String, dynamic> userData, BuildContext context) {
    String name = userData['name'];
    String id = userData['rid'].toString();
    List<String> parts = id.split('_').toList();
    if(parts[1] == currentUserEmail){
//    if(doctors.contains(currentUserId)){
      return UserTile(
          text: userData['name'],
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=>
                    ChatRoom3(senderemail: currentUserEmail, recieveremail: userData['email'],name: name,)
            ));
          }
      );
    }
    else{
      return Container();
    }
  }


class UserTile2 extends StatelessWidget{

  final String text;
  final void Function()? onTap;

  const UserTile2({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.person),
            Text(text),
          ],
        ),
      ),
      onTap: onTap,
    );
  }

}
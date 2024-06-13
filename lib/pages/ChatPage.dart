import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/chat_services/chatServices.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/customWidgets/styles.dart';
import 'package:healing_hand/firebase/AuthServices.dart';
import 'package:healing_hand/pages/ChatRoom.dart';

final AuthServices auth = AuthServices();


class UserTile extends StatelessWidget{
  final String profile;
  final String text;
  final void Function()? onTap;

  const UserTile({
    super.key,
    required this.profile,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: GestureDetector(
        onTap: onTap,
        child: WhiteContainer(
          child: Row(
            children: [
              profile == 'none' ? Container(
                  decoration: BoxDecoration(
                      //shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: const Icon(Icons.person, size: 50, color: Colors.grey,)
              ) :
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(profile),
              ),
              const SizedBox(width: 10,),
              Text(text, style: const TextStyle(fontSize: 16),),
            ],
          ),
        ),
      ),
    );
  }

}


class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.usertype});
  final String usertype;
  //geting instance of services
  final ChatService chatService = ChatService();
  final AuthServices authServices = AuthServices();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return usertype == 'doctor' ? buildPatientList(): buildDoctorList();
  }

  // getting all the patients on doctor side
  Widget buildPatientList(){
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
                    children: snapshot.data!.map<Widget>((userData) => buildPatientChatTile(userData, context)).toList(),
                  ),
                ],
              ),
            );
          }
        }
    );
  }

  // getting all the doctors on patient side
  Widget buildDoctorList(){
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
                    children: snapshot.data!.map<Widget>((userData) => buildDoctorChatTile(userData, context)).toList(),
                  ),
                ],
              ),
            );
          }
        }
    );
  }



  // build the list of patients
  Widget buildPatientChatTile(Map<String, dynamic> userData, BuildContext context) {
    String profile = userData['profile']?? 'none';
    String name = userData['name'];
    return UserTile(
      profile: profile,
      text: name,
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>
                ChatRoom3(senderemail: currentUserEmail, recieveremail: userData['email'],name: name,)
        ));
      }
    );
  }


  // build all the doctors list on patient side
  Widget buildDoctorChatTile(Map<String, dynamic> userData, BuildContext context) {
    String profile = userData['profile'] ?? 'none';
    String name = userData['name'];
    return UserTile(
        profile: profile,
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
    String profile = userData['profile'] ?? 'none';
    String id = userData['rid'].toString();
    List<String> parts = id.split('_').toList();
    if(parts[1] == currentUserEmail){
      return UserTile(
          profile: profile,
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

}
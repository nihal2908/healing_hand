import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/chat_services/chatServices.dart';
import 'package:healing_hand/firebase/AuthServices.dart';

class ChatRoom extends StatelessWidget {
  ChatRoom({super.key, required this.recieverEmail, required this.recieverId});
  final String recieverEmail;
  final String recieverId;

  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final AuthServices authServices = AuthServices();

  void sendMessage() async {
    if(messageController.text.isNotEmpty){
      await chatService.sendMessage(recieverId, messageController.text);
    }
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recieverEmail),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child: buildMessageList()
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: (){
                      sendMessage();
                    },
                    icon: Icon(Icons.send)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget buildMessageList(){
    return StreamBuilder(
        stream: chatService.getMessages(authServices.getCurentUser()!.uid, recieverId),
        builder: (context, snapshot){

          if(snapshot.hasError){
            return Text('Error');
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return Text('Loading...');
          }
          else{
            return ListView(
              children: snapshot.data!.docs.map((doc) => buildMessageItem(doc)).toList(),
            );
          }
        }
    );
  }


  Widget buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool recieved = data['recieverId'] == recieverId;

    return Container(
      alignment: recieved ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        children: [
          Text(data['message'], style: TextStyle(color: data['recieverId'] == recieverId ? Colors.red : Colors.white)),
        ],
      ),
    );
  }

}



class ChatRoom2 extends StatelessWidget {
  ChatRoom2({super.key, required this.senderemail, required this.recieveremail});
  final String senderemail;
  final String recieveremail;

  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final AuthServices authServices = AuthServices();

  void sendMessage2() async {
    if(messageController.text.isNotEmpty){
      await chatService.sendMessage2(senderemail, recieveremail, messageController.text);
    }
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child: buildMessageList2()
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: (){
                      sendMessage2();
                    },
                    icon: Icon(Icons.send)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMessageList2(){
    return StreamBuilder(
        stream: chatService.getMessages2(senderemail, recieveremail),
        builder: (context, snapshot){

          if(snapshot.hasError){
            return Text('Error');
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return Text('Loading...');
          }
          else{
            return ListView(
              children: snapshot.data!.docs.map((doc) => buildMessageItem2(doc)).toList(),
            );
          }
        }
    );
  }


  Widget buildMessageItem2(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool recieved = data['reciever'] == senderemail;

    return Container(
      alignment: recieved ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        children: [
          Text(data['message'], style: TextStyle(color: recieved ? Colors.red : Colors.white)),
        ],
      ),
    );
  }

}

/////////////////////////////////////////////////////////////////////// for doctors //////////////////////////////////////////////////////////
class ChatRoom3 extends StatelessWidget {
  ChatRoom3({super.key, required this.senderemail, required this.recieveremail, required this.name});
  final String name;
  final String senderemail;
  final String recieveremail;

  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final AuthServices authServices = AuthServices();

  void sendMessage3() async {
    if(messageController.text.isNotEmpty){
      await chatService.sendMessage2(senderemail, recieveremail, messageController.text);
    }
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child: buildMessageList3()
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).cardColor,
                      filled: true,
                      hintText: 'Enter message...'
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).cardColor
                  ),
                  margin: EdgeInsets.only(left: 10),
                  child: IconButton(
                      onPressed: (){
                        sendMessage3();
                      },
                      icon: Icon(Icons.send)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMessageList3(){
    return StreamBuilder(
        stream: chatService.getMessages2(senderemail, recieveremail),
        builder: (context, snapshot){

          if(snapshot.hasError){
            return Text('Error');
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return Text('Loading...');
          }
          else{
            return ListView(
              children: snapshot.data!.docs.map((doc) => buildMessageItem3(doc, context)).toList(),
            );
          }
        }
    );
  }


  Widget buildMessageItem3(DocumentSnapshot doc, BuildContext context){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool recieved = data['reciever'] == senderemail;
    Color sendbubble;
    Color recbubble;
    if(Theme.of(context).brightness == Brightness.light){
      sendbubble = Colors.green.shade200;
      recbubble = Colors.grey.shade200;
    }
    else{
      sendbubble = Colors.green.shade800;
      recbubble = Colors.grey.shade800;
    }
    return Container(
      alignment: recieved ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: recieved ? recbubble : sendbubble,
          borderRadius: BorderRadius.circular(15)
        ),
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
          margin: EdgeInsets.all(3),
          child: Text(
              data['message'], style: TextStyle(fontSize: 17),
          )
      ),
    );
  }

}
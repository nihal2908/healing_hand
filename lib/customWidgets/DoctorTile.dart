import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/DoctorViewPage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';

class DoctorTile extends StatelessWidget{
  final String uid;
  final Widget profile;
  final String name;
  final String category;

  DoctorTile({required this.uid, required this.name, required this.profile, required this.category});

  @override
  Widget build(BuildContext context){
    // return WhiteContainer(
    //   child: ListTile(
    //     leading: profile,
    //     title: Text(name),
    //     subtitle: Text(category),
    //     onTap: (){
    //       Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorViewPage(uid: uid,)));
    //     },
    //   ),
    // );
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,//Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListTile(
        leading: profile,
        title: Text(name),
        subtitle: Text(category),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorViewPage(uid: uid,)));
        },
      ),
    );
  }
}
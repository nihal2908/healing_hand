import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/DoctorViewPage.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';

class DoctorTile extends StatelessWidget{
  final Doctor doc;
  DoctorTile({required this.doc});

  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListTile(
        leading: doc.profile,
        title: Text(doc.name),
        subtitle: Text(doc.category),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorViewPage(doc: doc)));
        },
      ),
    );
  }
}
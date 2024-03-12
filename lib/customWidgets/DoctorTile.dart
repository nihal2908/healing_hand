import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/DoctorViewPage.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/modelclass/prodmodal.dart';
 String? name1;
  String? phone1;
  String? email1;
  String? category1;
  String? address1;
  String? gender1;
  String? age1; 
  String? rating1;
  String? review1;

class DoctorTile extends StatelessWidget{

  DoctorTile({name,email,category,age,gender,phone,address,rating})
  {
 name1=name;
 phone1=phone;
   email1=email;
   category1=category;
   address1=address;
 gender1=gender;
   age1=age; 
   rating1=rating;
  // review1=review;
  }
  @override
  Widget build(BuildContext context){
    print("mca");
    print(name1);
    print(email1);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(name1.toString()),
        subtitle: Text(category1.toString()),
        onTap: (){
          print("ggg");
         print(email1);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorViewPage(name: name1,
                                    email: email1,category: category1,gender:gender1,
                                    phone: phone1,)));
        },
      ),
    );
  }
}
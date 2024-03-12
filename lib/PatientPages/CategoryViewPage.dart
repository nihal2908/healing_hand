import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientHomePage.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/apiconnection/doctorview.dart';
import 'package:healing_hand/customWidgets/DoctorTile.dart';
import 'package:healing_hand/modelclass/prodmodal.dart';
httpServices13 http=new httpServices13();
String? key2;

class CategoryViewPage extends StatefulWidget {
   String? category;
   CategoryViewPage({
    key1
   })
   {
    key2=key1;
   }
_CategoryViewPageState createState()
{
  return _CategoryViewPageState(); 
}
}

class _CategoryViewPageState extends State<CategoryViewPage> {

  @override
  Widget build(BuildContext context) {
    // List<Doctor> filteredList = doctors.where((obj) =>
    //     obj.category.toLowerCase() == widget.category.toLowerCase())
    //     .toList();


    return  FutureBuilder<List<prodModal>>(
      future: http.getAllPost(key2.toString()),
      builder: ((context, snapshot) {
        print("calm down");
        // print(key);
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Scaffold(
              body:
                  Center(heightFactor: 1.4, child: CircularProgressIndicator()),
            );
          case ConnectionState.waiting:
            return Scaffold(
              body:
                  Center(heightFactor: 0.4, child: CircularProgressIndicator()),
            );
          case ConnectionState.active:
          if(snapshot.data!=null)
            return ShowPostList(context, snapshot.data!);
            else return Scaffold(
              backgroundColor: Colors.purple,
              appBar: AppBar(title: Text(key2.toString()),),
            );

          case ConnectionState.done:
if(snapshot.data!=null)
            return ShowPostList(context, snapshot.data!);
            else return Scaffold(
              backgroundColor: Colors.purple,
              appBar: AppBar(title: Text(key2.toString()),),);        }
        //}

        //else{
        //return CircularProgressIndicator();
        //}

        //  return CircularProgressIndicator();
      }),
    );
  }
  Widget ShowPostList(BuildContext context,List<prodModal> posts)
  {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text(key2.toString()),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.separated(
            shrinkWrap: true,
              itemBuilder: (context, index){
                return DoctorTile(name: posts[index].name,
                                    age:posts[index].age,email: posts[index].email,category: posts[index].category,gender:posts[index].category,
                                    phone: posts[index].phone);
              },
              separatorBuilder: (context, index) => SizedBox(height: 10,),
              itemCount: posts.length
          ),
        ),
      ),
    );
  }
}

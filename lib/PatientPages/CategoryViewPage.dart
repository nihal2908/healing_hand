import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/DoctorTile.dart';

class CategoryViewPage extends StatefulWidget {
   final String category;
   CategoryViewPage({required this.category});

   _CategoryViewPageState createState() => _CategoryViewPageState();
}

class _CategoryViewPageState extends State<CategoryViewPage> {

  List<Map<String, dynamic>> doctors = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    final querySnapshot = await firestore.collection('Doctor').where('category', isEqualTo: widget.category).get();
    setState(() {
      doctors = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      // body: FutureBuilder(
      //   future: fetchDoctors(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(color: Colors.white,),
      //       );
      //     } else if (snapshot.hasError) {
      //       return Center(
      //         child: Text('Error: ${snapshot.error}'),
      //       );
      //     } else {
      //       return SingleChildScrollView(
      //         child: Padding(
      //           padding: const EdgeInsets.all(8),
      //           child: ListView.separated(
      //             shrinkWrap: true,
      //             itemBuilder: (context, index) {
      //               return DoctorTile(
      //                 name: doctors[index]['name'],
      //                 category: doctors[index]['category'],
      //                 uid: doctors[index]['uid'],
      //                 profile: CircleImage(image: doctors[index]['profile'],),
      //               );
      //             },
      //             separatorBuilder: (context, index) => const SizedBox(height: 10,),
      //             itemCount: doctors.length,
      //           ),
      //         ),
      //       );
      //     }
      //   },
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return DoctorTile(
                name: doctors[index]['name'],
                category: doctors[index]['category'],
                uid: doctors[index]['uid'],
                profile: CircleImage(image: NetworkImage(doctors[index]['profile']),),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10,),
            itemCount: doctors.length,
          ),
        ),
      ),
    );
  }
}

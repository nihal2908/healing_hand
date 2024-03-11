import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/DoctorTile.dart';

class CategoryViewPage extends StatefulWidget {
  final String category;
  CategoryViewPage({super.key, required this.category});

  @override
  State<CategoryViewPage> createState() => _CategoryViewPageState();
}

class _CategoryViewPageState extends State<CategoryViewPage> {

  @override
  Widget build(BuildContext context) {
    List<Doctor> filteredList = doctors.where((obj) =>
        obj.category.toLowerCase() == widget.category.toLowerCase())
        .toList();


    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.separated(
            shrinkWrap: true,
              itemBuilder: (context, index){
                return DoctorTile(doc: filteredList[index]);
              },
              separatorBuilder: (context, index) => SizedBox(height: 10,),
              itemCount: filteredList.length
          ),
        ),
      ),
    );
  }
}

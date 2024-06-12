import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/DoctorTile.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> doctors = [];
  List<Map<String, dynamic>> filteredDoctors = [];
  bool searchByName = true;

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    final querySnapshot = await firestore.collection('Doctor').get();
    setState(() {
      doctors = querySnapshot.docs.map((doc) => doc.data()).toList();
      filteredDoctors = List.from(doctors);
    });
  }

  void filterDoctors(String query) {
    setState(() {
      filteredDoctors = doctors
          .where((doctor) =>
      searchByName
          ? doctor['name'].toLowerCase().contains(query.toLowerCase())
          : doctor['category'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: TextFormField(
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            suffixIcon: PopupMenuButton<bool>(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text(
                      'Search by Name',
                      style: TextStyle(color: !searchByName ? Colors.grey : Colors.black),
                    ),
                    value: true,
                  ),
                  PopupMenuItem(
                    child: Text(
                      'Search by Category',
                      style: TextStyle(color: searchByName ? Colors.grey : Colors.black),
                    ),
                    value: false,
                  ),
                ];
              },
              onSelected: (value) {
                setState(() {
                  searchByName = value!;
                });
              },
              icon: Icon(Icons.tune),
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            hintText: 'Search..',
            contentPadding: EdgeInsets.all(5),
            border: OutlineInputBorder(
              borderSide: const BorderSide(),
              borderRadius: BorderRadius.circular(26),
            ),
          ),
          onChanged: (query) {
            filterDoctors(query);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: filteredDoctors.length,
          itemBuilder: (context, index) {
            final doctor = filteredDoctors[index];
            return DoctorTile(
              profile: doctor['profile']!=null ? CircleImage(image: NetworkImage(doctor['profile'])) : CircleImage(image: AssetImage('assets/images/doctor.png')),
              uid: doctor['uid'],
              name: doctor['name'],
              category: doctor['category'],
            );
          },
        ),
      ),
    );
  }
}

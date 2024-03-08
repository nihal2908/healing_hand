import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/DoctorTile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Doctor> filteredObjects = [];
  bool searchByName = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: SizedBox(),
        leadingWidth: 0,
        title: TextFormField(
          autofocus: true,
          enabled: true,
          enableSuggestions: true,
          decoration: InputDecoration(
            prefixIcon: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){Navigator.pop(context);},
            ),
            suffixIcon: PopupMenuButton<bool>(
              itemBuilder: (context){
                return [
                  PopupMenuItem(child: Text('Search by Name', style: TextStyle(color: !searchByName? Colors.grey: Colors.black),), value: true,),
                  PopupMenuItem(child: Text('Search by Category', style: TextStyle(color: searchByName? Colors.grey: Colors.black),), value: false,),
                ];
              },
              onSelected: (value){
                setState(() {
                  searchByName = value;
                });
              },
              icon: Icon(Icons.tune),
            ),
            filled: true,
            fillColor: Colors.grey.shade200,
            hintText: 'Search..',
            contentPadding: EdgeInsets.all(5),
            border: OutlineInputBorder(
                borderSide: const BorderSide(),
                borderRadius: BorderRadius.circular(26)
            ),
          ),
          onChanged: (query) {
            setState(() {
              filteredObjects = searchByName?
              doctors.where((obj) =>
              obj.name.toLowerCase().contains(query.toLowerCase()))
                  .toList() :
              doctors.where((obj) =>
              obj.category.toLowerCase().contains(query.toLowerCase()))
                  .toList();
              //sorting the new list in reverse lexigraphical order
              filteredObjects.sort((a, b) => b.name.compareTo(a.name));
            });
          },
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(height: 5,),
                itemCount: filteredObjects.length,
                itemBuilder: (context, index) {
                  return DoctorTile(doc: filteredObjects[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

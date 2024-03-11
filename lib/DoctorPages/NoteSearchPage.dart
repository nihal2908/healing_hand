import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/NoteTile.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';

class NoteSearchPage extends StatefulWidget {
  const NoteSearchPage({super.key});

  @override
  State<NoteSearchPage> createState() => _NoteSearchPageState();
}

class _NoteSearchPageState extends State<NoteSearchPage> {
  TextEditingController searchController = TextEditingController();
  List<String> filteredNotes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text('Search Notes', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Patient name or content..',
                floatingLabelAlignment: FloatingLabelAlignment.center,
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderSide: const BorderSide(),
                    borderRadius: BorderRadius.circular(15)
                ),
              ),
              onChanged: (query) {
                setState(() {
                  filteredNotes = DoctorUser.notes.where((obj) =>
                      obj.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                  //sorting the new list in reverse lexigraphical order
                  filteredNotes.sort((a, b) => b.compareTo(a));
                });
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  SizedBox(height: 5,),
              itemCount: filteredNotes.length,
              itemBuilder: (context, index) {
                return NoteTile(note: filteredNotes[index]);
              },
            ),
          ),
        ]
      )
    );
  }
}

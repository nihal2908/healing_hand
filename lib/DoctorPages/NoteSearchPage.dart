import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/EditNotePage.dart';
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
      appBar: AppBar(
        title: Text('Search Notes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Patient name or content..',
                floatingLabelAlignment: FloatingLabelAlignment.center,
                prefixIcon: Icon(Icons.search),
                fillColor: Theme.of(context).cardColor,
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
            SizedBox(height: 10,),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(height: 5,),
                itemCount: filteredNotes.length,
                itemBuilder: (context, index) {
                  List<String> parts = filteredNotes[index].split(': ');
                  return WhiteContainer(
                      child: ListTile(
                        title: Text(parts[0]),
                        subtitle: Text(parts[1], overflow: TextOverflow.ellipsis,),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> EditNotePage(note: filteredNotes[index],)));
                        },
                      )
                  );
                },
              ),
            ),
          ]
        ),
      )
    );
  }
}

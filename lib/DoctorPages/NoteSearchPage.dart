import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/EditNotePage.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/NoteTile.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';

class NoteSearchPage extends StatefulWidget {
  final List<Map<String, dynamic>> notes;
  const NoteSearchPage({super.key, required this.notes});

  @override
  State<NoteSearchPage> createState() => _NoteSearchPageState();
}

class _NoteSearchPageState extends State<NoteSearchPage> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredNotes = [];

  @override
  void initState() {
    super.initState();
    filteredNotes = widget.notes; // Initially, display all notes
  }

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
                    filteredNotes = widget.notes.where((note) {
                      return note.values.any((value) =>
                          value.toString().toLowerCase().contains(query.toLowerCase())
                      );
                    }).toList();
                    // Sorting the filtered list in reverse lexicographical order
                    filteredNotes.sort((a, b) => b.toString().compareTo(a.toString()));
                  });
                },
              ),
              SizedBox(height: 10,),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 5,),
                  itemCount: filteredNotes.length,
                  itemBuilder: (context, index) {
                    final note = filteredNotes[index];
                    final title = note['name'] ?? 'No Name'; // Assuming there's a 'title' key in each note
                    final content = note['note'] ?? 'No Note'; // Assuming there's a 'content' key in each note
                    return WhiteContainer(
                      child: ListTile(
                        title: Text(title),
                        subtitle: Text(content, overflow: TextOverflow.ellipsis,),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditNotePage(note: note)));
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}

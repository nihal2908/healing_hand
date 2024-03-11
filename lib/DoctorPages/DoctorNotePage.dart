import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/EditNotePage.dart';
import 'package:healing_hand/DoctorPages/NoteSearchPage.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/NoteTile.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';

class DoctorNotePage extends StatefulWidget {
  const DoctorNotePage({super.key});

  @override
  State<DoctorNotePage> createState() => _DoctorNotePageState();
}

class _DoctorNotePageState extends State<DoctorNotePage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          children: [
            AppBar(
              title: Text('Patient Notes',),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              actions: [
                IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteSearchPage()));
                    },
                    icon: Icon(Icons.search)
                )
              ],
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index)=>
                SizedBox(height: 10,),
                itemBuilder: (context, index){
                  return NoteTile(
                    note: DoctorUser.notes[index],
                  );
                },
                itemCount: DoctorUser.notes.length,
              ),
            ),
            FloatingActionButton(
              onPressed: (){
                addNote();
              },
              child: Icon(Icons.note_add_rounded),
              tooltip: 'Add Note',
            )
          ]
      ),
    );
  }

  void addNote() {
    TextEditingController noteNameController = TextEditingController();
    showDialog(
        context: context,
        builder: (context)=>
            AlertDialog(
              title: Text('Enter Patient\'s name'),
              content: TextField(
                controller: noteNameController,
              ),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')
                ),
                TextButton(
                    onPressed: (){
                      DoctorUser.notes.add(noteNameController.text+': ');
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context)=> EditNotePage(note: DoctorUser.notes.last)));
                    },
                    child: Text('Add')
                ),
              ],
            )
    );
  }
}

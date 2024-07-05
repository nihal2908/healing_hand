import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/AddNotePage.dart';
import 'package:healing_hand/DoctorPages/EditNotePage.dart';
import 'package:healing_hand/DoctorPages/NoteSearchPage.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/NoteTile.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/firebase/AuthServices.dart';
import 'package:healing_hand/firebase/user_manager.dart';

class DoctorNotePage extends StatefulWidget {
  const DoctorNotePage({super.key});

  @override
  State<DoctorNotePage> createState() => _DoctorNotePageState();
}

class _DoctorNotePageState extends State<DoctorNotePage> {

  final AuthServices auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Patient Notes',),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> const NoteSearchPage(notes: ,)));
              },
              icon: const Icon(Icons.search)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            children: [
              FutureBuilder(
                future: auth.getNotes(doctorId: UserManager.userId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error'),
                    );
                  }
                  final notes = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
                  if(notes.isEmpty) {
                    return Center(
                      child: Text('No', style: TextStyle(color: Colors.white, fontSize: 20),),
                    );
                  }
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        return WhiteContainer(
                          child: ListTile(
                            title: Text(notes[index]['name']),
                            subtitle: Text(
                              notes[index]['note'],
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditNotePage(
                                    note: notes[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNotePage()));
        },
        child: const Icon(Icons.note_add_rounded),
        tooltip: 'Add Note',
      ),
    );
  }
}

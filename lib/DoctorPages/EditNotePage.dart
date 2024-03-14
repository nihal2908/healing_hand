import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';

class EditNotePage extends StatelessWidget {
  final String note;
  EditNotePage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    List<String> parts = note.split(': ');
    TextEditingController editorController = TextEditingController(text: parts[1]);

    return Scaffold(
      appBar: AppBar(
        title: Text(parts[0]),
        actions: [
          IconButton(
              onPressed: (){
                print('Sahre button pressed');
              },
              icon: Icon(Icons.share)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Note:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),),
            SizedBox(height: 16.0),
            Expanded(
              child: TextField(
                controller: editorController,
                maxLines: 20,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                DoctorUser.notes[DoctorUser.notes.indexWhere((element) => element.contains(parts[0]))] = parts[0] +': '+ editorController.text;
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

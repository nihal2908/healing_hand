import 'package:flutter/material.dart';
import 'package:healing_hand/firebase/AuthServices.dart';
import 'package:healing_hand/firebase/user_manager.dart';


class AddNotePage extends StatefulWidget {
  AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {

  final TextEditingController note = TextEditingController();
  final TextEditingController name = TextEditingController();
  final AuthServices auth = AuthServices();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Add new note'),
        actions: [
          TextButton(
              onPressed: () async {
                await auth.addNote(docId: UserManager.userId!, patId: '', note: note.text, name: name.text);
                Navigator.pop(context);
              },
              child: Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Name:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),),
            SizedBox(height: 16.0),
            TextField(
              controller: name,
              maxLines: null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor
              ),
            ),
            SizedBox(height: 16.0),
            Text('Note:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),),
            SizedBox(height: 16.0),
            Expanded(
              child: TextField(
                controller: note,
                maxLines: null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor
                ),
              ),
            ),
            Row(
              children: [
                buildAddNoteMenuButton(
                    title: 'Add Today\'s Date',
                    action: (){
                      final date = DateTime.now();
                      setState(() {
                        note.text = note.text + ' ${date.day}-${date.month}-${date.year} ';
                      });
                    },
                ),
                buildAddNoteMenuButton(
                  title: 'Second',
                  action: (){}
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddNoteMenuButton({required String title, required Function() action}){
    return TextButton(
      onPressed: (){
        action();
      },
      child: Text(title, style: TextStyle(color: Colors.white),),
    );
  }

}
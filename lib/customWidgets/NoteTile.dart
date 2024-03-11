import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/EditNotePage.dart';

class NoteTile extends StatelessWidget {
  final String note;
  NoteTile({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    List<String> parts = note.split(': ');
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListTile(
        title: Text(parts[0]),
        subtitle: Text(parts[1], overflow: TextOverflow.ellipsis,),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> EditNotePage(note: note,)));
        },
      ),
    );
  }
}

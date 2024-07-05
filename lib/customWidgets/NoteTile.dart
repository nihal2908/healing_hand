import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/EditNotePage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';

class NoteTile extends StatelessWidget {
  final Map<String, dynamic> note;
  NoteTile({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return WhiteContainer(
      child: ListTile(
        title: Text(note['name']),
        subtitle: Text(
          note['note'], overflow: TextOverflow.ellipsis,),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                  EditNotePage(
                    note: note,
                  ),
            ),
          );
        },
      ),
    );
  }
}

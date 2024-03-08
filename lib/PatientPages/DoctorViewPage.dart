import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';

class DoctorViewPage extends StatefulWidget {
  final Doctor doc;
  DoctorViewPage({super.key, required this.doc});

  @override
  State<DoctorViewPage> createState() => _DoctorViewPageState();
}

class _DoctorViewPageState extends State<DoctorViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doc.name),
      ),
      body: Center(
        child: Text('Doctor hai ye'),
      ),
    );
  }
}

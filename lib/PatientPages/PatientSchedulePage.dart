import 'package:flutter/material.dart';

class PatientSchedulePage extends StatefulWidget {
  const PatientSchedulePage({super.key});

  @override
  State<PatientSchedulePage> createState() => _PatientSchedulePageState();
}

class _PatientSchedulePageState extends State<PatientSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Schedule Page'),
    );
  }
}

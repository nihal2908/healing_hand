import 'package:flutter/material.dart';

class DoctorLandingPage extends StatefulWidget {
  const DoctorLandingPage({super.key});

  @override
  State<DoctorLandingPage> createState() => _DoctorLandingPageState();
}

class _DoctorLandingPageState extends State<DoctorLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Landing Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(

          ),
        ),
      ),
    );
  }
}

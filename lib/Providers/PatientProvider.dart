import 'package:flutter/material.dart';


class Patient{
  Image profile;
  String name;
  String gender;
  int age;
  String phone;
  String email;
  int height;
  int weight;

  Patient({
    required this.profile,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.height,
    required this.weight,
  });
}

List<Patient> patients = [];

class PatientProvider extends ChangeNotifier{

  void addPatient({
    required Image profile,
    required String name,
    required String gender,
    required int age,
    required String phone,
    required String email,
    required int height,
    required int weight,
  }){
    patients.add(
      Patient(
        profile: profile,
        name: name,
        age: age,
        gender: gender,
        phone: phone,
        email: email,
        height: height,
        weight: weight
      )
    );
    notifyListeners();
  }
}

Patient samplePatient = Patient(
    profile: Image.asset('assets/images/demo_user.jpg'),
    name: 'Nihal Yadav',
    age: 21,
    gender: 'Male',
    phone: '8264525736',
    email: 'jhdgf@gmail.com',
    height: 175, weight: 55
);
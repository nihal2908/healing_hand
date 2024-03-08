import 'package:flutter/material.dart';

class Doctor{
  Image profile;
  String name;
  String gender;
  int age;
  String phone;
  String email;
  double rating = 0.0;

  Doctor({
    required this. profile,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,

  });
}

List<Doctor> doctors = [];

class DoctorProvider extends ChangeNotifier{

  void addDoctor({
    required Image profile,
    required String name,
    required String gender,
    required int age,
    required String phone,
    required String email,
  }){
    doctors.add(
        Doctor(
            profile: profile,
            name: name,
            age: age,
            gender: gender,
            phone: phone,
            email: email
        )
    );
    notifyListeners();
  }

}

Doctor sampleDoctor = Doctor(
    profile: Image.asset('assets/images/doctor.png'),
    name: 'Dr. Anil Ahuja',
    age: 45,
    gender: 'Male',
    phone: '9126452745',
    email: 'doctormail@gmail.com'
);
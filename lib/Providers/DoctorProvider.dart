import 'package:flutter/material.dart';

class Doctor{
  Image profile;//
  String name;//
  String category;
  int age;//
  String gender;//
  String phone;//
  String email;//
  String address;
  String bio;
  double rating = 1.0;
  List<String>? reviews = [];
  // location cordinates
  List<String> notes = ['Patient1 name: Notes', 'Patient1 name: Notes'];

  Doctor({
    required this. profile,
    required this.name,
    required this.category,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.address,
    required this.rating,
    required this.bio,
    this.reviews,
  });
}

Doctor DoctorUser = Doctor(
    profile: Image.asset('assets/images/doctor.png'),
    name: 'Nihal',
    category: '',
    age: 0,
    gender: '',
    phone: '',
    email: '',
    address: '',
    rating: 1,
  bio: '',
  reviews: ['Sample: Sample Text']
);

List<String> DoctorCategories = [
  'Physician',
  'Cardiologist',
  'Dermatologist',
  'Endocrinologist',
  'Gastroenterologist',
  'Hematologist',
  'Nephrologist',
  'Neurologist',
  'Oncologist',
  'Orthopedic Surgeon',
  'Ophthalmologist',
  'Otolaryngologist (ENT)',
  'Pediatrician',
  'Pulmonologist',
  'Rheumatologist',
  'Urologist',
  'Gynecologist',
  'Psychiatrist',
  'Dentist',
  'Emergency Specialist',
];

import 'package:flutter/material.dart';

class Doctor{
  Image profile;
  String name;
  String gender;
  int age;
  String phone;
  String email;
  double rating = 0.0;
  String category;

  Doctor({
    required this. profile,
    required this.name,
    required this.category,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,

  });
}

List<Doctor> doctors = [sampleDoctor, doctor1, doctor2, doctor3, doctor4, doctor5, doctor6, doctor7, doctor8, doctor9, doctor10];

class DoctorProvider extends ChangeNotifier{

  void addDoctor({
    required Image profile,
    required String name,
    required String category,
    required String gender,
    required int age,
    required String phone,
    required String email,
  }){
    doctors.add(
        Doctor(
            profile: profile,
            name: name,
            category: category,
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
    category: 'Dentist',
    age: 45,
    gender: 'Male',
    phone: '9126452745',
    email: 'doctormail@gmail.com'
);

Doctor doctor1 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Rajesh Patel',
  category: 'Physician',
  age: 48,
  gender: 'Male',
  phone: '8765432109',
  email: 'dr.rajesh.patel@example.com',
);

Doctor doctor2 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Ayesha Khan',
  category: 'Dentist',
  age: 35,
  gender: 'Female',
  phone: '7654321098',
  email: 'dr.ayesha.khan@example.com',
);

Doctor doctor3 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Vikram Gupta',
  category: 'Neurologist',
  age: 40,
  gender: 'Male',
  phone: '6543210987',
  email: 'dr.vikram.gupta@example.com',
);

Doctor doctor4 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Sneha Desai',
  category: 'Physician',
  age: 37,
  gender: 'Female',
  phone: '5432109876',
  email: 'dr.sneha.desai@example.com',
);

Doctor doctor5 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Sanjay Singh',
  category: 'Dentist',
  age: 44,
  gender: 'Male',
  phone: '4321098765',
  email: 'dr.sanjay.singh@example.com',
);

Doctor doctor6 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Preeti Sharma',
  category: 'Physician',
  age: 38,
  gender: 'Female',
  phone: '3210987654',
  email: 'dr.preeti.sharma@example.com',
);

Doctor doctor7 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Rohit Verma',
  category: 'Neurologist',
  age: 41,
  gender: 'Male',
  phone: '2109876543',
  email: 'dr.rohit.verma@example.com',
);

Doctor doctor8 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Nisha Patel',
  category: 'Neurologist',
  age: 36,
  gender: 'Female',
  phone: '1098765432',
  email: 'dr.nisha.patel@example.com',
);

Doctor doctor9 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Anuj Kapoor',
  category: 'Physician',
  age: 39,
  gender: 'Male',
  phone: '9876543210',
  email: 'dr.anuj.kapoor@example.com',
);

Doctor doctor10 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Meera Singh',
  category: 'Neurologist',
  age: 43,
  gender: 'Female',
  phone: '8765432109',
  email: 'dr.meera.singh@example.com',
);

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
    this.reviews,
  });
}

List<Doctor> doctors = [sampleDoctor,doctor10,doctor10,doctor10, doctor1, doctor2, doctor3, doctor4, doctor5, doctor6, doctor7, doctor8, doctor9, doctor10];

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

class DoctorProvider extends ChangeNotifier{

  void addDoctor({
    required String address,
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
            email: email,
            address: address,
            rating: 1.0
        )
    );
    notifyListeners();
  }

  void createUser({
    //required Image profile,
    required String name,
    required String category,
    required String gender,
    required int age,
    required String phone,
    required String email,
    required String address,
  }){
    DoctorUser.name = name;
    DoctorUser.gender = gender;
    DoctorUser.age = age;
    DoctorUser.address = address;
    DoctorUser.category = category;
    DoctorUser.phone = phone;
    DoctorUser.email = email;
    notifyListeners();
  }

  void addReview(String review, Doctor doc){
    doc.reviews?.add(review);
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
    email: 'doctormail@gmail.com',
  address: 'Address',
  rating: 4.8,
  reviews: ['Patient1: Excellent service!', 'Patient2: Very knowledgeable.', 'Patient7: Compassionate and skilled.', 'Patient8: Quick diagnosis.'],
);

Doctor doctor1 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Rajesh Patel',
  category: 'Physician',
  age: 48,
  gender: 'Male',
  phone: '8765432109',
  email: 'dr.rajesh.patel@example.com',
  rating: 4.5,
  reviews: ['Patient3: Friendly and caring.'],
  address: 'Address',
);

Doctor doctor2 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Ayesha Khan',
  category: 'Dentist',
  age: 35,
  gender: 'Female',
  phone: '7654321098',
  email: 'dr.ayesha.khan@example.com',
  rating: 4.2,
  address: 'Address',
  reviews: ['Patient5: Great doctor!', 'Patient6: Good communication.'],
);

Doctor doctor3 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Vikram Gupta',
  category: 'Neurologist',
  age: 40,
  gender: 'Male',
  phone: '6543210987',
  email: 'dr.vikram.gupta@example.com',
  rating: 4.9,
  address: 'Address',
  reviews: ['Patient7: Compassionate and skilled.', 'Patient8: Quick diagnosis.'],
);

Doctor doctor4 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Sneha Desai',
  category: 'Physician',
  age: 37,
  gender: 'Female',
  phone: '5432109876',
  email: 'dr.sneha.desai@example.com',
  rating: 4.6,
  address: 'Address',
  reviews: ['Patient9: Excellent care!', 'Patient10: Knowledgeable and friendly.'],
);

Doctor doctor5 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Sanjay Singh',
  category: 'Dentist',
  age: 44,
  gender: 'Male',
  phone: '4321098765',
  email: 'dr.sanjay.singh@example.com',
  rating: 4.2,
  address: 'Address',
  reviews: ['Patient11: Highly recommended.', 'Patient12: Listened attentively.'],
);

Doctor doctor6 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Preeti Sharma',
  category: 'Physician',
  age: 38,
  gender: 'Female',
  phone: '3210987654',
  email: 'dr.preeti.sharma@example.com',
  rating: 4.4,
  address: 'Address',
  reviews: ['Patient13: Courteous and professional.', 'Patient14: Thorough examination.'],
);

Doctor doctor7 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Rohit Verma',
  category: 'Neurologist',
  age: 41,
  gender: 'Male',
  phone: '2109876543',
  email: 'dr.rohit.verma@example.com',
  rating: 4.1,
  address: 'Address',
  reviews: ['Patient15: Great experience!', 'Patient16: Kind and patient.'],
);

Doctor doctor8 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Nisha Patel',
  category: 'Neurologist',
  age: 36,
  gender: 'Female',
  phone: '1098765432',
  email: 'dr.nisha.patel@example.com',
  rating: 4.3,
  address: 'Address',
  reviews: ['Patient17: Helpful advice.', 'Patient18: Efficient and caring.'],
);

Doctor doctor9 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Anuj Kapoor',
  category: 'Physician',
  age: 39,
  gender: 'Male',
  phone: '9876543210',
  email: 'dr.anuj.kapoor@example.com',
  rating: 4.9,
  address: 'Address',
  reviews: ['Patient19: Exceptional doctor.', 'Patient20: Knowledgeable and friendly.'],
);

Doctor doctor10 = Doctor(
  profile: Image.asset('assets/images/doctor.png'),
  name: 'Dr. Meera Singh',
  category: 'Neurologist',
  age: 43,
  gender: 'Female',
  phone: '8765432109',
  email: 'dr.meera.singh@example.com',
  rating: 4.9,
  address: 'Address',
  reviews: ['Patient19: Exceptional doctor.', 'Patient20: Knowledgeable and friendly.'],
);

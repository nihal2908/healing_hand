import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/DoctorLandingPage.dart';
import 'package:healing_hand/DoctorPages/DoctorSignupPage.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/CustomTextFormField.dart';
import 'package:healing_hand/customWidgets/circularIndicator.dart';
import 'package:healing_hand/firebase/AuthServices.dart';


class DoctorDetailPage extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  const DoctorDetailPage({super.key, required this.name, required this.email, required this.password});

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {

  late final TextEditingController ageController;
  late final TextEditingController phoneController;
  late final TextEditingController bioController;
  late final TextEditingController addressController;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  String selectedGender = 'Select';
  String selectedCategory = 'Select';
  final detailKey = GlobalKey<FormState>();


  @override
  void initState() {
    ageController = TextEditingController();
    phoneController = TextEditingController();
    bioController = TextEditingController();
    addressController = TextEditingController();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    passwordController = TextEditingController(text: widget.password);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text('Doctor signup'),
        backgroundColor: Colors.grey.shade200,
        foregroundColor: Colors.black,
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Lets create your profile', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30, color: Colors.white),),
              const SizedBox(height: 15,),
              Container(
                  child: Form(
                    key: detailKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        CustomTextFormField(
                          controller: nameController,
                          labelText: 'Name',
                          icon: Icons.person,
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedGender,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            icon: const Icon(Icons.people),
                            floatingLabelAlignment: FloatingLabelAlignment.center,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          items: ['Select', 'Male', 'Female', 'Other']
                              .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          )).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty || value == 'Select') {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: ageController,
                          labelText: 'Age',
                          icon: Icons.calendar_today,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: phoneController,
                          labelText: 'Phone Number',
                          icon: Icons.phone,
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: emailController,
                          labelText: 'Email',
                          icon: Icons.email,
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            } else if (!value.contains('@')) {
                              return 'Invalid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: bioController,
                          labelText: 'Qualification',
                          icon: Icons.medical_services,
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: addressController,
                          labelText: 'Address',
                          icon: Icons.home,
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          menuMaxHeight: 300,
                          value: null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'Specialisation',
                            icon: const Icon(Icons.star),
                            floatingLabelAlignment: FloatingLabelAlignment.center,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          items: DoctorCategories
                              .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          )).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty || value == 'Select') {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 8,
                          ),
                          onPressed: ()async{
                            if(detailKey.currentState!.validate()){
                              signin();
                            }
                          },
                          child: const Text('Save')
                        )
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signin()async{
    final auth = AuthServices();
    showCircularProgressIndicator(context);
    try{
      await auth.doctorSignin(
          gender: selectedGender,
          age: int.parse(ageController.text),
          category: selectedCategory,
          bio: bioController.text,
          reviews: [],
          address: addressController.text,
          rating: 1.0,
          email: emailController.text,
          name: nameController.text,
          password: passwordController.text,
          phone: phoneController.text
      );
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorLandingPage()));
    }
    catch (e) {
      print(e.toString());
      Navigator.pop(context);
    }
  }


}

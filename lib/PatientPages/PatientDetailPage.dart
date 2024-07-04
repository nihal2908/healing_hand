import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientLandingPage.dart';
import 'package:healing_hand/PatientPages/PatientSignupPage.dart';
import 'package:healing_hand/customWidgets/CustomTextFormField.dart';
import 'package:healing_hand/customWidgets/circularIndicator.dart';
import 'package:healing_hand/firebase/AuthServices.dart';


class PatientDetailPage extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  const PatientDetailPage({super.key, required this.name, required this.email, required this.password});

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {

  late final TextEditingController ageController;
  late final TextEditingController phoneController;
  late final TextEditingController heightController;
  late final TextEditingController weightController;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final detailKey = GlobalKey<FormState>();

  String selectedGender = 'Select';

  @override
  void initState() {
    ageController = TextEditingController();
    phoneController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    passwordController = TextEditingController(text: widget.password);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    heightController.dispose();
    weightController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: const Text('Individual signup'),
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
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: detailKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10,),
                        CustomTextFormField(
                          controller: nameController,
                          labelText: 'Name',
                          icon: Icons.person,
                          readOnly: true,
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: ageController,
                          labelText: 'Age',
                          icon: Icons.calendar_today,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: phoneController,
                          labelText: 'Phone Number',
                          icon: Icons.phone,
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: heightController,
                          labelText: 'Height',
                          icon: Icons.height,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: weightController,
                          labelText: 'Weight',
                          icon: Icons.line_weight,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 8,
                          ),
                          onPressed: ()async {
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
    final AuthServices auth = AuthServices();
    showCircularProgressIndicator(context);
    try{
      await auth.patientSignin(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text,
          age: int.parse(ageController.text),
          gender: selectedGender,
          phone: phoneController.text,
          height: double.parse(heightController.text),
          weight: double.parse(weightController.text)
      );
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const PatientLandingPage()), (route)=>false);
    }
    catch (e) {
      print(e.toString());
      Navigator.pop(context);
    }
  }
}

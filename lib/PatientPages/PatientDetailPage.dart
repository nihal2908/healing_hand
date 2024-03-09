import 'package:flutter/material.dart';
import 'package:healing_hand/PatientPages/PatientLandingPage.dart';
import 'package:healing_hand/PatientPages/PatientSignupPage.dart';
import 'package:healing_hand/Providers/PatientProvider.dart';
import 'package:healing_hand/customWidgets/CustomTextFormField.dart';
import 'package:provider/provider.dart';


final detailKey = GlobalKey<FormState>();

class PatientDetailPage extends StatefulWidget {
  const PatientDetailPage({super.key});

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

final TextEditingController ageController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController heightController = TextEditingController();
final TextEditingController weightController = TextEditingController();

String selectedGender = 'Select';

class _PatientDetailPageState extends State<PatientDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Individual signup'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Lets create your profile', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),),
                const SizedBox(height: 15,),
                Container(
                  padding: const EdgeInsets.all(10),
                  //height: 480,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.deepPurple,
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.deepPurple,
                            blurRadius: 5
                        )
                      ]
                  ),
                  child: Form(
                    key: detailKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: emailController,
                          labelText: 'Email',
                          icon: Icons.email,
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
                          controller: heightController,
                          labelText: 'Height',
                          icon: Icons.height,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: weightController,
                          labelText: 'Weight',
                          icon: Icons.line_weight,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10),
                        Consumer<PatientProvider>(
                            builder: (context, PatientModel, child){
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 8,
                                  ),
                                  onPressed: (){
                                    if(detailKey.currentState!.validate()){
                                      PatientModel.createUser(
                                          name: nameController.text,
                                          gender: selectedGender,
                                          age: int.parse(ageController.text),
                                          phone: phoneController.text,
                                          email: emailController.text,
                                          height: int.parse(heightController.text),
                                          weight: int.parse(weightController.text)
                                      );
                                    }
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PatientLandingPage()));
                                  },
                                  child: const Text('Save')
                              );
                            }
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
}
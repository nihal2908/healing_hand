import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/DoctorLandingPage.dart';
import 'package:healing_hand/DoctorPages/DoctorSignupPage.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/CustomTextFormField.dart';
import 'package:provider/provider.dart';


final detailKey = GlobalKey<FormState>();

class DoctorDetailPage extends StatefulWidget {
  const DoctorDetailPage({super.key});

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

final TextEditingController ageController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController addressController = TextEditingController();


String selectedGender = 'Select';
String selectedCategory = 'Select';

class _DoctorDetailPageState extends State<DoctorDetailPage> {
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
                  padding: const EdgeInsets.all(10),
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
                        DropdownButtonFormField<String>(
                          menuMaxHeight: 300,
                          value: null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'Specialisation',
                            icon: const Icon(Icons.people),
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
                        Consumer<DoctorProvider>(
                            builder: (context, DoctorModel, child){
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
                                      DoctorModel.createUser(
                                          name: nameController.text,
                                          gender: selectedGender,
                                          age: int.parse(ageController.text),
                                          category: selectedCategory,
                                          phone: phoneController.text,
                                          email: emailController.text,
                                          address: addressController.text,
                                      );
                                      //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> DoctorLandingPage()), (route) => false);
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DoctorLandingPage()));
                                    }
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

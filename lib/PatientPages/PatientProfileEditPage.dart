import 'package:flutter/material.dart';
import 'package:healing_hand/customWidgets/CustomTextFormField.dart';
import 'package:healing_hand/firebase/AuthServices.dart';

final editorKey = GlobalKey<FormState>();
final AuthServices auth = AuthServices();

class PatientProfileEditPage extends StatelessWidget {

  final String name;
  final String phone;
  final String gender;
  final int age;
  final double height;
  final double weight;

  const PatientProfileEditPage({
    super.key,
    required this.name,
    required this.phone,
    required this.height,
    required this.weight,
    required this.gender,
    required this.age
  });

  @override
  Widget build(BuildContext context) {
    String editedGender = gender;
    final TextEditingController nameController = TextEditingController(text: name);
    final TextEditingController phoneController = TextEditingController(text: phone);
    final TextEditingController ageController = TextEditingController(text: age.toString());
    final TextEditingController heightController = TextEditingController(text: height.toString());
    final TextEditingController weightController = TextEditingController(text: weight.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Your Profile'),
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
              const SizedBox(height: 15,),
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
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
                    key: editorKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10,),
                        CustomTextFormField(
                          controller: nameController,
                          labelText: 'Name',
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 10),
                        StatefulBuilder(
                          builder: (context, refresh) {
                            return DropdownButtonFormField<String>(
                              value: editedGender,
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
                                refresh(() {
                                  editedGender = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty || value == 'Select') {
                                  return 'Required';
                                }
                                return null;
                              },
                            );
                          }
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
                          labelText: 'Phone',
                          icon: Icons.phone,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            } else if (value.toString().length != 10) {
                              return 'Number must be 10 digit';
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
                          onPressed: () async{
                            if(editorKey.currentState!.validate()){
                              auth.editPatRecord(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  age: int.parse(ageController.text),
                                  gender: editedGender,
                                  height: double.parse(heightController.text),
                                  weight: double.parse(weightController.text)
                              ).then((value) => Navigator.pop(context));
                            }
                          },
                          child: const Text('Save')
                        ),
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

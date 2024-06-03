import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/CustomTextFormField.dart';
import 'package:healing_hand/firebase/AuthServices.dart';

final editorKey = GlobalKey<FormState>();
final AuthServices auth = AuthServices();

class DoctorProfileEditPage extends StatelessWidget {
  final String name;
  final String phone;
  final String gender;
  final int age;
  final String bio;
  final String address;
  final String category;

  const DoctorProfileEditPage({
    super.key,
    required this.name,
    required this.phone,
    required this.bio,
    required this.address,
    required this.gender,
    required this.age,
    required this.category
  });

  @override
  Widget build(BuildContext context) {
    String editedGender = gender;
    String selectedCategory = category;
    final TextEditingController nameController = TextEditingController(text: name);
    final TextEditingController phoneController = TextEditingController(text: phone);
    final TextEditingController ageController = TextEditingController(text: age.toString());
    final TextEditingController bioController = TextEditingController(text: bio);
    final TextEditingController addressController = TextEditingController(text: address);

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
                          labelText: 'Phone Number',
                          icon: Icons.phone,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: bioController,
                          labelText: 'Bio',
                          icon: Icons.school,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          controller: addressController,
                          labelText: 'Address',
                          icon: Icons.home,
                        ),
                        const SizedBox(height: 10),
                        StatefulBuilder(
                          builder: (context, refresh) {
                            return DropdownButtonFormField<String>(
                              menuMaxHeight: 300,
                              value: selectedCategory,
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
                                refresh(() {
                                  selectedCategory = value!;
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
                              auth.editDocRecord(name: nameController.text,
                                phone: phoneController.text,
                                bio: bioController.text,
                                address: addressController.text,
                                category: selectedCategory,
                                age: int.parse(ageController.text),
                                gender: editedGender
                              );
                            }
                            Navigator.pop(context);
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

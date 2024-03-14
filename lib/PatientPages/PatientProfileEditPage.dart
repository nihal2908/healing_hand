import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/PatientProvider.dart';
import 'package:healing_hand/apiconnection/doctorhttp.dart';
import 'package:healing_hand/customWidgets/CustomTextFormField.dart';
import 'package:provider/provider.dart';

String? password;

final editorKey = GlobalKey<FormState>();
final TextEditingController nameController = TextEditingController(text: PatientUser.name);
final TextEditingController phoneController = TextEditingController(text: PatientUser.phone);
final TextEditingController ageController = TextEditingController(text: PatientUser.age.toString());
final TextEditingController emailController = TextEditingController(text: PatientUser.email);
final TextEditingController heightController = TextEditingController(text: PatientUser.height.toString());
final TextEditingController weightController = TextEditingController(text: PatientUser.weight.toString());
String? editedGender;

class PatientProfileEditPage extends StatefulWidget {
  @override
  State<PatientProfileEditPage> createState() => _PatientProfileEditPageState();
}

class _PatientProfileEditPageState extends State<PatientProfileEditPage> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          //backgroundColor: Colors.deepPurple,
          appBar: AppBar(
            title: Text('Edit Your Profile'),
            //backgroundColor: Colors.grey.shade200,
            //foregroundColor: Colors.black,
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
                      //height: 480,
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
                            SizedBox(height: 10,),
                            CustomTextFormField(
                              controller: nameController,
                              labelText: 'Name',
                              icon: Icons.person,
                            ),
                            SizedBox(height: 10),
                            DropdownButtonFormField<String>(
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
                                setState(() {
                                  editedGender = value!;
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
                                      onPressed: () async{
                                        if(editorKey.currentState!.validate()){
                                          PatientModel.createUser(
                                              name: nameController.text,
                                              gender: editedGender!,
                                              age: int.parse(ageController.text),
                                              phone: phoneController.text,
                                              email: emailController.text,
                                              height: int.parse(heightController.text),
                                              weight: int.parse(weightController.text)
                                          );
                                          print(password);
                                          postApihttp http=new postApihttp();
                                          await http.saveData2(emailController.text.toString(), password!,nameController.text.toString(),
                                           heightController.text.toString(), weightController.text.toString(),editedGender.toString(), ageController.text.toString());
                                        }
                                        Navigator.pop(context);
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

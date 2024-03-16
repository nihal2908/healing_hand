import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/DoctorLandingPage.dart';
import 'package:healing_hand/DoctorPages/DoctorSignupPage.dart';
import 'package:healing_hand/PatientPages/PatientDetailPage.dart';
import 'package:healing_hand/PatientPages/PatientSignupPage.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/CustomTextFormField.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/firebase/AuthServices.dart';
import 'package:healing_hand/modelclass/doctor.dart';
import 'package:provider/provider.dart';
import 'package:healing_hand/DoctorPages/DoctorSignupPage.dart' as pp;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final detailKey = GlobalKey<FormState>();

class DoctorDetailPage extends StatefulWidget {
  const DoctorDetailPage({super.key});

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

final TextEditingController ageController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController addressController = TextEditingController();
TextEditingController bioController = TextEditingController();


String selectedGender = 'Select';
String selectedCategory = 'Select';

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text('Doctor signup'),
        //backgroundColor: Colors.grey.shade200,
        //foregroundColor: Colors.black,
        centerTitle: true,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(15)
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Lets create your profile', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30, color: Colors.white),),
              const SizedBox(height: 15,),
              WhiteContainer(
                  child: Form(
                    key: detailKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        CustomTextFormField(
                          controller: pp.nameController,
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
                          controller: pp.phoneController,
                          labelText: 'Email',
                          icon: Icons.email,
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: bioController,
                          labelText: 'Qualification',
                          icon: Icons.person,
                        ),
                        SizedBox(height: 10),
                        CustomTextFormField(
                          controller: addressController,
                          labelText: 'Address',
                          icon: Icons.person,
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
                                  onPressed: () async {
                                    signin();
                                    if(detailKey.currentState!.validate()){
                                      DoctorModel.createUser(
                                        name: pp.nameController.text,
                                        gender: selectedGender,
                                        age: int.parse(ageController.text),
                                        category: selectedCategory,
                                        phone: pp.phoneController.text,
                                        email: pp.phoneController.text,
                                        address: addressController.text,
                                        bio: bioController.text,
                                      );

                                      SaveRecord(context);
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString('FIRST_PAGE', 'doctor');
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
  SaveRecord(context) async
  {
    print(pp.nameController.text.toString());
    User user= new User(pp.nameController.text.toString(),pp.phoneController.text,pp.passwordController.text.toString(),pp.phoneController.text.toString(),
        selectedCategory,addressController.text.toString(),ageController.text.toString(),selectedGender.toString());
    try{
      var res=await http.post(Uri.parse(
          "http://handycraf.000webhostapp.com/helping_hand/signup1.php"
      ),body:user.toJson());
      if(res.statusCode==200)
      {
        //var resBody1=jsonDecode(res.body);
        String resBody=res.body;
        print(resBody);
        print(resBody);
        if((resBody)=="false")
        {
          Future.delayed(Duration.zero,()=>showDialog(context: context, builder: ((context) => AlertDialog(
              title:Text("Record Saved "),
              content:ElevatedButton(child:Text("O.K"),onPressed: () {Navigator.pop(context);},)))));
        }
        else{
          AlertDialog(
            content: Text("Record already exist"),
            actions: [ElevatedButton(onPressed: () {Navigator.pop(context);}, child: Text("O.K"))],

          );
        }
      }
      else{
        AlertDialog(
          content: Text("Record Saved now go to login page"),
          actions: [ElevatedButton(onPressed: () {Navigator.pop(context);}, child: Text("O.K"))],

        );
      }
    }
    catch(e){
      print(e);
    }
  }

  void signin()async{
    final auth = AuthServices();
    try{
      await auth.doctorSignin(pp.phoneController.text, pp.passwordController.text, pp.nameController.text, []);
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorLandingPage()));
    }
    catch (e) {
      print(e.toString());
    }
  }

}

import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/DoctorSignupPage.dart';
import 'package:healing_hand/PatientPages/PatientDetailPage.dart';
import 'package:healing_hand/PatientPages/PatientLandingPage.dart';
import 'package:healing_hand/customWidgets/circularIndicator.dart';
import 'package:healing_hand/firebase/AuthServices.dart';
import 'package:healing_hand/services/validator_functions.dart';

final formKey = GlobalKey<FormState>();

class PatientSignupPage extends StatefulWidget {
  const PatientSignupPage({super.key});

  @override
  State<PatientSignupPage> createState() => _PatientSignupPageState();
}

class _PatientSignupPageState extends State<PatientSignupPage> {
  bool isObscured = true;
  bool isLogin = false;

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        foregroundColor: Colors.black,
        title: const Text('Individual signup'),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15), top: Radius.circular(15))
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Hey Champ!', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30, color: Colors.white),),
                const SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isLogin? 'Log-in':'Sign-up',
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    //SizedBox(height: 10,),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(!isLogin) TextFormField(
                            controller: nameController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              icon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              floatingLabelAlignment: FloatingLabelAlignment.center,
                            ),
                            validator: (value){
                              if(value==null || value.isEmpty || value.trim().isEmpty){
                                return 'Required field';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(
                            controller: emailController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              icon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              floatingLabelAlignment: FloatingLabelAlignment.center,
                            ),
                            validator: emailValidator,
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(
                            controller: passwordController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              icon: const Icon(Icons.key),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              floatingLabelAlignment: FloatingLabelAlignment.center,
                              suffixIcon: IconButton(
                                tooltip: isObscured ? 'Show password' : 'Hide password',
                                icon: isObscured ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                                onPressed: (){
                                  setState(() {
                                    isObscured = !isObscured;
                                  });
                                },
                              ),
                            ),
                            validator: passwordValidator,
                            obscureText: isObscured,
                          ),
                        ],
                      ),
                    ),
                    //SizedBox(height: 15,),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if(formKey.currentState!.validate()){
                              if(isLogin) {
                                tryLogin();
                              }
                              else {
                                Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) =>
                                      PatientDetailPage(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                  ),
                                );
                              }
                            }
                          },
                          child: Card(
                            child: Center(
                              child: !isLogin? const Text('Sign-Up') : const Text('Login'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextButton(
                            onPressed: (){
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: !isLogin?
                            const Text(
                              'Already have account? Login',
                              style: TextStyle(color: Colors.white),
                            ) :
                            const Text(
                              'New to Helping Hand? SignUp',
                              style: TextStyle(color: Colors.white),
                            )
                        ),
                      ],
                    )
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }

  void tryLogin() async {
    //get instance
    try{
      final AuthServices auth = AuthServices();
      showCircularProgressIndicator(context);
      await auth.patientLogin(emailController.text, passwordController.text);
      //try login
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const PatientLandingPage()), (route)=>false);
    }
    //catch error
    catch (e) {
      print(e.toString());
      Navigator.pop(context);
    }
  }
}
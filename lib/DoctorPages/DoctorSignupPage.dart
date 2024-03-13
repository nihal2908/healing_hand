import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/DoctorDetailPage.dart';
import 'package:healing_hand/DoctorPages/DoctorLandingPage.dart';
import 'package:healing_hand/apiconnection/doctorhttp.dart';
import 'package:healing_hand/pages/HomePage.dart';

final formKey = GlobalKey<FormState>();

class DoctorSignupPage extends StatefulWidget {
  const DoctorSignupPage({super.key});

  @override
  State<DoctorSignupPage> createState() => _DoctorSignupPageState();
}

TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _DoctorSignupPageState extends State<DoctorSignupPage> {
  bool isObscured = true;
  bool isLogin = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        foregroundColor: Colors.black,
        title: const Text('Doctor signup'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15), top: Radius.circular(15))
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Hello Doctor', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),),
              const SizedBox(height: 30,),
              Container(
                padding: const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
                //height: 490,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.deepPurple,
                      blurRadius: 5
                    )
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isLogin? 'Log-in':'Sign-up',
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(!isLogin) TextFormField(
                            controller: nameController,
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
                              if(value == null || value.isEmpty){
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              labelText: 'Phone number',
                              icon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              floatingLabelAlignment: FloatingLabelAlignment.center,
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(
                            controller: passwordController,
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
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Required';
                              }
                              return null;
                            },
                            obscureText: isObscured,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 8,
                          ),
                          onPressed: ()async {
                            if(formKey.currentState!.validate()){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Successful\n'
                                              '${!isLogin? nameController.text:''}'
                                              '${phoneController.text}\n'
                                              '${passwordController.text}'
                                      )
                                  )
                              );
                              if(isLogin){
                                postApihttp http = postApihttp();
                            await http.saveData(phoneController.text.toString(),
                                passwordController.text.toString());
                            int j = await http.givedata(0);
                              
                              if(j==0)
                              {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => DoctorLandingPage())
                                  );
                                  print('Add here login verification');
                                }
                                else
                                {
                                  showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                      title: Text(
                                          "Invalid email or password entered"),
                                      content: ElevatedButton(
                                        child: Text("O.K"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ))));
                                }
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(builder: (context) => DoctorLandingPage())
                                // );
                                print('Add here login verification');
                              }
                              else
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorDetailPage()));
                              //for checking, currently using push,, afterwards it should be pushReplacement or pushandrmoveuntil
                            }
                          },
                          child: !isLogin? const Text('Sign-Up') : const Text('Login')
                        ),
                        const SizedBox(height: 10,),
                        TextButton(
                            onPressed: (){
                              setState(() {
                                isLogin = !isLogin;
                              });
                              
                            },
                            child: !isLogin? const Text('Already have account? Login') : const Text('New to Helping Hand? SignUp')
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}

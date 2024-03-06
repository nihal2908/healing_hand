import 'package:flutter/material.dart';

final formKey = GlobalKey<FormState>();

class DoctorSignupPage extends StatefulWidget {
  const DoctorSignupPage({super.key});

  @override
  State<DoctorSignupPage> createState() => _DoctorSignupPageState();
}

class _DoctorSignupPageState extends State<DoctorSignupPage> {
  bool isObscured = true;
  bool isLogin = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor signup'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
            child: Container(
              padding: EdgeInsets.all(10),
              height: 400,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.deepPurple,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple,
                    blurRadius: 5
                  )
                ]
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin? 'Log-in':'Sign-up',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 20),
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
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: (){
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
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}

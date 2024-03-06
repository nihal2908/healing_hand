import 'package:flutter/material.dart';

final formKey = GlobalKey<FormState>();

class PatientSignupPage extends StatefulWidget {
  const PatientSignupPage({super.key});

  @override
  State<PatientSignupPage> createState() => _PatientSignupPageState();
}

class _PatientSignupPageState extends State<PatientSignupPage> {
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
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Hey Champ!', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),),
              const SizedBox(height: 30,),
              Container(
                padding: const EdgeInsets.all(10),
                height: 450,
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

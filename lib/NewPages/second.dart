import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/firebase/AuthServices.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
AuthServices auth = AuthServices();
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Login karo'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: emailController,
            ),
            TextField(
              controller: passwordController,
            ),
            ElevatedButton(onPressed: () async {
              showDialog(context: context, builder: (context){
                return Center(child: CircularProgressIndicator());
              });
              await auth.patientLogin(emailController.text, passwordController.text);
              Navigator.pop(context);
              print('Details send successful');
            }, child: Text('Login')),
            TextButton(onPressed: (){
              forgotPassword(context);
            }, child: Text('Forgot Passord'))
          ],
        ),
      ),
    );
  }

  void forgotPassword(BuildContext context){
    showDialog(
        context: context,
        builder: (context){
          TextEditingController forgotController = TextEditingController();
          String message = 'Email Sent';
          return AlertDialog(
            title: Text('Forgot Password'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Enter your email, a password reset link will be sent to your email'),
                TextField(
                  controller: forgotController,
                ),
                ElevatedButton(onPressed: () async {
                  try {
                    await firebaseAuth.sendPasswordResetEmail(
                        email: forgotController.text.trim());
                  }
                  catch (e){
                    message = e.toString();
                  }
                  print(message);
                }, child: Text('Confirm'))
              ],
            ),
          );
        }
    );
  }
}

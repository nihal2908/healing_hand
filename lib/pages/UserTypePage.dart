import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/DoctorSignupPage.dart';
import 'package:healing_hand/PatientPages/PatientSignupPage.dart';


class UserTypePage extends StatelessWidget {
  const UserTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(),
            const Text('Continue as a?', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DoctorSignupPage()));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/doctor.png',
                    height: 200,
                    width: 200,
                  ),
                  const Text(
                    'Doctor',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PatientSignupPage()));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/meditation.png',
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(height: 10,),
                  const Text(
                    'Health conscious\nindividual',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}

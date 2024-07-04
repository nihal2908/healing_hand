import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/ThemeProvider.dart';
import 'package:healing_hand/firebase/user_manager.dart';
import 'package:healing_hand/APIs_and_keys/firebase_options.dart';
import 'package:healing_hand/pages/SplashScreen.dart';
import 'package:healing_hand/pages/UserTypePage.dart';
import 'package:provider/provider.dart';

String firstPage = 'onbording'; // when skips onboarding make it
// userselection, when sighed in make it patient or doctor
Widget page = Container(child: Text('error'),);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider())
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeModel, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light().copyWith(
                primaryColor: Colors.deepPurple, // Background color for Scaffold
                scaffoldBackgroundColor: Colors.deepPurple,
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.white), // White foreground color for AppBar icons
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent,
                ),
                cardColor: Colors.grey.shade200
            ),
            darkTheme: ThemeData.dark().copyWith(
                primaryColor: Colors.black, // Background color for Scaffold in dark mode
                scaffoldBackgroundColor: Colors.black,
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.white), // White foreground color for AppBar icons in dark mode
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                ),
                cardColor: Colors.grey.shade700,
              //brightness: Brightness.dark
            ),
            themeMode: ThemeModel.thememode,
            //home: isNewUser? const OnBoardingPage() : const UserTypePage(),
            //home: const OnBoardingPage(),
            //home: const PatientSignupPage(),
            //home: PatientLandingPage(),
            // home: UserTypePage(),
            //home: DoctorLandingPage(),
            //home: page,
            //home: DoctorDetailPage(),
            home: SplashScreen(),
          );
        }
      )
    );
  }
}


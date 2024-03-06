import 'package:flutter/material.dart';
import 'package:healing_hand/main.dart';
import 'package:healing_hand/pages/HomePage.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final List<PageViewModel> onBoardingPages = [
    CustomPageViewModal(
      'Need quick response? Here you go!',
      'Instantly connect with your doctor through '
          'secure chat. Your health, your conversations, '
          'all in one place.',
      Image.asset('assets/images/telemedicine.png')
    ),
    CustomPageViewModal(
      'Emergency? We got you!',
      'Emergency assistance at your fingertips. '
          'Quickly call the nearest ambulance when every second matters.',
      Image.asset('assets/images/medical-app.png'),
    ),
    CustomPageViewModal(
      'Access Lab Results and Tests',
      'Stay informed with easy access to lab results. '
        'Your health data, on demand, directly from the app.',
      Image.asset('assets/images/medical-result.png'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Helping Hand',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: IntroductionScreen(
        pages: onBoardingPages,
        dotsDecorator: DotsDecorator(
          size: const Size(10,10),
          color: Colors.grey.shade400,
          activeColor: Colors.deepPurple,
          activeSize: const Size(10,10)
        ),
        done: const Text('Get Started'),
        next: const Text('Next'),
        skip: const Text('Skip'),
        showDoneButton: true,
        showSkipButton: true,
        showNextButton: true,
        showBottomPart: true,
        onDone: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage()));
        },
      ),
    );
  }
}

PageViewModel CustomPageViewModal(String title, body, Image image){
  return PageViewModel(
    title: title,
    body: body,
    image: image,
    decoration: PageDecoration(
      titleTextStyle: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic
      ),
      imageFlex: 1,
      footerFlex: 0,
      bodyAlignment: Alignment.bottomCenter,
      imagePadding: const EdgeInsets.only(top: 20, bottom: 20),
      boxDecoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      bodyPadding: const EdgeInsets.all(10),
      pageMargin: const EdgeInsets.all(15),
    )
  );
}
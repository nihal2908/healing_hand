import 'package:flutter/material.dart';
import 'package:healing_hand/customWidgets/styles.dart';
import 'package:url_launcher/url_launcher.dart';

TextStyle heading = TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);

class HelpPage extends StatelessWidget {

  void _launchYouTube() async {
    const url = 'https://www.youtube.com/watch?v=Wyd9cYmLZ10&ab_channel=VladandNiki';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Healing Hand App',
              style: titleStyle,
            ),
            SizedBox(height: 16),
            Text(
              'Welcome to Healing Hand, your health companion app that connects patients and doctors seamlessly.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 32),
      
            // Features
            Text(
              'Key Features:',
              style: heading,
            ),
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Find nearby doctors and hospitals.', style: TextStyle(color: Colors.white),),
            ),
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Schedule appointments with ease.', style: TextStyle(color: Colors.white),),
            ),
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Access ambulance services quickly.',style: TextStyle(color: Colors.white),),
            ),

            SizedBox(height: 32),
      
            Text(
              'Frequently Asked Questions:',
              style: heading,
            ),
            SizedBox(height: 16),
            FAQItem(question: 'How do I schedule an appointment?', answer: 'To schedule an appointment, go to the "Book Appointment" section and follow the instructions.'),
            FAQItem(question: 'Can I cancel an appointment?', answer: 'Yes, you can cancel appointments in the "My Appointments" section.'),
            FAQItem(question: 'How to access ambulance services?', answer: 'In case of an emergency, click on the "Emergency" button to request an ambulance.'),

            SizedBox(height: 32),
      
            ElevatedButton(
              onPressed: _launchYouTube,
              child: Text('Watch Tutorial Video'),
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(answer, style: TextStyle(color: Colors.white),),
        SizedBox(height: 16),
      ],
    );
  }
}

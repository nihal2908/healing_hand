import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      backgroundColor: Colors.deepPurple.shade200,
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Welcome to Healing Hand, your health companion app that connects patients and doctors seamlessly.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
      
            // Features
            Text(
              'Key Features:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Find nearby doctors and hospitals.'),
            ),
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Schedule appointments with ease.'),
            ),
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Access ambulance services quickly.'),
            ),

            SizedBox(height: 32),
      
            Text(
              'Frequently Asked Questions:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(answer),
        SizedBox(height: 16),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:healing_hand/customWidgets/styles.dart';
import 'package:url_launcher/url_launcher.dart';

TextStyle heading = TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);

class HelpPage extends StatelessWidget {

  void _launchYouTube() async {
    const url = 'https://youtu.be/QYlGUI28ZDc?feature=shared';
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
            FAQItem(question: 'How do I schedule an appointment?', answer: 'Your appointments will be accepted by the doctor and the timings will be set by the doctor only.'),
            FAQItem(question: 'Can I cancel an appointment?', answer: 'No, you can not cancel an appointment once made. You can get the doctor to know that you can not attend it through Chat.'),
            FAQItem(question: 'How to get info about nearest health services?', answer: 'In case of any emergency, you can click on the Emergency "Find now" button on home page. It will list out nearest healthcare providers. You have to turn on location for that.'),

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

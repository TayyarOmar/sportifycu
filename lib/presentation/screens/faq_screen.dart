import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final List<FaqItem> _faqItems = [
    FaqItem(
      question: 'About Us',
      answer:
          'Sportify is a comprehensive fitness application designed to connect you with gyms, group activities, and personal fitness tracking tools. Our mission is to make fitness accessible, enjoyable, and a core part of your lifestyle.',
    ),
    FaqItem(
      question: 'Is Sportify free to use?',
      answer:
          'Yes, the basic features of Sportify, such as browsing gyms and activities, are completely free. Certain premium features, like booking exclusive classes or accessing personalized plans, may require a subscription or one-time payment.',
    ),
    FaqItem(
      question: 'How do I find gyms near me?',
      answer:
          'Simply go to the "Explore" tab from the main navigation menu. The app will use your location to display a map of nearby gyms and fitness facilities. You can then tap on any gym to see more details.',
    ),
    FaqItem(
      question: 'What should I do if my booking didn\'t go through?',
      answer:
          'If a booking fails, first check your internet connection and payment method. If the issue persists, please navigate to the "Need Help" section in the drawer and contact our support team directly. We are here to help!',
    ),
    FaqItem(
      question: 'How do I reset my password?',
      answer:
          'On the login screen, tap the "Forgot Password?" link. You will be asked to enter your email address, and we will send you a secure link with instructions to reset your password.',
    ),
    FaqItem(
      question: 'How can I contact Sportify support?',
      answer:
          'Our support team is available 24/7. You can contact us via the in-app chat in the "Profile" section or email us at support@sportify.app. We typically respond within a few hours.',
    ),
    FaqItem(
      question: 'What does the QR code scanner do?',
      answer:
          'The QR code scanner provides a quick and seamless way to check into gyms or events. Simply open the scanner from the navigation bar and point it at the QR code provided by the facility.',
    ),
    FaqItem(
      question: 'Is my personal data safe with SportiFy?',
      answer:
          'Absolutely. We take data privacy very seriously. We use industry-standard encryption and security protocols to protect all your personal information. Your data is never shared with third parties without your explicit consent.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FAQs',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Have questions? Here you\'ll find the answers, along with help and support',
              style:
                  theme.textTheme.titleMedium?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 30),
            ..._faqItems.map((item) {
              return ExpansionTile(
                title: Text(
                  item.question,
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing:
                    Icon(Icons.keyboard_arrow_down, color: theme.primaryColor),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: Text(
                      item.answer,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}

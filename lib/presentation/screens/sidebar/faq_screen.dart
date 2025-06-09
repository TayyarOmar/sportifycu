import 'package:flutter/material.dart';
import 'package:sportify_app/utils/app_colors.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data for the expansion tiles
    final faqItems = [
      _FaqItem('About Us',
          'Sportify is the ultimate app for all your fitness needs...'),
      _FaqItem('Is Sportify free to use?',
          'Yes, the basic features of Sportify are free. We offer premium subscriptions for exclusive features.'),
      _FaqItem('How do I find gyms near me?',
          'The "Explore" tab uses your device\'s location to show you gyms and facilities in your area.'),
      _FaqItem('What do I do if my booking didn\'t go through?',
          'Please verify your internet connection and payment method. If the problem persists, contact support through the "Need Help?" section.'),
      _FaqItem('How do I reset my password?',
          'You can reset your password from the login screen by tapping on the "Forgot Password?" link.'),
      _FaqItem('How can I contact Sportify support?',
          'You can reach our support team 24/7 at support@sportify.app.'),
      _FaqItem('What does the QR code scanner do?',
          'The QR scanner allows for quick check-ins at gyms and access to exclusive offers.'),
      _FaqItem('Is my personal data safe with Sportify?',
          'Yes, we use industry-standard encryption and security practices to protect your data. See our Privacy Policy for more details.'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Have questions? Here you\'ll find the answers, along with help and support',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ...faqItems.map((item) => _FaqExpansionTile(item: item)),
          ],
        ),
      ),
    );
  }
}

class _FaqItem {
  final String title;
  final String body;
  _FaqItem(this.title, this.body);
}

class _FaqExpansionTile extends StatelessWidget {
  final _FaqItem item;
  const _FaqExpansionTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(item.title),
      iconColor: AppColors.primary,
      collapsedIconColor: AppColors.textTertiary,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(item.body),
        ),
      ],
    );
  }
}

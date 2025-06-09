import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/auth_provider.dart';
import 'package:sportify_app/utils/app_colors.dart';

class TwoFactorAuthScreen extends StatefulWidget {
  final String email;
  const TwoFactorAuthScreen({super.key, required this.email});

  @override
  State<TwoFactorAuthScreen> createState() => _TwoFactorAuthScreenState();
}

class _TwoFactorAuthScreenState extends State<TwoFactorAuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Verification Failed'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () => Navigator.of(ctx).pop(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                "Let's\nVerify\nyour account",
                style: textTheme.displaySmall,
              ),
              const SizedBox(height: 40),
              Text(
                'Two Factor\nAuthentication',
                textAlign: TextAlign.center,
                style: textTheme.headlineLarge,
              ),
              const SizedBox(height: 24),
              Text(
                'You have a received an e-mail which contains a code',
                textAlign: TextAlign.center,
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Your email : ${widget.email}',
                textAlign: TextAlign.center,
                style: textTheme.titleSmall
                    ?.copyWith(color: AppColors.textTertiary),
              ),
              const SizedBox(height: 40),
              Text(
                'Enter The code you received',
                textAlign: TextAlign.center,
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _codeController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: textTheme.headlineMedium?.copyWith(letterSpacing: 10),
                decoration: const InputDecoration(
                  hintText: '– – – – – –',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Please enter the 6-digit code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // TODO: Implement Resend Code
                    },
                    child: const Text('Resend a code',
                        style: TextStyle(color: AppColors.primary)),
                  ),
                  const Text('|',
                      style: TextStyle(color: AppColors.textTertiary)),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Change your email?',
                        style: TextStyle(color: AppColors.primary)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: authProvider.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await authProvider.verifyCodeAndLogin(
                              widget.email,
                              _codeController.text,
                            );
                            // On success, navigate to home screen
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home', (route) => false);
                          } catch (error) {
                            _showErrorDialog(error
                                .toString()
                                .replaceFirst('Exception: ', ''));
                          }
                        }
                      },
                child: authProvider.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Sign Up'), // As per the image
              ),
            ],
          ),
        ),
      ),
    );
  }
}

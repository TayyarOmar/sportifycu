import 'package:flutter/material.dart';
import 'package:sportify_app/presentation/widgets/auth_button.dart';
import 'package:sportify_app/presentation/widgets/auth_text_field.dart';
import 'package:sportify_app/utils/app_colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: const Column(
        children: [
          Icon(Icons.lock_outline, size: 80, color: AppColors.primary),
          SizedBox(height: 20),
          Text('Forgot Password?',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(
            'No worries, we\'ll send you reset instructions',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthTextField(
            labelText: 'Email',
            hintText: 'Enter your Email',
            prefixIcon: Icons.email_outlined,
          ),
          const SizedBox(height: 20),
          AuthButton(
            text: 'Reset Password',
            onPressed: () {
              // TODO: Implement password reset logic
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to Sign Up screen
                },
                child: const Text('Sign up',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

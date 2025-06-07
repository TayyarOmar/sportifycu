// lib/presentation/screens/signup_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// SignUpRequest from auth_models.dart is not directly used for API call here anymore
// import '../../presentation/providers/auth_state_provider.dart'; // authNotifierProvider is not directly used for this screen's primary action logic
import '../../presentation/providers/signup_data_provider.dart'; // Import the new provider
import '../../core/constants/app_routes.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();
  bool _agreedToTerms = false; // Added state for checkbox

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
    super.dispose();
  }

  void _goToNextStep() {
    print('[SignUpScreen] _goToNextStep called.');
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please agree to the Terms & Privacy to continue.'),
            backgroundColor: Colors.red),
      );
      print('[SignUpScreen] Terms not agreed.');
      return;
    }

    if (_formKey.currentState!.validate()) {
      print('[SignUpScreen] Form is valid.');
      try {
        ref.read(signUpDataProvider.notifier).updateNameEmailPassword(
              _nameController.text.trim(),
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );
        print('[SignUpScreen] signUpDataProvider updated.');
        context.goNamed(AppRoutes.personalizeGenderAge);
        print('[SignUpScreen] Navigating to personalizeGenderAge.');
      } catch (e) {
        print('[SignUpScreen] Error in _goToNextStep: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('An error occurred: ${e.toString()}'),
              backgroundColor: Colors.red),
        );
      }
    } else {
      print('[SignUpScreen] Form is invalid.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(authNotifierProvider); // Not needed for this button's logic

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            print('[SignUpScreen] Close button pressed.');
            // Clear any partial signup data if user closes form
            ref.read(signUpDataProvider.notifier).reset();
            context.pop();
          },
        ),
      ),
      backgroundColor: const Color(0xFF222222),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Let\'s Create\nYour Account',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(
                    controller: _nameController,
                    labelText: 'Full Name',
                    prefixIcon: Icons.person_outline,
                    validator: (val) => val == null || val.isEmpty
                        ? 'Enter your full name'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _emailController,
                    labelText: 'Email Adress',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!val.contains('@') || !val.contains('.')) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (val.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _retypePasswordController,
                    labelText: 'Retype Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please retype your password';
                      }
                      if (val != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: _agreedToTerms,
                        onChanged: (bool? value) {
                          setState(() {
                            _agreedToTerms = value ?? false;
                          });
                        },
                        checkColor: Colors.white,
                        activeColor: const Color(0xFFF57C00),
                        side: WidgetStateBorderSide.resolveWith(
                          (states) =>
                              const BorderSide(width: 1.0, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          // Make text tappable to toggle checkbox
                          onTap: () {
                            setState(() {
                              _agreedToTerms = !_agreedToTerms;
                            });
                          },
                          child: const Text('I agree to the Terms & Privacy',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF57C00),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: _goToNextStep,
                    child: const Text('Next',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Have an account?",
                          style: TextStyle(color: Colors.grey)),
                      TextButton(
                        onPressed: () {
                          print('[SignUpScreen] Sign In button pressed.');
                          // Clear any partial signup data if user goes to login
                          ref.read(signUpDataProvider.notifier).reset();
                          context.goNamed(AppRoutes.login);
                        },
                        child: const Text('Sign In',
                            style: TextStyle(
                                color: Color(0xFFF57C00),
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      style:
          const TextStyle(color: Colors.white), // Ensure input text is visible
      decoration: InputDecoration(
        hintText: labelText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(prefixIcon, color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFF333333),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFFF57C00)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        errorStyle: const TextStyle(
            color: Colors.orangeAccent), // Make errors more visible
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}

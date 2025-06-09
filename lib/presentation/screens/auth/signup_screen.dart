import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/auth_provider.dart';
import 'package:sportify_app/utils/app_colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final PageController _pageController = PageController();
  final _formKey1 = GlobalKey<FormState>();
  int _currentPage = 0;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();

  bool _termsAgreed = false;

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_currentPage == 0) {
              Navigator.of(context).pop();
            } else {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          },
        ),
        actions: [
          if (_currentPage != 0)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            )
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildPage1(context, authProvider),
          _buildPage2(context, authProvider),
          _buildPage3(context, authProvider),
        ],
      ),
    );
  }

  // Page 1: Create Account
  Widget _buildPage1(BuildContext context, AuthProvider authProvider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: _formKey1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text("Let's Create\nYour Account",
                style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 40),
            TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: 'Full Name'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: 'Email Adress'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter an email';
                if (!value.contains('@')) return 'Please enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline), hintText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter a password';
                if (value.length < 6)
                  return 'Password must be at least 6 characters';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _retypePasswordController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  hintText: 'Retype Password'),
              obscureText: true,
              validator: (value) {
                if (value != _passwordController.text)
                  return 'Passwords do not match';
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _termsAgreed,
                  onChanged: (value) => setState(() => _termsAgreed = value!),
                  activeColor: AppColors.primary,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'I agree to the ',
                      style: Theme.of(context).textTheme.bodySmall,
                      children: [
                        TextSpan(
                          text: 'Terms & Privacy',
                          style: const TextStyle(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // TODO: Show terms and privacy policy
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey1.currentState!.validate() && _termsAgreed) {
                    authProvider.updateSignupData(
                      name: _fullNameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    _nextPage();
                  } else if (!_termsAgreed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'You must agree to the terms and privacy policy.')),
                    );
                  }
                },
                child: const Text('Next'),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Have an account? ',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            () => Navigator.of(context).pushNamed('/login'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Page 2: Personalized Profiles (Gender/Age)
  Widget _buildPage2(BuildContext context, AuthProvider authProvider) {
    final gender = authProvider.signupData.gender;
    final age = authProvider.signupData.age;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text("Create Your\npersonalized profiles",
              style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 40),
          Text("Your Gender", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          _buildOption<String>(context, 'Male', gender,
              (value) => authProvider.updateSignupData(gender: value)),
          const SizedBox(height: 12),
          _buildOption<String>(context, 'Female', gender,
              (value) => authProvider.updateSignupData(gender: value)),
          const SizedBox(height: 40),
          Text("Your Age", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          _buildOption<String>(context, 'Under 18', age,
              (value) => authProvider.updateSignupData(age: value)),
          const SizedBox(height: 12),
          _buildOption<String>(context, '18 - 35', age,
              (value) => authProvider.updateSignupData(age: value)),
          const SizedBox(height: 12),
          _buildOption<String>(context, 'More than 35', age,
              (value) => authProvider.updateSignupData(age: value)),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    child: const Text('Next'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              TextButton(
                  onPressed: _nextPage,
                  child: const Text("Skip",
                      style: TextStyle(color: AppColors.primary)))
            ],
          ),
        ],
      ),
    );
  }

  // Page 3: Fitness Goals
  Widget _buildPage3(BuildContext context, AuthProvider authProvider) {
    final goals = authProvider.signupData.fitnessGoals;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text("Create Your\npersonalized profiles",
              style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 40),
          Text("Your fitness goals",
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          _buildMultiSelectOption(
              context, 'Build Muscles', goals, authProvider),
          const SizedBox(height: 12),
          _buildMultiSelectOption(
              context, 'Lose/Gain Weight', goals, authProvider),
          const SizedBox(height: 12),
          _buildMultiSelectOption(
              context, 'Lifting Fitness', goals, authProvider),
          const SizedBox(height: 12),
          _buildMultiSelectOption(
              context, 'Other Sports activities', goals, authProvider),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await authProvider.signup();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Signup successful! Please log in.')),
                        );
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (route) => false);
                      } catch (error) {
                        _showErrorDialog(error.toString());
                      }
                    },
                    child: authProvider.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Sign up'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              TextButton(
                  onPressed: () {
                    // TODO: Handle skip
                  },
                  child: const Text("Skip",
                      style: TextStyle(color: AppColors.primary)))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOption<T>(BuildContext context, String title, T? groupValue,
      ValueChanged<T> onChanged) {
    return GestureDetector(
      onTap: () => onChanged(title as T),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: groupValue == title ? AppColors.primary : AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              groupValue == title
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: Colors.white,
            ),
            const SizedBox(width: 16),
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildMultiSelectOption(BuildContext context, String title,
      List<String> selectedGoals, AuthProvider authProvider) {
    final isSelected = selectedGoals.contains(title);
    return GestureDetector(
      onTap: () {
        final newGoals = List<String>.from(selectedGoals);
        if (isSelected) {
          newGoals.remove(title);
        } else {
          newGoals.add(title);
        }
        authProvider.updateSignupData(fitnessGoals: newGoals);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: Colors.white,
            ),
            const SizedBox(width: 16),
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

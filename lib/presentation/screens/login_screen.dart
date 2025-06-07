// lib/presentation/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter
import '../../data/models/auth_models.dart';
import '../../presentation/providers/auth_state_provider.dart';
import '../../core/constants/app_routes.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    print('[LoginScreen] _submitLogin called.');
    if (_formKey.currentState!.validate()) {
      print('[LoginScreen] Form is valid.');
      try {
        ref.read(authNotifierProvider.notifier).login(
              LoginRequest(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
              ),
            );
        print('[LoginScreen] authNotifier.login() called.');
      } catch (e) {
        print(
            '[LoginScreen] Error in _submitLogin before calling notifier: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('An unexpected error occurred: ${e.toString()}'),
              backgroundColor: Colors.red),
        );
      }
    } else {
      print('[LoginScreen] Form is invalid.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the auth state for navigation and error handling
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        requires2FACode: (email, message) {
          print(
              '[LoginScreen] State changed to requires2FACode. Navigating to verify2FA.');
          context.go(AppRoutes.verify2FA, extra: email);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(message ??
                    'Verification code sent. Please check your inbox.')),
          );
        },
        // Error display is now handled by the persistent Text widget below
        // error: (message) {
        //   print('[LoginScreen] State changed to error: $message');
        // },
      );
    });

    final authState = ref.watch(authNotifierProvider);

    // ThemeData for easy access to theme colors
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
        // Example: Add a back button if appropriate for your flow from AuthOptions
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => context.goNamed(AppRoutes.authOptions),
        // ),
      ),
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
                    'Welcome Back!',
                    style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white), // Ensure text visibility
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  authState.maybeWhen(
                    error: (message) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        message, // Display the error message from authState
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    orElse: () => const SizedBox.shrink(),
                  ),
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(
                        color: Colors.white), // Ensure input text is visible
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[700]!),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.grey[400]),
                      errorStyle: const TextStyle(
                          color:
                              Colors.orangeAccent), // Make errors more visible
                    ),
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
                  TextFormField(
                    controller: _passwordController,
                    style: const TextStyle(
                        color: Colors.white), // Ensure input text is visible
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[700]!),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.grey[400]),
                      errorStyle: const TextStyle(
                          color:
                              Colors.orangeAccent), // Make errors more visible
                    ),
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
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        print('[LoginScreen] Forgot Password button pressed.');
                        context.goNamed(AppRoutes.resetPassword);
                      },
                      child: Text('Forgot Password?',
                          style: TextStyle(color: theme.primaryColor)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  authState.maybeWhen(
                    loading: () => Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                theme.primaryColor))),
                    orElse: () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: _submitLogin,
                      child: const Text('Log In'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style: TextStyle(color: Colors.grey[400])),
                      TextButton(
                        onPressed: () {
                          print('[LoginScreen] Sign Up button pressed.');
                          context.goNamed(AppRoutes.signup);
                        },
                        child: Text('Sign Up',
                            style: TextStyle(
                                color: theme.primaryColor,
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
}

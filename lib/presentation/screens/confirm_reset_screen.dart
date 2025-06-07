// lib/presentation/screens/confirm_reset_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/auth_models.dart';
import '../../presentation/providers/auth_state_provider.dart';
import '../../core/constants/app_routes.dart';

class ConfirmResetScreen extends ConsumerStatefulWidget {
  // Email is now expected to be passed via GoRouter's `extra` parameter
  const ConfirmResetScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConfirmResetScreen> createState() => _ConfirmResetScreenState();
}

class _ConfirmResetScreenState extends ConsumerState<ConfirmResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _email; // To store the email passed via route parameters

  @override
  void initState() {
    super.initState();
    // It's safer to fetch route parameters once, e.g., in initState or didChangeDependencies
    // For simplicity with GoRouterState, we can also access it in build if it doesn't change often.
    // However, for data that drives logic like _email, initState or didChangeDependencies is better.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Extract email here as context is available and it happens before first build if needed
    final routeData = GoRouterState.of(context).extra as Map<String, dynamic>?;
    if (routeData != null && routeData.containsKey('email')) {
      _email = routeData['email'] as String?;
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitConfirmReset() {
    if (_formKey.currentState!.validate()) {
      if (_email == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Error: Email not found. Please try resetting password again.'),
              backgroundColor: Colors.red),
        );
        return;
      }
      ref.read(authNotifierProvider.notifier).confirmPasswordReset(
            ConfirmPasswordResetRequest(
              email: _email!,
              code: _codeController.text.trim(),
              newPassword: _newPasswordController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        unauthenticated: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    message ?? 'Password reset successful. Please log in.')),
          );
          context.goNamed(AppRoutes.login); // Navigate to login screen
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        },
      );
    });

    final authState = ref.watch(authNotifierProvider);

    if (_email == null) {
      // This is a fallback, should ideally not happen if navigation is correct
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Could not retrieve email for password reset. Please start the process again.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Set New Password')),
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
                    'Enter the code sent to $_email and your new password.',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _codeController,
                    decoration: const InputDecoration(
                      labelText: 'Verification Code',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.password_sharp),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter the code';
                      }
                      if (val.length != 6) return 'Code must be 6 digits';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _newPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    obscureText: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter a new password';
                      }
                      if (val.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm New Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_reset),
                    ),
                    obscureText: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please confirm your new password';
                      }
                      if (val != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  authState.maybeWhen(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    orElse: () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: _submitConfirmReset,
                      child: const Text('Reset Password'),
                    ),
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

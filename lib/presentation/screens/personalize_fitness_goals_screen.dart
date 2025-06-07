// lib/presentation/screens/personalize_fitness_goals_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_routes.dart';
import '../../data/models/auth_models.dart'; // Defines SignUpRequest
import '../providers/auth_state_provider.dart';
import '../providers/signup_data_provider.dart';

class PersonalizeFitnessGoalsScreen extends ConsumerStatefulWidget {
  const PersonalizeFitnessGoalsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PersonalizeFitnessGoalsScreen> createState() =>
      _PersonalizeFitnessGoalsScreenState();
}

class _PersonalizeFitnessGoalsScreenState
    extends ConsumerState<PersonalizeFitnessGoalsScreen> {
  // List of all possible fitness goals
  final List<String> _allGoals = [
    'Lose Weight',
    'Build Muscle',
    'Improve Endurance',
    'Increase Flexibility',
    'Boost Overall Health',
  ];

  // Tracks which goals the user has tapped
  final Set<String> _selectedGoals = {};

  bool _isLoading = false;

  Future<void> _performSignUp({required bool skipGoals}) async {
    setState(() {
      _isLoading = true;
    });

    final signUpData = ref.read(signUpDataProvider);
    final List<String> goalsToSend = skipGoals ? [] : _selectedGoals.toList();

    // Fire off the signUp call. We do NOT navigate here;
    // the ref.listen below will catch when signup succeeds.
    ref.read(authNotifierProvider.notifier).signUp(
          SignUpRequest(
            name: signUpData.name!,
            email: signUpData.email!,
            password: signUpData.password!,
            gender: signUpData.gender,
            age: signUpData.age,
            fitnessGoals: goalsToSend,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    // Listen for AuthState changes. Once signupSucceeded is emitted,
    // navigate to the Login screen (and show a SnackBar).
    ref.listen<AuthState>(
      authNotifierProvider,
      (previous, next) {
        next.whenOrNull(
          signupSucceeded: (user) {
            context.goNamed(AppRoutes.login);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account created! Please log in.'),
              ),
            );
          },
          error: (message) {
            // Stop loading on error
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalize Your Profile'),
        actions: [
          TextButton(
            onPressed: () => _performSignUp(skipGoals: true),
            child: const Text('Skip'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select your fitness goals',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _allGoals.length,
                itemBuilder: (context, index) {
                  final goal = _allGoals[index];
                  final isSelected = _selectedGoals.contains(goal);
                  return Card(
                    color: isSelected
                        ? Theme.of(context).primaryColor.withAlpha(100)
                        : null,
                    child: ListTile(
                      title: Text(goal),
                      trailing: isSelected
                          ? Icon(Icons.check_circle,
                              color: Theme.of(context).primaryColor)
                          : const Icon(Icons.check_circle_outline),
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedGoals.remove(goal);
                          } else {
                            _selectedGoals.add(goal);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ElevatedButton(
                onPressed: () => _performSignUp(skipGoals: false),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Sign Up'),
              ),
            // Display error message if authState is error
            Consumer(
              builder: (context, ref, child) {
                final authState = ref.watch(authNotifierProvider);
                return authState.maybeWhen(
                  error: (message) => Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Signup failed: $message',
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// content of lib/presentation/screens/personalize_gender_age_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_routes.dart';
import '../../presentation/providers/signup_data_provider.dart';

class PersonalizeGenderAgeScreen extends ConsumerStatefulWidget {
  const PersonalizeGenderAgeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PersonalizeGenderAgeScreen> createState() =>
      _PersonalizeGenderAgeScreenState();
}

class _PersonalizeGenderAgeScreenState
    extends ConsumerState<PersonalizeGenderAgeScreen> {
  String? _selectedGender;
  String? _selectedAgeRange;

  // As per your UI: Age ranges: "Under 18", "18-35", "More than 35"
  // For backend, we need to store age as int. We can map these strings to representative integers or discuss how to handle.
  // For now, let's store the string and decide on mapping when calling the API.
  // Or, the `UserCreate` schema takes `age: Optional[int]`. Maybe we use the lower bound of the range or an average?
  // For simplicity, let's map "Under 18" to 17, "18-35" to 25, "More than 35" to 40 for now if an int is needed.
  // However, the `UserCreate` schema in backend/schemas.py for `age` is `Optional[int]`, not a string range.
  // The `User` model also has `age: Optional[int]`. Let's plan to send an int.

  int? _getAgeValue(String? ageRange) {
    if (ageRange == null) return null;
    if (ageRange == 'Under 18') return 17; // Representative value
    if (ageRange == '18 - 35') return 25; // Representative value
    if (ageRange == 'More than 35') return 40; // Representative value
    return null;
  }

  void _onNext() {
    final ageValue = _getAgeValue(_selectedAgeRange);
    // Call updateGenderAndAge from SignUpDataNotifier
    ref.read(signUpDataProvider.notifier).updateGenderAndAge(
          gender: _selectedGender,
          age: ageValue,
        );
    context.goNamed(AppRoutes.personalizeFitnessGoals);
  }

  void _onSkip() {
    context.goNamed(AppRoutes.personalizeFitnessGoals);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF222222), // Dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // No back button
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: _onSkip,
              child: const Text(
                'Skip',
                style: TextStyle(color: Color(0xFFF57C00), fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Builder(builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: screenHeight -
                    (Scaffold.of(context).appBarMaxHeight ?? kToolbarHeight) -
                    MediaQuery.of(context).padding.top,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                              'assets/images/LOGO.png', // Corrected asset path
                              height: 40), // Small logo top left
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        Text(
                          'Create Your\npersonalized profiles',
                          style: theme.textTheme.headlineMedium?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        Text(
                          'Your Gender',
                          style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        _buildSelectableButton(
                          text: 'Male',
                          isSelected: _selectedGender == 'Male',
                          onTap: () => setState(() => _selectedGender = 'Male'),
                        ),
                        const SizedBox(height: 10),
                        _buildSelectableButton(
                          text: 'Female',
                          isSelected: _selectedGender == 'Female',
                          onTap: () =>
                              setState(() => _selectedGender = 'Female'),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        Text(
                          'Your Age',
                          style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        _buildSelectableButton(
                          text: 'Under 18',
                          isSelected: _selectedAgeRange == 'Under 18',
                          onTap: () =>
                              setState(() => _selectedAgeRange = 'Under 18'),
                        ),
                        const SizedBox(height: 10),
                        _buildSelectableButton(
                          text: '18 - 35',
                          isSelected: _selectedAgeRange == '18 - 35',
                          onTap: () =>
                              setState(() => _selectedAgeRange = '18 - 35'),
                        ),
                        const SizedBox(height: 10),
                        _buildSelectableButton(
                          text: 'More than 35',
                          isSelected: _selectedAgeRange == 'More than 35',
                          onTap: () => setState(
                              () => _selectedAgeRange = 'More than 35'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFF57C00), // Orange color
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          onPressed: _onNext,
                          child: const Text('Next',
                              style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDot(isActive: true),
                            const SizedBox(width: 8),
                            _buildDot(isActive: false),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSelectableButton(
      {required String text,
      required bool isSelected,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF57C00) : const Color(0xFF333333),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.white, size: 20)
            else
              const Icon(Icons.radio_button_unchecked,
                  color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFF57C00) : Colors.grey[700],
        shape: BoxShape.circle,
      ),
    );
  }
}

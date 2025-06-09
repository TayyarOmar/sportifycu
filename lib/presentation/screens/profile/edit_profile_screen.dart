import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/auth_provider.dart';
import 'package:sportify_app/models/user.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  String? _gender;
  late TextEditingController _ageController;
  List<String> _fitnessGoals = [];

  final List<String> _allGoals = [
    'Build Muscles',
    'Lose/Gain Weight',
    'Lifting Fitness',
    'Other Sports activities'
  ];

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    _nameController = TextEditingController(text: user?.name ?? '');
    _gender = user?.gender;
    _ageController = TextEditingController(text: user?.age?.toString() ?? '');
    _fitnessGoals = List<String>.from(user?.fitnessGoals ?? []);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.updateProfile(
        name: _nameController.text,
        gender: _gender,
        age: int.tryParse(_ageController.text),
        fitnessGoals: _fitnessGoals,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Personal Information')),
        body: const Center(child: Text('User not found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: authProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your name' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _gender,
                    items: ['Male', 'Female', 'Other']
                        .map((label) =>
                            DropdownMenuItem(child: Text(label), value: label))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Gender'),
                  ),
                  const SizedBox(height: 30),
                  Text('Fitness Goals',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    children: _allGoals.map((goal) {
                      final isSelected = _fitnessGoals.contains(goal);
                      return FilterChip(
                        label: Text(goal),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _fitnessGoals.add(goal);
                            } else {
                              _fitnessGoals.remove(goal);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
    );
  }
}

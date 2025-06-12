import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/group_activity_provider.dart';
import 'package:sportify_app/presentation/screens/activity/team_details_screen.dart';
import 'package:sportify_app/utils/app_colors.dart';
import 'package:sportify_app/presentation/widgets/auth_text_field.dart';
import 'package:sportify_app/providers/notification_provider.dart';

class CreateTeamScreen extends StatefulWidget {
  final String category;
  const CreateTeamScreen({super.key, required this.category});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  final _teamNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _contactController = TextEditingController();
  final _playersNeededController = TextEditingController();
  final _ageRangeController = TextEditingController();

  DateTime? _selectedDate;
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (time == null) return;

    setState(() {
      _selectedDate =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _contactController.dispose();
    _playersNeededController.dispose();
    _ageRangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let's Create\nAn Activity Team",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primary,
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFormField(
                  controller: _playersNeededController,
                  label: 'Players Needed',
                  keyboardType: TextInputType.number),
              _buildFormField(
                  controller: _teamNameController, label: 'Team Name'),
              _buildFormField(
                  controller: _descriptionController, label: 'Description'),
              _buildFormField(
                  controller: _locationController, label: 'Location'),
              _buildDateTimeButton(),
              _buildFormField(
                  controller: _ageRangeController, label: 'Age Range'),
              _buildFormField(
                  controller: _contactController, label: 'Contact Information'),
              _buildUploadButton(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _createTeam,
                child: const Text('Create Team'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(
      {required TextEditingController controller,
      required String label,
      TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          fillColor: AppColors.primary.withOpacity(0.8),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) =>
            value!.isEmpty ? 'This field cannot be empty' : null,
      ),
    );
  }

  Widget _buildDateTimeButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton(
        onPressed: _pickDateTime,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primary.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            _selectedDate == null
                ? 'Date & Time'
                : DateFormat('yyyy-MM-dd – hh:mm a').format(_selectedDate!),
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton.icon(
        icon: const Icon(Icons.upload_file),
        label: Text(_selectedImage == null
            ? 'Upload PIC'
            : 'Image Selected: ${_selectedImage!.path.split('/').last}'),
        onPressed: _pickImage,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primary.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  void _createTeam() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final provider =
          Provider.of<GroupActivityProvider>(context, listen: false);
      final newTeam = await provider.createTeam(
        name: _teamNameController.text,
        description: _descriptionController.text,
        category: widget.category,
        location: _locationController.text,
        dateAndTime: _selectedDate!,
        playersNeeded: int.parse(_playersNeededController.text),
        contactInformation: _contactController.text,
        ageRange: _ageRangeController.text,
        photo: _selectedImage,
      );

      if (newTeam != null) {
        Provider.of<NotificationProvider>(context, listen: false)
            .addNotification(
                'Team Created', 'Your team "${newTeam.name}" has been created');
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) =>
              TeamDetailsScreen(team: newTeam, isNewlyCreated: true),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to create team: ${provider.errorMessage ?? 'Unknown error'}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly.')),
      );
    }
  }
}

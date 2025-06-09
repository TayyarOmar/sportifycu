import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/models/group_activity_team.dart';
import 'package:sportify_app/providers/group_activity_provider.dart';
import 'package:sportify_app/presentation/screens/activity/team_details_screen.dart';
import 'package:sportify_app/utils/app_colors.dart';

class EditTeamScreen extends StatefulWidget {
  final GroupActivityTeam team;
  const EditTeamScreen({super.key, required this.team});

  @override
  State<EditTeamScreen> createState() => _EditTeamScreenState();
}

class _EditTeamScreenState extends State<EditTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _teamNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;
  late TextEditingController _contactController;
  late TextEditingController _playersNeededController;
  late TextEditingController _ageRangeController;

  DateTime? _selectedDate;
  // File? _selectedImage; // Photo editing not supported in this version

  @override
  void initState() {
    super.initState();
    _teamNameController = TextEditingController(text: widget.team.name);
    _descriptionController =
        TextEditingController(text: widget.team.description);
    _locationController = TextEditingController(text: widget.team.location);
    _contactController =
        TextEditingController(text: widget.team.contactInformation);
    _playersNeededController =
        TextEditingController(text: widget.team.playersNeeded.toString());
    _ageRangeController = TextEditingController(text: widget.team.ageRange);
    _selectedDate = widget.team.dateAndTime;
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate ?? DateTime.now()),
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
        title: const Text("Edit Activity Team",
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
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updateTeam,
                child: const Text('Save Changes'),
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

  void _updateTeam() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final provider =
          Provider.of<GroupActivityProvider>(context, listen: false);
      final updatedTeam = await provider.updateTeam(
        teamId: widget.team.teamId,
        name: _teamNameController.text,
        description: _descriptionController.text,
        category: widget.team.category, // Category is not editable for now
        location: _locationController.text,
        dateAndTime: _selectedDate!,
        playersNeeded: int.parse(_playersNeededController.text),
        contactInformation: _contactController.text,
        ageRange: _ageRangeController.text,
      );

      if (updatedTeam != null) {
        // Pop the edit screen and return to the details screen
        Navigator.of(context).pop(updatedTeam);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to update team: ${provider.errorMessage ?? 'Unknown error'}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly.')),
      );
    }
  }
}

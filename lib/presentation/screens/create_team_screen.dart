import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../data/models/team_model.dart';
import '../providers/create_team_provider.dart';

class CreateTeamScreen extends ConsumerStatefulWidget {
  final String sportType;
  const CreateTeamScreen({Key? key, required this.sportType}) : super(key: key);

  @override
  _CreateTeamScreenState createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends ConsumerState<CreateTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _dateTimeController = TextEditingController();
  final _ageRangeController = TextEditingController();
  final _contactInfoController = TextEditingController();
  final _playersNeededController = TextEditingController();
  File? _image;
  DateTime? _selectedDateTime;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _dateTimeController.dispose();
    _ageRangeController.dispose();
    _contactInfoController.dispose();
    _playersNeededController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _dateTimeController.text =
              DateFormat.yMd().add_jm().format(_selectedDateTime!);
        });
      }
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final teamToCreate = TeamCreate(
        name: _nameController.text,
        sport: widget.sportType,
        description: _descriptionController.text,
        location: _locationController.text,
        dateTime: _dateTimeController.text,
        ageRange: _ageRangeController.text,
        contactInfo: _contactInfoController.text,
        playersNeeded: _playersNeededController.text,
        // TODO: Implement image upload and get URL
        imageUrl: _image?.path,
      );
      ref.read(createTeamProvider.notifier).createTeam(teamToCreate);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<CreateTeamState>(createTeamProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        success: (team) {
          context.goNamed('teamCreatedSuccess',
              pathParameters: {'teamId': team.id.toString()});
        },
        error: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        },
      );
    });

    final state = ref.watch(createTeamProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150.0),
        child: _buildAppBar(context, widget.sportType),
      ),
      body: state.maybeWhen(
        loading: () => const Center(child: CircularProgressIndicator()),
        orElse: () => _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField('Players Needed', _playersNeededController,
                keyboardType: TextInputType.number),
            _buildTextField('Team Name', _nameController),
            _buildTextField('Description', _descriptionController),
            _buildTextField('Location', _locationController),
            _buildTextField(
              'Date & Time',
              _dateTimeController,
              readOnly: true,
              onTap: () => _selectDateTime(context),
            ),
            _buildTextField('Age Range', _ageRangeController),
            _buildTextField('Contact Information', _contactInfoController),
            _buildUploadButton(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF6A2A),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Submit',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, String sportType) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 150,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFEF6A2A),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BackButton(
                color: Colors.white,
                onPressed: () => context.pop(),
              ),
            ),
            const Spacer(),
            Text(
              "Let's\nCreate ${sportType.replaceFirst(sportType[0], sportType[0].toUpperCase())} Team",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool readOnly = false,
      VoidCallback? onTap,
      TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: const Color(0xFF3A3A3C),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildUploadButton() {
    return ElevatedButton.icon(
      onPressed: _pickImage,
      icon: const Icon(Icons.upload_file),
      label: Text(_image == null ? 'Upload PIC' : 'Image Selected!'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF3A3A3C),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}

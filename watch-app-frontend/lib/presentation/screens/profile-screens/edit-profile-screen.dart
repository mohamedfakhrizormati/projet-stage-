import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/screens/home-screen.dart';
import 'package:clean_arch/presentation/widgets/headers/Payment-header.dart';
import 'package:clean_arch/presentation/widgets/image-container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedGender;
  String? _birthDate;
  DateTime? _selectedBirthdate;

  DateFormat format = DateFormat("yyyy-MM-dd");

  void _pickBirthdate(BuildContext context) async {
    DateTime initialDate = _selectedBirthdate ?? DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedBirthdate = pickedDate;
        _birthDate = format.format(_selectedBirthdate!);
      });
    }
  }

  final AuthenticationController authenticationController = Get.find();

  @override
  void initState() {
    _firstNameController.text = authenticationController.currentUser.firstName;
    _addressController.text = authenticationController.currentUser.adresse;
    _lastNameController.text = authenticationController.currentUser.lastName;
    _phoneController.text = authenticationController.currentUser.phone;
    _birthDate = format.format(authenticationController.currentUser.birthDate);
    _selectedGender = authenticationController.currentUser.gender;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PaymentHeader(title: "Edit Profile"),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.black,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          const ImageContainer(
                            imageUrl:
                                "https://cdn3.pixelcut.app/7/20/uncrop_hero_bdf08a8ca6.jpg",
                            edit: true, // Pass null initially for default icon
                            // onImageSelect:
                            //     _pickImage, // Implement image selection logic
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              labelText: "First Name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your first name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              labelText: "Last Name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your last name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _addressController,
                            decoration: InputDecoration(
                              labelText: "Address",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your address";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: "Phone",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your Phone";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField<String>(
                            value: _selectedGender,
                            decoration: InputDecoration(
                              labelText: "Gender",
                            ),
                            items: ['Male', 'Female']
                                .map((gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please select your gender";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => _pickBirthdate(context),
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Birthdate",
                                  suffixIcon: const Icon(Icons.calendar_today),
                                ),
                                controller:
                                    TextEditingController(text: _birthDate),
                                validator: (value) {
                                  if (_selectedBirthdate == null) {
                                    return "Please select your birthdate";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Profile updated successfully!"),
                                    ),
                                  );
                                  authenticationController.updateProfile(
                                      address: _addressController.text,
                                      firstName: _firstNameController,
                                      lastName: _lastNameController,
                                      phone: _phoneController,
                                      id: authenticationController
                                          .currentUser.id,
                                      birthDate: _birthDate!,
                                      gender: _selectedGender!,
                                      context: context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFAF6767),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}

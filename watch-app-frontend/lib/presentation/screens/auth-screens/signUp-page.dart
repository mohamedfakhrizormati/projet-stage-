import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/widgets/inputs/form-input.dart';
import 'package:clean_arch/presentation/widgets/inputs/input-password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

final firstNameController = TextEditingController();
final lastNameController = TextEditingController();
final emailController = TextEditingController();
final adresseController = TextEditingController();
final phoneController = TextEditingController();
final passwordController = TextEditingController();
final confirmPasswordController = TextEditingController();

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthenticationController authenticationController = Get.find();

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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height * 0.2,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 60),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: const Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Merriweather',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Form container
          Expanded(
            child: Container(
              height: height * 0.8,
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // First name
                            Expanded(
                                child: FormInput(
                              text: "First Name",
                              controller: firstNameController,
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .first_name_required;
                                } else {
                                  return null;
                                }
                              },
                              prefixIcon: const Icon(Icons.person),
                            )),
                            const SizedBox(width: 10),
                            // Last name
                            Expanded(
                                child: FormInput(
                              text: "Last Name",
                              controller: lastNameController,
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .last_name_required;
                                } else {
                                  return null;
                                }
                              },
                              prefixIcon: const Icon(Icons.person),
                            )),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Email
                        FormInput(
                          text: 'Email',
                          controller: emailController,
                          validator: (v) {
                            if (!v!.endsWith("@gmail.com") || v.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .invalid_email_address;
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: const Icon(Icons.email),
                          hint: 'Example@gmail.com',
                        ),
                        const SizedBox(height: 20),
                        // Address
                        FormInput(
                          text: "Address",
                          controller: adresseController,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .address_required;
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: const Icon(Icons.location_on),
                          hint:
                              'Avenue Habib Bourguiba, Tunis 1000, Tunisia',
                        ),
                        const SizedBox(height: 20),
                        // Phone
                        FormInput(
                          text: "Phone",
                          controller: phoneController,
                          validator: (v) {
                            if (v!.isEmpty || v!.length < 8) {
                              return AppLocalizations.of(context)!
                                  .phone_number_equired;
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: const Icon(Icons.phone),
                          hint: '+216 72 000 000',
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            // Gender dropdown
                            Expanded(
                              child: Container(
                                height: 50,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Gender',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5),
                                    ),
                                    prefixIcon: const Icon(Icons.person),
                                  ),
                                  items: const ['Male', 'Female']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                  hint: const Text('gender'),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Date picker
                            Expanded(
                              child: Container(
                                height: 50,
                                child: TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: 'Birth Date',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5),
                                    ),
                                    prefixIcon:
                                        const Icon(Icons.calendar_today),
                                  ),
                                  onTap: () => _pickBirthdate(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Password
                        PasswordInput(
                          text: 'Password',
                          controller: passwordController,
                          validator: (p0) {
                            if (p0!.isEmpty || p0.length < 8) {
                              return AppLocalizations.of(context)!
                                  .invalid_password;
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        PasswordInput(
                          text: 'confirm Password',
                          controller: confirmPasswordController,
                          validator: (p0) {
                            if (p0!.isEmpty ||
                                p0 != passwordController.text) {
                              return AppLocalizations.of(context)!
                                  .password_does_not_match;
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                    
                        // Create Account button
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFAF6767),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GetBuilder(
                              init: AuthenticationController(),
                              builder: (controller) {
                                return TextButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await controller.createAccount(
                                          cpassword:
                                              confirmPasswordController,
                                          email: emailController,
                                          firstName: firstNameController,
                                          adresse: adresseController,
                                          phone: phoneController,
                                          lastName: lastNameController,
                                          password: passwordController,
                                          birthDate: _birthDate!,
                                          gender: _selectedGender!,
                                          image: "",
                                          context: context);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: AppLocalizations.of(context)!
                                              .missing_data,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              Color(0xFFAF6767),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                    
                                    print("Account created!");
                                  },
                                  child: const Text(
                                    "Create ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Merriweather',
                                    ),
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(height: 20),
                      ],
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
}

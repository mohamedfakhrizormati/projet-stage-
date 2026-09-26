import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/widgets/headers/Payment-header.dart';
import 'package:clean_arch/presentation/widgets/buttons/custom-text-button.dart';
import 'package:clean_arch/presentation/widgets/inputs/input-password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final AuthenticationController authenticationController = Get.find();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Column(
            children: [
              PaymentHeader(title: "Update Password"),
              Expanded(
                child: Container(
                  color: Colors.black,
                  child: Container(
                    height: height * 0.8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 70),
                            const Text(
                              "Update Your Password",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 30),
                            PasswordInput(
                              text: "Current Password",
                              controller: currentPasswordController,
                              validator: (p0) {
                                if (p0!.isEmpty || p0.length < 8) {
                                  return AppLocalizations.of(context)!
                                      .wrong_password;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            PasswordInput(
                              text: "New Password",
                              controller: passwordController,
                              validator: (p0) {
                                if (p0!.isEmpty ||
                                    p0.length < 8 ||
                                    p0 == currentPasswordController.text) {
                                  return AppLocalizations.of(context)!
                                      .invalid_password;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            PasswordInput(
                              text: "Confirm Password",
                              controller: confirmPasswordController,
                              validator: (p0) {
                                if (p0!.isEmpty ||
                                    p0 != passwordController.text) {
                                  return AppLocalizations.of(context)!
                                      .password_does_not_match;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),
                            CustomTextButton(
                                width: double.infinity,
                                height: 50,
                                color: Color(0xFFAF6767),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    print("Form validation successful.");

                                    await authenticationController
                                        .updatePassword(
                                            currentPasswordController,
                                            passwordController,
                                            confirmPasswordController,
                                            context);
                                  }
                                },
                                text: "Update Password",
                                textColor: Colors.white)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

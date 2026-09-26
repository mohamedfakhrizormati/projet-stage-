import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/widgets/headers/Payment-header.dart';
import 'package:clean_arch/presentation/widgets/inputs/input-password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

final passwordController = TextEditingController();

final confirmPasswordController = TextEditingController();

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              PaymentHeader(title: "Reset Password"),
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
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 70),
                            const Text(
                              "Reset Your Password",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Merriweather',
                              ),
                            ),
                            const SizedBox(height: 100),
                            // Code
                            PasswordInput(
                              text: "New Password",
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
                            SizedBox(
                              height: 20,
                            ),
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
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFFAF6767),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  final AuthenticationController controller =
                                      Get.find();
                                  await controller.resetPassword(
                                      passwordController,
                                      confirmPasswordController,
                                      context);
                                  // Handle account creation
                                },
                                child: const Text(
                                  "Reset Password",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Merriweather',
                                  ),
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
            ],
          )
        ],
      ),
    );
  }
}

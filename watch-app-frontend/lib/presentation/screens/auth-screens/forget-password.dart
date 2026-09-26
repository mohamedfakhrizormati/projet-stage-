import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/widgets/headers/Payment-header.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

final emailController = TextEditingController();

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              PaymentHeader(title: "Forget Password"),
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
                            SizedBox(height: 50),
                            const Text(
                              "Enter your Email To Reset Password ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                // fontWeight: FontWeight.w500,
                                fontFamily: 'Merriweather',
                              ),
                            ),
                            const SizedBox(height: 100),
                            // Email
                            Container(
                              height: 40,
                              child: TextFormField(
                                controller: emailController,
                                validator: (v) {
                                  if (!v!.endsWith("@gmail.com") || v.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .invalid_email_address;
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  hintText: AppLocalizations.of(context)!.email,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  prefixIcon: const Icon(Icons.email),
                                ),
                              ),
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
                              child: GetBuilder<AuthenticationController>(
                                  init: AuthenticationController(),
                                  builder: (controller) {
                                    return TextButton(
                                      onPressed: () async {
                                        await controller
                                            .sendFrogetPasswordRequest(
                                                emailController,
                                                emailController.text,
                                                context);
                                        // Handle account creation
                                      },
                                      child: const Text(
                                        "Sent",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }),
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
    const Placeholder();
  }
}

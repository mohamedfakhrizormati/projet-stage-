import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/widgets/headers/Payment-header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

final otpController = TextEditingController();

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              PaymentHeader(title: "Code Verification"),
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
                              "Enter The OTP Sent To Your Email",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Merriweather',
                              ),
                            ),
                            const SizedBox(height: 100),
                            // Code
                            Container(
                              height: 40,
                              child: TextFormField(
                                controller: otpController,
                                decoration: InputDecoration(
                                  labelText: 'Code',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  prefixIcon: const Icon(Icons.key),
                                ),
                                keyboardType: TextInputType.numberWithOptions(),
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
                              child: TextButton(
                                onPressed: () async {
                                  final AuthenticationController controller =
                                      Get.find();
                                  await controller.verifyOTP(
                                      otpController, context);
                                  // Handle account creation
                                },
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(
                                    fontFamily: 'Merriweather',
                                    color: Colors.white,
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

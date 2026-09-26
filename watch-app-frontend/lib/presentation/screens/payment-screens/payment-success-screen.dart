import 'package:clean_arch/domain/enteties/command.dart';
import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/controller/command_controller.dart';
import 'package:clean_arch/presentation/screens/home-screen.dart';
import 'package:clean_arch/presentation/screens/main-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSuccessPage extends StatelessWidget {
  final Command currentCommand;
  const PaymentSuccessPage({Key? key, required this.currentCommand})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticationController = Get.find();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: GetBuilder(
          init: CommandController(),
          builder: (cartController) {
            return Container(
              color: Colors.white, // Background color for the entire page
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 150,
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'Payment Successful!',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Merriweather',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        '${currentCommand.commandTotalPrice.toStringAsFixed(2)} dt',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Has been paid to your command',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontFamily: 'Merriweather',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Ref: ${currentCommand.reference}',
                        style: TextStyle(
                          fontFamily: 'Merriweather',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        '${currentCommand.commandDate}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontFamily: 'Merriweather',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: 340,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => MainScreen(),
                              ),
                            ); // Dismiss action
                          },
                          child: const Text(
                            "Dismiss",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Merriweather',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

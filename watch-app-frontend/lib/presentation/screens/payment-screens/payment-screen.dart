import 'dart:math';

import 'package:clean_arch/domain/enteties/command.dart';
import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/controller/cart_controller.dart';
import 'package:clean_arch/presentation/controller/command_controller.dart';
import 'package:clean_arch/presentation/screens/payment-screens/payment-success-screen.dart';
import 'package:clean_arch/presentation/widgets/headers/Payment-header.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PaymentMethodScreen extends StatefulWidget {
  final double totalPrice;

  const PaymentMethodScreen({super.key, required this.totalPrice});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? selectedPayment = ''; // Variable to hold the selected payment method

  String generateReference() {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    String randomPart =
        List.generate(8, (index) => chars[random.nextInt(chars.length)]).join();
    return 'lw$randomPart';
  }

  @override
  Widget build(BuildContext context) {
    // Assuming fixed delivery fee and discount values
    double deliveryFee = 10.0;
    double discountPercentage = Random().nextDouble() * 20;
    double discount = (widget.totalPrice * discountPercentage) / 100;
    double finalTotal = widget.totalPrice + deliveryFee - discount;
    String ref = generateReference();
    DateTime commandDate = DateTime.now();

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              PaymentHeader(title: 'Payment Method'),
              Expanded(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Credit Card',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            leading: Image.network(
                                'http://192.168.1.13:8000/uploads/images/paiment/mastercard.png',
                                width: 30),
                            title: const Text('MasterCard'),
                            subtitle: const Text('**** 1234'),
                            trailing: Radio<String>(
                              value: 'MasterCard',
                              groupValue: selectedPayment,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedPayment = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            leading: Image.network(
                                'http://192.168.1.13:8000/uploads/images/paiment/visa.png',
                                width: 30),
                            title: const Text('Visa'),
                            subtitle: const Text('**** 5678'),
                            trailing: Radio<String>(
                              value: 'Visa',
                              groupValue: selectedPayment,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedPayment = value;
                                });
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Center(
                              child: Text(
                                '+ Add other card',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          const Divider(),
                          const Text(
                            'Bank Account',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            leading: Image.network(
                                'http://192.168.1.13:8000/uploads/images/paiment/bank.png',
                                width: 30),
                            title: const Text('Al Tijari Bank'),
                            subtitle: const Text('IBAN: ****5678'),
                            trailing: Radio<String>(
                              value: 'Bank',
                              groupValue: selectedPayment,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedPayment = value;
                                });
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Center(
                              child: Text(
                                '+ Add Bank',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Subtotal:',
                                  style: TextStyle(fontSize: 16)),
                              Text('${widget.totalPrice.toStringAsFixed(2)} Dt',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Delivery Fee:',
                                  style: TextStyle(fontSize: 16)),
                              Text('${deliveryFee.toStringAsFixed(2)} Dt',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Discount:',
                                  style: TextStyle(fontSize: 16)),
                              Text(
                                  '-${discount.toStringAsFixed(2)} Dt  (${discountPercentage.toInt()}%)',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total:',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${finalTotal.toStringAsFixed(2)} Dt',
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: GetBuilder(
                                init: CommandController(),
                                builder: (commandController) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (selectedPayment == null ||
                                          selectedPayment!.isEmpty) {
                                        Fluttertoast.showToast(
                                          msg: "Please select a payment method",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP,
                                          backgroundColor: Color(0xFFAF6767),
                                          textColor: Colors.white,
                                        );
                                        return;
                                      }

                                      final AuthenticationController
                                          authenticationController = Get.find();

                                      final CartController cartController =
                                          Get.find();

                                      print(
                                          "object 11 : ${cartController.getCartSalesId}");

                                      final newCommand = Command(
                                          adresse: authenticationController
                                              .currentUser.adresse,
                                          reference: ref,
                                          commandTotalPrice: finalTotal,
                                          commandDate: commandDate,
                                          commandStatus: "paid",
                                          userId: authenticationController
                                              .currentUser.id!,
                                          sales: cartController.getCartSalesId);

                                      final res = await commandController
                                          .createCommand(newCommand);

                                      await cartController.clearCart();

                                      print(res);

                                      if (res != null) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (_) => PaymentSuccessPage(
                                              currentCommand: res,
                                            ),
                                          ),
                                        );
                                      } else {
                                        print("leftttt");
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(16),
                                      backgroundColor: Color(0xFFAF6767),
                                    ),
                                    child: const Text(
                                      'Pay Now',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'Merriweather',
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
              )
            ],
          )
        ],
      ),
    );
  }
}

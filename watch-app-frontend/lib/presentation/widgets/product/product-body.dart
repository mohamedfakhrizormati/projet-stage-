import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/controller/cart_controller.dart';
import 'package:clean_arch/presentation/screens/cart-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchBody extends StatelessWidget {
  final Watch watch; // Specify the type for `watch`

  const WatchBody({Key? key, required this.watch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.8,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Watch image
            Container(
              width: 215,
              height: 269,
              decoration: const BoxDecoration(shape: BoxShape.rectangle),
              child: Image.network(watch.image),
            ),
            const SizedBox(height: 10), // Adjusted spacing
            // Text description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                watch.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Merriweather',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.star, color: Colors.amber, size: 24),
                Icon(Icons.star, color: Colors.amber, size: 24),
                Icon(Icons.star, color: Colors.amber, size: 24),
                Icon(Icons.star, color: Colors.amber, size: 24),
                Icon(Icons.star_half, color: Colors.amber, size: 24),
              ],
            ),
            const SizedBox(height: 20),
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                watch.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF9F9F9F),
                  fontFamily: 'Merriweather',
                ),
              ),
            ),
            const SizedBox(height: 35),
            // Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: Text(
                '${watch.price.toString()} DT',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAF6767),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 60),
            // Add to Cart Button
            Container(
              width: 340,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFAF6767),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GetBuilder(
                init: CartController(),
                builder: (cartController) {
                  return TextButton(
                    onPressed: () async {
                      final AuthenticationController authController = Get.find();
        
                      final newSale = Sales(
                          quantity: 1,
                          totalPrice: watch.price,
                          userId: authController.currentUser.id!,
                          watchId: watch.id);
        
                      await cartController.addSale(newSale);
        
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CartPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Add To Cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Merriweather',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

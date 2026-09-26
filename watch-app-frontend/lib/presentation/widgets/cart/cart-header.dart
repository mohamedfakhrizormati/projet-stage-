import 'package:clean_arch/core/utils/string_const.dart';
import 'package:clean_arch/presentation/controller/watch_controller.dart';
import 'package:clean_arch/presentation/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CartHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onMenuPressed; // Callback for menu button (optional)

  const CartHeader({Key? key, required this.title, this.onMenuPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return GetBuilder<WatchController>(builder: (pc) {
      return Container(
        height: height * 0.2,
        decoration: const BoxDecoration(
          color: Colors.white, // Changed to blue for better text visibility
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
              ),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Merriweather',
                    ),
                  ),
                ),
              ),
              GetBuilder(
                  init: WishlistController(),
                  // id: ControllerID.LIKE_PRODUCT,
                  builder: (wishListController) {
                    return IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        await wishListController
                            .toggleLikedTexture(pc.selectedWatch!);
                      },
                      icon: IconButton(
                        onPressed: () async {
                          await wishListController
                              .toggleLikedTexture(pc.currentProduct);
                        },
                        icon: Icon(pc.currentProduct != null &&
                                wishListController
                                    .likedProduct(pc.currentProduct.id)
                            ? Icons.favorite
                            : Icons.favorite_border_outlined),
                        color: pc.currentProduct != null &&
                                wishListController
                                    .likedProduct(pc.currentProduct.id)
                            ? Colors.red
                            : null,
                      ),
                    );
                  }),
            ],
          ),
        ),
      );
    });
  }
}

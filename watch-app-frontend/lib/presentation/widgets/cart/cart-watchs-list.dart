import 'package:clean_arch/core/utils/string_const.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/enteties/variant.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/presentation/controller/cart_controller.dart';
import 'package:clean_arch/presentation/controller/variant_controller.dart';
import 'package:clean_arch/presentation/controller/watch_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartWatchList extends StatefulWidget {
  final Sales sales;
  // final Function onUpdate; // Add a callback

  const CartWatchList({
    Key? key,
    required this.sales,
    required void Function() onUpdate,
    /* required this.onUpdate*/
  }) : super(key: key);

  @override
  State<CartWatchList> createState() => _CartWatchListState();
}

class _CartWatchListState extends State<CartWatchList> {
  final WatchController watchController = Get.find();
  // final VariantController variantController = Get.find();
  int quantity = 0;
  late double totalPrice;

  @override
  void initState() {
    quantity = widget.sales.quantity;
    totalPrice = widget.sales.totalPrice * widget.sales.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final watchId = widget.sales.watchId;

    return GetBuilder(
        id: ControllerID.SALE_QUANTITY,
        init: CartController(),
        builder: (cartController) {
          return FutureBuilder(
            future: watchController.getWatchById(watchId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // final watch = watchController.allWatchs
                //     .firstWhere((element) => element.id == watchId);

                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Watch Image
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                          image: snapshot.data!.image != null
                              ? DecorationImage(
                                  image: NetworkImage(snapshot.data!.image),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: snapshot.data!.image == null
                            ? const Icon(Icons.image, color: Colors.grey)
                            : null,
                      ),
                      const SizedBox(width: 16),
                      // Watch Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.name ?? 'Product Name',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              snapshot.data!.reference ?? 'Product Reference',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  '${widget.sales.totalPrice} dt',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFAF6767),
                                  ),
                                ),
                                const Spacer(),
                                // Quantity Selector
                                IconButton(
                                  onPressed: () {
                                    cartController.decrimentSaleQuantity(
                                        widget.sales.id!);
                                    // if (quantity > 1) {
                                    //   quantity--;
                                    //   totalPrice =
                                    //       widget.sales.totalprice * quantity;
                                    //   // widget.onUpdate();
                                    // }
                                  },
                                  icon: const Icon(Icons.remove, size: 18),
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                ),
                                Text(
                                  '${widget.sales.quantity}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  onPressed: () {
                                    cartController.incrementSaleQuantity(
                                        widget.sales.id!);
                                    // quantity++;
                                    // totalPrice = widget.sales.totalprice * quantity;
                                    // widget.onUpdate();
                                  },
                                  icon: const Icon(Icons.add, size: 18),
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text('Error loading product details'));
              } else {
                return const Center(child: Text('No details found'));
              }
            },
          );
        });
  }

  // Future<Map<String, dynamic>> _getVariantAndWatchDetails(
  //     String variantId) async {
  //   try {
  //     // Fetch Variant
  //     final variant = await variantController.getVariantById(variantId);

  //     // Fetch Watch using watchId from Variant
  //     final watch = await watchController.getWatchById(variant.watchId);

  //     return {'variant': variant, 'watch': watch};
  //   } catch (e) {
  //     debugPrint('Error fetching details: $e');
  //     throw e;
  //   }
  // }
}

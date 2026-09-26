import 'package:clean_arch/domain/enteties/variant.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/presentation/controller/variant_controller.dart';
import 'package:clean_arch/presentation/controller/watch_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistItem extends StatefulWidget {
  final Watch watch;

  const WishlistItem({Key? key, required this.watch}) : super(key: key);

  @override
  State<WishlistItem> createState() => _WishlistItemState();
}

class _WishlistItemState extends State<WishlistItem> {
  final WatchController watchController = Get.find();
  // final VariantController variantController = Get.find();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: watchController.getWatchById(widget.watch.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading product details'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No details found'));
          }
          // final data = snapshot.data!;
          // final watch = watchController.allWatchs
          //     .firstWhere((element) => element.id == widget.variant.watchId);
          return Card(
            color: Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                        child: Image.network(
                          widget.watch.image,
                          fit: BoxFit.fitHeight,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 1),
                      child: Text(
                        widget.watch.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.watch.reference,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 145, 145, 145),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '${widget.watch.price}\ Dt',
                        style: const TextStyle(
                          color: Color(0xFFAF6767),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
              ],
            ),
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

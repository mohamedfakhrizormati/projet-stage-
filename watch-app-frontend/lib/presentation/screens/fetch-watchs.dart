import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/presentation/controller/watch_controller.dart';
import 'package:clean_arch/presentation/screens/watch-screen.dart';
import 'package:clean_arch/presentation/widgets/product/product_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Fetchwatchs extends StatelessWidget {
  final int itemCount;
  final Future<List<Watch>> futureFunction;
  const Fetchwatchs({
    super.key,
    required this.itemCount,
    required this.futureFunction,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: WatchController(),
      builder: (watchController) {
        return FutureBuilder(
          future: futureFunction,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                shrinkWrap: true, // Ensures it takes up only needed space
                physics:
                    const NeverScrollableScrollPhysics(), // Prevents independent scrolling
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 3,
                ),
                itemCount: (snapshot.data as List).length > itemCount
                    ? itemCount
                    : (snapshot.data as List).length, // Use the safe item count
                itemBuilder: (context, int index) {
                  return InkWell(
                    onTap: () {
                      watchController.setProductId =
                          (snapshot.data as List)[index].id;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const WatchPage(),
                        ),
                      );
                    },
                    child: WatchItem(
                      watch: (snapshot.data as List)[index],
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading items'),
              );
            } else {
              return const Center(
                child: Text('No items available'),
              );
            }

            // Ensure itemCount does not exceed the actual list length
          },
        );
      },
    );
  }
}

import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/presentation/controller/watch_controller.dart';
import 'package:clean_arch/presentation/screens/watch-screen.dart';
import 'package:clean_arch/presentation/widgets/product/product_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchesGridWidget extends StatelessWidget {
  final int itemCount;
  final Future<List<Watch>> futureWatches;

  const WatchesGridWidget({
    Key? key,
    required this.itemCount,
    required this.futureWatches,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<WatchController>(
        init: WatchController(),
        builder: (watchController) {
          return FutureBuilder(
            future: futureWatches,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error loading watches'),
                );
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: Text('No watches available'),
                );
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 3,
                ),
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      print(watchController.watchsList[index].id);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WatchPage(),
                        ),
                      );
                    },
                    child: WatchItem(
                      watch: watchController.watchsList[index],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

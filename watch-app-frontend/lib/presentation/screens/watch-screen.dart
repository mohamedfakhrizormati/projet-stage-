import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/presentation/controller/watch_controller.dart';
import 'package:clean_arch/presentation/widgets/cart/cart-header.dart';
import 'package:clean_arch/presentation/widgets/product/product-body.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class WatchPage extends StatelessWidget {
  const WatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<WatchController>(builder: (watchController) {
        return FutureBuilder(
            future:
                watchController.getWatchById(watchController.currentProductid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  CartHeader(title: 'Watch Page'),
                  Expanded(
                    child: Builder(builder: (context) {
                      return Container(
                        color: Colors.white,
                        child: WatchBody(watch: snapshot.data!),
                      );
                    }),
                  )
                ]);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: Text('Error loading watchs'),
                );
              }
            });
      }),
    );
  }
}

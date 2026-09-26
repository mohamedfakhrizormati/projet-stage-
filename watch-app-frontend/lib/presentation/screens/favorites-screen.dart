import 'package:clean_arch/data/models/wishlist_model.dart';
import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/controller/watch_controller.dart';
import 'package:clean_arch/presentation/controller/wishlist_controller.dart';
import 'package:clean_arch/presentation/screens/watch-screen.dart';
import 'package:clean_arch/presentation/widgets/drawer-contents.dart';
import 'package:clean_arch/presentation/widgets/headers/header.dart';
import 'package:clean_arch/presentation/widgets/product/product_item.dart';
import 'package:clean_arch/presentation/widgets/wishList-Item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AuthenticationController authenticationController = Get.find();
  final WatchController watchController = Get.find();
  final WishlistController wishlistController = Get.find();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      drawer: Drawer(
        child: DrawerContents(),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Header(
                title: 'Favorites',
                onMenuPressed: () {
                  _scaffoldKey.currentState?.openDrawer(); // Open the drawer
                },
              ),
              Expanded(
                child: SingleChildScrollView(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Aligns text to the left
                          children: [
                            // Centered Title and Subheading
                            Center(
                              child: Column(
                                children: [
                                  const Text(
                                    "Your Favorites Watches",
                                    style: TextStyle(
                                      fontFamily: 'Merriweather',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          8), // Space between title and subheading
                                  const Text(
                                    "Find the perfect watch to match your style",
                                    style: TextStyle(
                                      fontFamily: 'Merriweather',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF9F9F9F), // Gray color
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20), // Space before grid

                            // Constrain GridView to avoid layout conflict

                            Expanded(
                              child: GetBuilder<WishlistController>(
                                init: WishlistController(),
                                builder: (controller) {
                                  return FutureBuilder(
                                    future: controller.getWishList(
                                        wishlistController.currentWishlist.id),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        // final wishlist =
                                        //     snapshot.data as WishlistModel;
                                        return GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 16,
                                            mainAxisSpacing: 16,
                                            childAspectRatio: 3 / 3,
                                          ),
                                          // itemCount: wishlist.watchs.length,
                                          itemCount: wishlistController
                                              .wishlistModel.length,

                                          itemBuilder: (context, int index) {
                                            // final watchId =
                                            //     wishlist.watchs[index];
                                            // final watch = watchController
                                            //     .getWatchById(watchId);
                                            return InkWell(
                                              onTap: () {
                                                watchController.setProductId =
                                                    wishlistController
                                                        .wishlistModel[index]
                                                        .id;
                                                print(watchController
                                                    .allWatchs.length);
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (_) => WatchPage(),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                  minWidth: 100,
                                                  minHeight:
                                                      100, // Ensure minimum size constraints
                                                ),
                                                child: WishlistItem(
                                                    // watch: watch,
                                                    watch: wishlistController
                                                        .wishlistModel[index]),
                                              ),
                                            );
                                          },
                                        );
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        );
                                      } else if (snapshot.hasError) {
                                        return const Center(
                                          child: Text('Error loading watches'),
                                        );
                                      } else {
                                        return const Center(
                                          child: Text('Wishlist is empty'),
                                        );
                                      }
                                    },
                                  );
                                },
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
          ),
        ],
      ),
    );
  }
}

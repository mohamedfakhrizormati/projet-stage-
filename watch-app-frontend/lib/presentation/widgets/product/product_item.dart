// import 'package:clean_arch/domain/enteties/watch.dart';
// import 'package:flutter/material.dart';

// class WatchItem extends StatelessWidget {
//   final watch;

//   const WatchItem({Key? key, required this.watch}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.grey[200],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       elevation: 5,
//       child: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: ClipRRect(
//                   borderRadius:
//                       const BorderRadius.vertical(top: Radius.circular(10)),
//                   child: Image.network(
//                     watch.image,
//                     fit: BoxFit.fitHeight,
//                     width: double.infinity,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
//                 child: Text(
//                   watch.name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Text(
//                   watch.brand,
//                   style: const TextStyle(
//                     color: Color.fromARGB(255, 145, 145, 145),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 1),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Text(
//                   '${watch.price}\ Dt',
//                   style: const TextStyle(
//                     color: Color(0xFFAF6767),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//             ],
//           ),
//           Positioned(
//             top: 8,
//             right: 8,
//             child: Icon(
//               Icons.favorite,
//               color: Colors.red,
//               size: 24,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:clean_arch/domain/enteties/variant.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class WatchItem extends StatefulWidget {
  final watch;

  const WatchItem({Key? key, required this.watch}) : super(key: key);

  @override
  State<WatchItem> createState() => _WatchItemState();
}

class _WatchItemState extends State<WatchItem> {
  late bool isWishlist;

  @override
  void initState() {
    isWishlist = false;
    _checkWishlist();
    super.initState();
  }

  void _checkWishlist() {
    final WishlistController wishlistController = Get.find();
    final AuthenticationController authenticationController = Get.find();

    final String? currentUserId = authenticationController.currentUser.id;
    final String? wishListId = wishlistController.currentWishlist.id;
    print("current wishlist id: ${wishListId ?? 'No ID available'}");

    if (wishListId != null) {
      wishlistController.getWishList(currentUserId!).then((e) {
        if (e != null) {
          setState(() {
            isWishlist = wishlistController.currentWishlist.watchs
                .contains(widget.watch.id);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final WishlistController wishlistController = Get.find();
    final AuthenticationController authenticationController = Get.find();

    final String? currentUserId = authenticationController.currentUser.id;
    final String? wishListId = wishlistController.currentWishlist.id;
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
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    widget.watch.image,
                    fit: BoxFit.fitHeight,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
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
                  widget.watch.brand,
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
        ],
      ),
    );
  }
}

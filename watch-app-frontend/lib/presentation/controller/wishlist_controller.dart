import 'package:clean_arch/core/utils/string_const.dart';
import 'package:clean_arch/di.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/domain/enteties/wishlist.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_watch_by_id_usecase.dart';
import 'package:clean_arch/domain/usecases/wishlist_usecases/create_wishlist_usecase.dart';
import 'package:clean_arch/domain/usecases/wishlist_usecases/get_wishlist_usecase.dart';
import 'package:clean_arch/domain/usecases/wishlist_usecases/update_wishlist_usecase.dart';

import 'package:get/get.dart';

class WishlistController extends GetxController {
  late Wishlist currentWishlist;
  List<Watch> wishlistModel = [];

  Future<Wishlist> getWishList(String userId) async {
    final res = await GetWishlistUsecase(sl())(wishlistId: userId);
    res.fold((l) => null, (r) => currentWishlist = r);
    await getWishlistTextures();
    return currentWishlist;
  }

  Future<void> addUserWishlist(String userId) async {
    await CreateWishListUsecase(sl())(userId: userId);
  }

  Future<void> updateUserWishlist(Wishlist newWishList) async {
    await UpdateWishListUsecase(sl())(wishlist: newWishList);
  }

  Future<List<Watch>> getWishlistTextures() async {
    wishlistModel = [];
    for (var element in currentWishlist.watchs) {
      final res = await GetWatchByIdUsecase(sl())(wID: element);
      print("Result for element $element: $res");
      res.fold((l) => null, (r) => wishlistModel.add(r));
    }
    return wishlistModel;
  }

  bool likedProduct(String textureId) {
    return getWishlistIds.contains(textureId);
  }

  List<String> get getWishlistIds => wishlistModel.map((e) => e.id).toList();

  Future toggleLikedTexture(Watch texture) async {
    print("wishlist  ${texture.id}");
    print("wishlist ${wishlistModel.toString()}");
    if (wishlistModel.contains(texture)) {
      wishlistModel.remove(texture);
      print("removed");
    } else {
      wishlistModel.add(texture);
      print("added");
    }
    currentWishlist.watchs = getWishlistIds;
    await updateUserWishlist(currentWishlist);
    print("wishlist");
    update(/*[ControllerID.LIKE_PRODUCT]*/);
  }
}

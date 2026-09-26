import 'package:clean_arch/di.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_all_watchs_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_sorted_watchs_by_cat_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_sorted_watchs_by_creation_date_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_sorted_watchs_by_sales_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_watch_by_category_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_watch_by_id_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchController extends GetxController {
  List<Watch> allWatchs = [];
  List<Watch> allWatchsByCat = [];
  List<Watch> watchsList = [];
  List<Watch> watchsByCatList = [];
  List<Watch> sortedWatchs = [];
  List<Watch> filtredWatchs = [];
  String? selectedCategory = 'all'; // Default to "All"

  // late Variant selectedModel3d;

  // List<Variant> productColors = [];
  Watch? selectedWatch;
  String currentProductid = "";
  int quantity = 1;
  UniqueKey textureKey = UniqueKey();
  late Watch currentProduct;

  set setProductId(String id) => currentProductid = id;

  Future<bool> getAllWatchs() async {
    if (allWatchs.isNotEmpty) return true;

    final res = await GetAllWatchsUsecase(sl())();
    res.fold((l) => null, (r) {
      watchsList = r;
      filtredWatchs = r;

      return allWatchs = r;
    });
    return true;
  }

  Future<Watch> getWatchById(String wId) async {
    final res = await GetWatchByIdUsecase(sl())(wID: wId);
    res.fold((l) => null, (r) => currentProduct = r);

    return currentProduct;
  }

  Future<bool> getWatchByCategory(String cId) async {
    final res = await GetWatchByCategoryUsecase(sl())(wcat: cId);
    res.fold((l) => null, (r) {
      watchsByCatList = r;
      return allWatchsByCat = r;
    });
    return true;
  }

  Future<List<Watch>> getSortedWatchsByCat() async {
    if (sortedWatchs.isEmpty) {
      final res = await GetSortedWatchsByCatUsecase(sl())();
      res.fold((l) => null, (r) => sortedWatchs = r);
    }
    return sortedWatchs;
  }

  Future<List<Watch>> getSortedWatchsBySales() async {
    if (sortedWatchs.isEmpty) {
      final res = await GetSortedWatchsBySalesUsecase(sl())();
      res.fold((l) => null, (r) => sortedWatchs = r);
    }
    return sortedWatchs;
  }

  Future<List<Watch>> getSortedWatchsByCreationDate() async {
    if (sortedWatchs.isEmpty) {
      final res = await GetSortedWatchsByCreationDateUsecase(sl())();
      res.fold((l) => null, (r) => sortedWatchs = r);
    }
    return sortedWatchs;
  }

  // Filter products based on selected category
  void filterWatchs(String? categoryId) {
    print("Filtering watchs for category: $categoryId");
    if (categoryId == 'all' || categoryId == null) {
      filtredWatchs = allWatchs;
    } else {
      filtredWatchs = allWatchs
          .where((watch) => watch.category == categoryId)
          .toList(); // Filter by category
      print("Filtered watchs count: ${filtredWatchs.length}");
    }

    selectedCategory = categoryId;

    update();
  }

  void filterProducts(String word) {
    List<Watch> prd = allWatchs;
    filtredWatchs = prd
        .where((element) =>
            (element.name.toUpperCase().contains(word.toUpperCase())))
        .toList();
    update();
  }

  double getPrice(Watch product) {
    return product.price;
  }

  // void selectTexture(Variant new3DProduct) {
  //   //WishListController wishlist = Get.find();
  //   selectedModel3d = new3DProduct;
  //   textureKey = UniqueKey();
  //   quantity = 1;
  //   // wishlist.likedProduct(new3DProduct.id);
  //   update([ControllerID.PRODUCT_TEXTURE]);
  // }
}

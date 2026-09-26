import 'package:clean_arch/core/utils/string_const.dart';
import 'package:clean_arch/di.dart';
import 'package:clean_arch/domain/enteties/cart.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/domain/usecases/cart_usecases/create_cart_usecase.dart';
import 'package:clean_arch/domain/usecases/cart_usecases/get_cart_by_id_usecase.dart';
import 'package:clean_arch/domain/usecases/cart_usecases/update_cart_usecase.dart';
import 'package:clean_arch/domain/usecases/sales_usecases/add_sales_usecase.dart';
import 'package:clean_arch/domain/usecases/sales_usecases/delete_sales_usecase.dart';
import 'package:clean_arch/domain/usecases/sales_usecases/get_sales_by_id_usecase.dart';
import 'package:clean_arch/domain/usecases/sales_usecases/update_sales_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_watch_by_id_usecase.dart';
import 'package:clean_arch/presentation/controller/watch_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CartController extends GetxController {
  late Cart currentCart;
  List<Sales> cartSales = [];
  List<Watch> cartProducts = [];
  double totalPrice = 0.0;

  Future<Cart> getUserCart(String userId) async {
    cartSales = [];
    cartProducts = [];
    final res = await GetCartByIdUsecase(sl())(userId: userId);
    res.fold((l) => null, (r) => currentCart = r);
    await getCartSales();
    print('all sales $cartSales');
    await getCartProducts();
    getReclamationPrice();
    return currentCart;
  }

  Future<bool> aaa() async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }

  Future<void> getCartProducts() async {
    print("cart $cartSales 0");
    for (var element in cartSales) {
      final res = await GetWatchByIdUsecase(sl())(wID: element.watchId);
      res.fold((l) => null, (r) => cartProducts.add(r));
    }
  }

  Future<void> incrementSaleQuantity(String saleId) async {
    final WatchController watchController = Get.find();
    final Sales sale = cartSales.firstWhere((element) => element.id == saleId);
    if (sale.quantity <
        cartProducts
            .firstWhere((element) => sale.watchId == element.id)
            .quantity) {
      sale.quantity++;
      sale.totalPrice = double.parse((watchController.getPrice(watchController
                  .allWatchs
                  .firstWhere((element) => element.id == sale.watchId)) *
              sale.quantity)
          .toStringAsFixed(2));
      await UpdateSalesUsecase(sl())(sale);
    }
    getReclamationPrice();
    update([ControllerID.SALE_QUANTITY]);
  }

  Future<void> decrimentSaleQuantity(String saleId) async {
    final WatchController watchController = Get.find();

    final Sales sale = cartSales.firstWhere((element) => element.id == saleId);
    if (sale.quantity > 1) {
      sale.quantity--;
      sale.totalPrice = double.parse((watchController.getPrice(watchController
                  .allWatchs
                  .firstWhere((element) => element.id == sale.watchId)) *
              sale.quantity)
          .toStringAsFixed(2));
      await UpdateSalesUsecase(sl())(sale);
    }
    getReclamationPrice();

    update([ControllerID.SALE_QUANTITY]);
  }

  Future<void> addUserCart(String userId) async {
    await CreateCartUsecase(sl())(userId: userId);
  }

  Future<void> updateUserCart(Cart newCart) async {
    await UpdateCartUsecase(sl())(cart: newCart);
  }

  Future<List<Sales>> getCartSales() async {
    cartSales = [];
    print("sale before $cartSales 1");
    print("products before ${currentCart.sales}");

    for (var element in currentCart.sales) {
      final res = await GetSalesByIdUsecase(sl())(element);
      res.fold((l) => null, (r) {
        cartSales.add(r);
      });
      print("sale after $cartSales 2");
    }

    return cartSales;
  }

  List<String> get getCartSalesId => cartSales.map((e) => e.id!).toList();
  List<String> get getCartmodelId => cartSales.map((e) => e.watchId).toList();

  Future addSale(Sales newSale) async {
    if (!getCartmodelId.contains(newSale.watchId)) {
      final addsale = await AddSaleUsecase(sl()).call(newSale);
      addsale.fold((l) => print(l), (r) async {
        print("rayen  $cartSales rayen");

        cartSales.add(r);
      });
    } else {
      Fluttertoast.showToast(
          msg: 'product already in cart!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    await _updateSailes();
    await getUserCart(newSale.userId);
    update();
  }

  void getReclamationPrice() {
    double sum = 0.0;
    for (var sale in cartSales) {
      sum += sale.totalPrice;
    }
    totalPrice = sum;
  }

  Future _updateSailes() async {
    currentCart.sales = getCartSalesId;
    print('update cart ${currentCart.sales} 4');
    final rs = await UpdateCartUsecase(sl()).call(cart: currentCart);
    rs.fold((l) => null, (r) async {});
    update();
  }

  Future deleteSale(String saleId) async {
    await DeleteSalesUsecase(sl()).call(saleId);
    cartSales.removeWhere((element) => element.id == saleId);
    currentCart.sales = getCartSalesId;
    await _updateSailes();
    await getUserCart(currentCart.userId);
    update();
  }

  Future clearCart() async {
    cartSales = [];
    await _updateSailes();
  }
}

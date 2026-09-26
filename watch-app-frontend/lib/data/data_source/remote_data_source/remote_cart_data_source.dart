import 'dart:convert';

import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/utils/api_const.dart';
import 'package:clean_arch/data/data_source/local_data_source/authentication_local_data_source.dart';
import 'package:clean_arch/data/data_source/local_data_source/settings_local_data_source.dart';
import 'package:clean_arch/data/models/cart_model.dart';
import 'package:clean_arch/data/models/sales_model.dart';
import 'package:clean_arch/data/models/token_model.dart';
import 'package:clean_arch/domain/enteties/cart.dart';
import 'package:http/http.dart' as http;

abstract class CartRemoteDataSource {
  Future<void> createCart({required String userId});
  Future<void> updateCart({required CartModel cart});
  // Future<void> updateCart(String cartId, List<String> sales);
  Future<CartModel> getCart({required String userId});
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  Future<TokenModel?> get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }

  Future<String> get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }

  @override
  Future<void> createCart({required String userId}) async {
    try {
      final url = Uri.parse(ApiConst.addCart);
      final body = {'userId': userId};

      final res = await http.post(
        url,
        body: body,
      );
      if (res.statusCode != 201) {
        throw ServerException(message: "Failed to create cart");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CartModel> getCart({required String userId}) async {
    try {
      final url = Uri.parse('${ApiConst.getOneCart}/$userId');
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        return CartModel.fromJson(body);
      } else if (res.statusCode == 404) {
        throw CartNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateCart({required CartModel cart}) async {
    try {
      String authToken = await token.then((value) => value!.token);
      final url = Uri.parse("${ApiConst.updateCart}/${cart.id}");
      final body = jsonEncode({"id": cart.id, "sales": cart.sales});
      final res = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: body,
      );
      if (res.statusCode != 200) {
        throw ServerException(message: "Failed to update cart");
      }
    } catch (e) {
      print("cart error ${e.toString()}");
      rethrow;
    }
  }
  // @override
  // Future<void> updateCart(String cartId, List<String> sales) async {
  //   try {
  //     String authToken = await token.then((value) => value.token);
  //     final url = Uri.parse("${ApiConst.updateCart}/$cartId");
  //     final body = jsonEncode({
  //       "sales": sales.map((sale) => (sale as SalesModel).tojson()).toList(),
  //     });
  //     final res = await http.put(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $authToken',
  //       },
  //       body: body,
  //     );
  //     if (res.statusCode != 200) {
  //       throw ServerException(message: "Failed to update cart");
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}

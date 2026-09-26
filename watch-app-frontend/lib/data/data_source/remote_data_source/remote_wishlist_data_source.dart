import 'dart:convert';

import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/utils/api_const.dart';
import 'package:clean_arch/data/data_source/local_data_source/authentication_local_data_source.dart';
import 'package:clean_arch/data/data_source/local_data_source/settings_local_data_source.dart';
import 'package:clean_arch/data/models/token_model.dart';
import 'package:clean_arch/data/models/wishlist_model.dart';
import 'package:http/http.dart' as http;

abstract class WishlistRemoteDataSource {
  Future<WishlistModel> getWishList({required String wishlistId});
  Future<void> createWishList({required String userId});
  Future<void> updateWishlist({required WishlistModel wishlist});
  Future<void> deleteWishlist({required String wishlistId});
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  Future<TokenModel?> get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }

  Future<String> get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }

  @override
  Future<void> createWishList({required String userId}) async {
    try {
      final url = Uri.parse(ApiConst.createWishList);
      final body = {"userId": userId};
      final res = await http.post(
        url,
        body: body,
      );
      if (res.statusCode != 201) {
        throw ServerException(message: "Failed to create wishlist");
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteWishlist({required String wishlistId}) async {
    try {
      String authToken = await token.then((value) => value!.token);
      final url = Uri.parse('${ApiConst.deleteWishList}/$wishlistId');
      final res = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      if (res.statusCode != 200) {
        throw ServerException(message: "Failed to delete wishlist");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WishlistModel> getWishList({required String wishlistId}) async {
    try {
      final uri = Uri.parse('${ApiConst.getOneWishList}/$wishlistId');
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        return WishlistModel.fromJson(body);
      } else if (res.statusCode == 404) {
        throw WishlistNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateWishlist({required WishlistModel wishlist}) async {
    try {
      final authToken = await token.then((value) => value!.token);

      final url = Uri.parse("${ApiConst.updateWishList}/${wishlist.id}");
      final body = jsonEncode({
        "watches": wishlist.watchs,
      });
      final res = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: body,
      );
      if (res.statusCode != 200) {
        throw ServerException(message: "Failed to update wishlist");
      }
    } catch (e) {
      rethrow;
    }
  }
}

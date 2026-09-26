import 'dart:convert';

import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/utils/api_const.dart';
import 'package:clean_arch/data/data_source/local_data_source/authentication_local_data_source.dart';
import 'package:clean_arch/data/models/token_model.dart';
import 'package:clean_arch/data/models/watch_model.dart';
import 'package:http/http.dart' as http;

abstract class WatchRemoteDataSource {
  Future<List<WatchModel>> getAllWatchs();
  Future<WatchModel> getWatch(String wID);
  Future<List<WatchModel>> getWatchsByCat(String wCat);
  Future<List<WatchModel>> getSortedWatchsByCat();
  Future<List<WatchModel>> getSortedWatchsBySales();
  Future<List<WatchModel>> getSortedWatchsByCreationDate();
}

class WatchRemoteDataSourceImpl implements WatchRemoteDataSource {
  Future<TokenModel?> get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }

  @override
  Future<WatchModel> getWatch(String wID) async {
    try {
      final uri = Uri.parse('${ApiConst.getOnewatch}/$wID');
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        print(body.toString());
        return WatchModel.fromJson(body);
      } else if (res.statusCode == 404) {
        throw WatchNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<WatchModel>> getAllWatchs() async {
    try {
      final uri = Uri.parse(ApiConst.getAllWatchs);
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        List<dynamic> body = json.decode(res.body);
        print(body.toString());
        return body.map((e) => WatchModel.fromJson(e)).toList();
      } else if (res.statusCode == 404) {
        throw WatchNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<WatchModel>> getWatchsByCat(String wCat) async {
    try {
      final uri = Uri.parse('${ApiConst.getWatchsByCat}/$wCat');
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        List<dynamic> body = json.decode(res.body);
        return body.map((e) => WatchModel.fromJson(e)).toList();
      } else if (res.statusCode == 404) {
        throw WatchNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<WatchModel>> getSortedWatchsByCat() async {
    try {
      final tokenValue = await token.then((value) => value!.token);
      final response = await http.get(
        Uri.parse(ApiConst.getSortedWatchsByCat),
        headers: {
          "Authorization": "Bearer $tokenValue",
        },
      );
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<WatchModel> watchs =
            data.map((json) => WatchModel.fromJson(json)).toList();
        return watchs;
      } else if (response.statusCode == 401) {
        throw NotAuthorizedException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (e is NotAuthorizedException || e is ServerException) {
        rethrow;
      } else {
        throw Exception('An unexpected error occurred');
      }
    }
  }

  @override
  Future<List<WatchModel>> getSortedWatchsBySales() async {
    try {
      final tokenValue = await token.then((value) => value!.token);
      final response = await http.get(
        Uri.parse(ApiConst.getSortedWatchsBySales),
        headers: {
          "Authorization": "Bearer $tokenValue",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<WatchModel> watchs =
            data.map((json) => WatchModel.fromJson(json)).toList();
        return watchs;
      } else if (response.statusCode == 401) {
        throw NotAuthorizedException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (e is NotAuthorizedException || e is ServerException) {
        rethrow;
      } else {
        throw Exception('An unexpected error occurred');
      }
    }
  }

  @override
  Future<List<WatchModel>> getSortedWatchsByCreationDate() async {
    try {
      final tokenValue = await token.then((value) => value!.token);
      final response = await http.get(
        Uri.parse(ApiConst.getSortedWatchsByCreationDate),
        headers: {
          "Authorization": "Bearer $tokenValue",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<WatchModel> watchs =
            data.map((json) => WatchModel.fromJson(json)).toList();
        return watchs;
      } else if (response.statusCode == 401) {
        throw NotAuthorizedException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (e is NotAuthorizedException || e is ServerException) {
        rethrow;
      } else {
        throw Exception('An unexpected error occurred');
      }
    }
  }
}

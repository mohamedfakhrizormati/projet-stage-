import 'dart:convert';

import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/utils/api_const.dart';
import 'package:clean_arch/data/models/category_model.dart';
import 'package:http/http.dart' as http;

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getAllCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final uri = Uri.parse(ApiConst.categories);
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        List<dynamic> body = json.decode(res.body);
        return body.map((e) => CategoryModel.fromJson(e)).toList();
      } else if (res.statusCode == 404) {
        throw CategoryNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }
}

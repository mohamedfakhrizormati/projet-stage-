import 'dart:convert';

import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/utils/api_const.dart';
import 'package:clean_arch/data/data_source/local_data_source/authentication_local_data_source.dart';
import 'package:clean_arch/data/data_source/local_data_source/settings_local_data_source.dart';
import 'package:clean_arch/data/models/sales_model.dart';
import 'package:clean_arch/data/models/token_model.dart';
import 'package:http/http.dart' as http;

abstract class SalesRemoteDataSource {
  Future<SalesModel> addSale(SalesModel newSale);

  Future<List<SalesModel>> getAllSales(String userId);

  Future<SalesModel> getSalesById(String salesId);

  Future<void> updateSales(SalesModel updateSale);

  Future<void> deleteSales(String salesId);
}

class SalesRemoteDataSourceImpl implements SalesRemoteDataSource {
  Future<TokenModel?> get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }

  Future<String> get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }

  @override
  Future<SalesModel> addSale(SalesModel newSale) async {
    try {
      final authToken = await token.then((value) => value!.token);
      final res = await http.post(
        Uri.parse(ApiConst.addSales),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(newSale.tojson()),
      );
      print("rayen ${res.body}");
      if (res.statusCode == 200 || res.statusCode == 201) {
        final data = jsonDecode(res.body);
        return SalesModel.fromJson(data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteSales(String salesId) async {
    try {
      final authToken = await token.then((value) => value!.token);
      final url = Uri.parse('${ApiConst.deleteSales}/$salesId');
      final res = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );
      if (res.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SalesModel>> getAllSales(String userId) async {
    try {
      final authToken = await token.then((value) => value!.token);
      final res = await http.get(
        Uri.parse('${ApiConst.getAllSales}/$userId'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );
      if (res.statusCode == 200) {
        List<dynamic> body = json.decode(res.body);
        return body.map((e) => SalesModel.fromJson(e)).toList();
      } else if (res.statusCode == 404) {
        throw SalesNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SalesModel> getSalesById(String salesId) async {
    try {
      final authToken = await token.then((value) => value!.token);
      final uri = Uri.parse('${ApiConst.getOneSale}/$salesId');
      final res = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        return SalesModel.fromJson(body);
      } else if (res.statusCode == 404) {
        throw SalesNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateSales(SalesModel updateSale) async {
    try {
      final authToken = await token.then((value) => value!.token);
      final url = Uri.parse("${ApiConst.updateSales}/${updateSale.id}");
      final body = jsonEncode(updateSale.tojson());
      final res = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: body,
      );
      if (res.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      print("object sale: ${e.toString()}");
      rethrow;
    }
  }
}

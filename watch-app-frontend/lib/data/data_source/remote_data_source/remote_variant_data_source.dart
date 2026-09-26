// import 'dart:convert';

// import 'package:clean_arch/core/error/exceptions/exceptions.dart';
// import 'package:clean_arch/core/utils/api_const.dart';
// import 'package:clean_arch/data/data_source/local_data_source/authentication_local_data_source.dart';
// import 'package:clean_arch/data/models/token_model.dart';
// import 'package:clean_arch/data/models/variant_model.dart';
// import 'package:clean_arch/domain/usecases/variant_usecases/get_one_variant_usecase.dart';
// import 'package:http/http.dart' as http;

// abstract class VariantRemoteDataSource {
//   Future<List<VariantModel>> getAllVariant(String watchId);

//   Future<VariantModel> getOneVariant(String variantId);
// }

// class VariantRemoteDataSourceImpl implements VariantRemoteDataSource {
//   Future<TokenModel?> get token async {
//     return await AuthenticationLocalDataSourceImpl().getUserInformations();
//   }

//   @override
//   Future<List<VariantModel>> getAllVariant(String watchId) async {
//     try {
//       final uri = Uri.parse("${ApiConst.getAllVariant}/$watchId");
//       final res = await http.get(uri);
//       if (res.statusCode == 200) {
//         List<dynamic> body = json.decode(res.body);
//         return body.map((e) => VariantModel.fromJson(e)).toList();
//       } else if (res.statusCode == 404) {
//         throw ProductNotFoundException();
//       } else {
//         throw ServerException();
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   Future<VariantModel> getOneVariant(String variantId) async {
//     try {
//       final response = await http.get(
//         Uri.parse("${ApiConst.getOneVariant}/$variantId"),
//         headers: {
//           "authorization":
//               "Bearer ${await token.then((value) => value!.token)}",
//         },
//       );
//       final data = response.body;
//       VariantModel variant = VariantModel.fromJson(jsonDecode(data));
//       return variant;
//     } catch (e) {
//       throw ServerException();
//     }
//   }
// }

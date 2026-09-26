// import 'package:clean_arch/di.dart';
// import 'package:clean_arch/domain/enteties/variant.dart';
// import 'package:clean_arch/domain/usecases/variant_usecases/get_all_variant_usecase.dart';
// import 'package:clean_arch/domain/usecases/variant_usecases/get_one_variant_usecase.dart';
// import 'package:get/get.dart';

// class VariantController extends GetxController {
//   List<Variant> allVariants = [];
//   late Variant currentVariant;

//   Future<bool> getAllVariants(String watchId) async {
//     final res = await GetAllVariantUsecase(sl())(watchId);
//     res.fold((l) => null, (r) {
//       return allVariants = r;
//     });
//     return true;
//   }

//   Future<Variant> getVariantById(String vId) async {
//     final res = await GetOneVariant(sl())(vId);
//     res.fold((l) => null, (r) => currentVariant = r);
//     return currentVariant;
//   }
// }

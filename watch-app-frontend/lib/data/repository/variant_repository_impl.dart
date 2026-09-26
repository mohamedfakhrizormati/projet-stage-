// import 'package:clean_arch/core/error/exceptions/exceptions.dart';
// import 'package:clean_arch/core/error/failures/failures.dart';
// import 'package:clean_arch/data/data_source/remote_data_source/remote_variant_data_source.dart';
// import 'package:clean_arch/domain/enteties/variant.dart';
// import 'package:clean_arch/domain/repository/variant_repository.dart';
// import 'package:clean_arch/domain/usecases/variant_usecases/get_one_variant_usecase.dart';
// import 'package:dartz/dartz.dart';

// class VariantRepositoryImpl implements VariantRepository {
//   final VariantRemoteDataSource variantRemoteDataSource;

//   VariantRepositoryImpl({required this.variantRemoteDataSource});

//   @override
//   Future<Either<Failure, List<Variant>>> getAllVariant(String watchId) async {
//     try {
//       final res = await variantRemoteDataSource.getAllVariant(watchId);
//       return right(res);
//     } on ServerException catch (_) {
//       return left(ServerFailure());
//     } on ProductNotFoundException catch (_) {
//       return left(ServerFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, Variant>> getOneVariant(String variantId) async {
//     try {
//       final variantModels =
//           await variantRemoteDataSource.getOneVariant(variantId);
//       final variant = Variant(
//           id: variantModels.id,
//           model3d: variantModels.model3d,
//           imageColor: variantModels.imageColor,
//           quantity: variantModels.quantity,
//           watchId: variantModels.watchId);
//       return right(variant);
//     } on ServerException {
//       return left(ServerFailure());
//     }
//   }
// }

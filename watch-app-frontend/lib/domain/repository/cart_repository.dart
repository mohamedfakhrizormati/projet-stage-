import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/cart.dart';
import 'package:dartz/dartz.dart';

abstract class CartRepository {
  Future<Either<Failure, Cart>> getCart({required String userId});

  Future<Either<Failure, Unit>> createCart({required String userId});

  // Future<Either<Failure, Unit>> updateCart(
  //     {required String cartId, required List<String> sales});

  Future<Either<Failure, Unit>> updateCart({required Cart cart});
}

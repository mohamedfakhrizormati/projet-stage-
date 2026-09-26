import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_cart_data_source.dart';
import 'package:clean_arch/data/models/cart_model.dart';
import 'package:clean_arch/domain/enteties/cart.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/repository/cart_repository.dart';
import 'package:dartz/dartz.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource cartRemoteDataSource;
  CartRepositoryImpl({required this.cartRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> createCart({required String userId}) async {
    try {
      await cartRemoteDataSource.createCart(userId: userId);
      return right(unit);
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Cart>> getCart({required String userId}) async {
    try {
      final result = await cartRemoteDataSource.getCart(userId: userId);
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } on DataNotFoundException catch (e) {
      return left(DataNotFoundFailure(e.message));
    }
  }

  // @override
  // Future<Either<Failure, Unit>> updateCart(
  //     {required String cartId, required List<String> sales}) async {
  //   try {
  //     CartModel cModel = CartModel(id: cartId, userId: '', sales: sales);
  //     await cartRemoteDataSource.updateCart(cart: cModel);
  //     return right(unit);
  //   } on ServerException catch (e) {
  //     return left(ServerFailure(message: e.message));
  //   }
  // }

  @override
  Future<Either<Failure, Unit>> updateCart({required Cart cart}) async {
    try {
      CartModel cModel =
          CartModel(id: cart.id, userId: cart.userId, sales: cart.sales);
      await cartRemoteDataSource.updateCart(cart: cModel);
      return right(unit);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }
}

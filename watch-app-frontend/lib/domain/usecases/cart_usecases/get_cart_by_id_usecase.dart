import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/cart.dart';
import 'package:clean_arch/domain/repository/cart_repository.dart';
import 'package:dartz/dartz.dart';

class GetCartByIdUsecase {
  final CartRepository _cartRepository;

  const GetCartByIdUsecase(this._cartRepository);

  Future<Either<Failure, Cart>> call({required String userId}) async =>
      await _cartRepository.getCart(userId: userId);
}

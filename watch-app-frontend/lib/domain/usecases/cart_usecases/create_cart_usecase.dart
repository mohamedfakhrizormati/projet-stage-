import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/repository/cart_repository.dart';
import 'package:dartz/dartz.dart';

class CreateCartUsecase {
  final CartRepository _cartRepository;

  const CreateCartUsecase(this._cartRepository);

  Future<Either<Failure, Unit>> call({required String userId}) async =>
      await _cartRepository.createCart(userId: userId);
}

import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/cart.dart';
import 'package:clean_arch/domain/repository/cart_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateCartUsecase {
  final CartRepository _cartRepository;

  const UpdateCartUsecase(this._cartRepository);

  Future<Either<Failure, Unit>> call({required Cart cart}) async =>
      await _cartRepository.updateCart(cart: cart);

  // Future<Either<Failure, Unit>> call(
  //         {required String cartId, required List<String> sales}) async =>
  //     await _cartRepository.updateCart(cartId: cartId, sales: sales);
}

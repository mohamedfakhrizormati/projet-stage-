import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/repository/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class CreateWishListUsecase {
  final WishlistRepository _repository;

  CreateWishListUsecase(this._repository);

  Future<Either<Failure, Unit>> call({required String userId}) async =>
      await _repository.createWishList(userId: userId);
}

import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/repository/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteWishListUsecase {
  final WishlistRepository _repository;

  DeleteWishListUsecase(this._repository);

  Future<Either<Failure, Unit>> call({required String wishlistId}) async =>
      await _repository.deleteWishlist(wishlistId: wishlistId);
}

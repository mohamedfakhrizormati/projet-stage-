import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/wishlist.dart';
import 'package:clean_arch/domain/repository/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateWishListUsecase {
  final WishlistRepository _repository;

  UpdateWishListUsecase(this._repository);

  // Future<Either<Failure, Unit>> call({required String wishlistId}) async =>
  //     await _repository.updateWishlist(wishlistId: wishlistId);

  Future<Either<Failure, Unit>> call({required Wishlist wishlist}) async =>
      await _repository.updateWishlist(wishlist: wishlist);
}

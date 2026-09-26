import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/domain/enteties/wishlist.dart';
import 'package:dartz/dartz.dart';

abstract class WishlistRepository {
  Future<Either<Failure, Wishlist>> getWishList({required String wishlistId});

  Future<Either<Failure, Unit>> createWishList({required String userId});

  Future<Either<Failure, Unit>> updateWishlist({required Wishlist wishlist});

  Future<Either<Failure, Unit>> deleteWishlist({required String wishlistId});
}

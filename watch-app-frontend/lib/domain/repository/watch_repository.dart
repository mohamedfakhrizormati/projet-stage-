import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:dartz/dartz.dart';

abstract class WatchRepository {
  Future<Either<Failure, List<Watch>>> getAllWatchs();
  Future<Either<Failure, Watch>> getWatchById({required String watchId});
  Future<Either<Failure, List<Watch>>> getWatchsByCategory(
      {required String category});
  Future<Either<Failure, List<Watch>>> getSortedWatchsByCat();
  Future<Either<Failure, List<Watch>>> getSortedWatchsBySales();
  Future<Either<Failure, List<Watch>>> getSortedWatchsByCreationDate();
}

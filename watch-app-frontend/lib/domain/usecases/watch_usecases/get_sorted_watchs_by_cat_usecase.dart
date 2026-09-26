import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/domain/repository/watch_repository.dart';
import 'package:dartz/dartz.dart';

class GetSortedWatchsByCatUsecase {
  final WatchRepository _watchRepository;

  const GetSortedWatchsByCatUsecase(this._watchRepository);

  Future<Either<Failure, List<Watch>>> call() async =>
      await _watchRepository.getSortedWatchsByCat();
}

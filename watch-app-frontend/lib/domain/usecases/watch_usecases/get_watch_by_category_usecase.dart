import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/domain/repository/watch_repository.dart';
import 'package:dartz/dartz.dart';

class GetWatchByCategoryUsecase {
  final WatchRepository _repository;

  const GetWatchByCategoryUsecase(this._repository);

  Future<Either<Failure, List<Watch>>> call({required String wcat}) async =>
      await _repository.getWatchsByCategory(category: wcat);
}

import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/domain/repository/watch_repository.dart';
import 'package:dartz/dartz.dart';

class GetWatchByIdUsecase {
  final WatchRepository _repository;

  const GetWatchByIdUsecase(this._repository);

  Future<Either<Failure, Watch>> call({required String wID}) async =>
      await _repository.getWatchById(watchId: wID);
}

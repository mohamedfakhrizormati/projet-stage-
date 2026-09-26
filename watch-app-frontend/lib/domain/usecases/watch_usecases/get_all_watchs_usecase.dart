import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/domain/repository/watch_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllWatchsUsecase {
  final WatchRepository _repository;

  const GetAllWatchsUsecase(this._repository);

  Future<Either<Failure, List<Watch>>> call() async =>
      await _repository.getAllWatchs();
}

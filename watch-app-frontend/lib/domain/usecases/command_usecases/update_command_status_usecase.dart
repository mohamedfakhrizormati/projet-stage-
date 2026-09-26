import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/command.dart';
import 'package:clean_arch/domain/repository/command_reposetory.dart';
import 'package:dartz/dartz.dart' hide Order;

class UpdateCommandStatusUsecase {
  final CommandRepository _repository;

  const UpdateCommandStatusUsecase(this._repository);

  Future<Either<Failure, Unit>> call(String commandId, String status) {
    return _repository.updateCommandStatus(commandId, status);
  }
}

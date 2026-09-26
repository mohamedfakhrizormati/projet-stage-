import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/command.dart';
import 'package:clean_arch/domain/repository/command_reposetory.dart';
import 'package:dartz/dartz.dart';

class GetCommandByIdUsecase {
  final CommandRepository _commandRepository;

  const GetCommandByIdUsecase(this._commandRepository);

  Future<Either<Failure, Command>> call(String commandId) async =>
      _commandRepository.getCommandById(commandId);
}

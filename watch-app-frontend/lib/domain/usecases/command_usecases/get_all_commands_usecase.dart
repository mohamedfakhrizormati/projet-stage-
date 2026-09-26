import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/command.dart';
import 'package:clean_arch/domain/repository/command_reposetory.dart';
import 'package:dartz/dartz.dart';

class GetAllCommandsUsecase {
  final CommandRepository repository;

  const GetAllCommandsUsecase(this.repository);

  Future<Either<Failure, List<Command>>> call(String userId) async =>
      repository.getAllCommands(userId);
}

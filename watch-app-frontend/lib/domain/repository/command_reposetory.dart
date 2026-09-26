import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/command.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:dartz/dartz.dart';

abstract class CommandRepository {
  Future<Either<Failure, Command>> createCommand(Command newCommand);

  Future<Either<Failure, List<Command>>> getAllCommands(String userId);

  Future<Either<Failure, Command>> getCommandById(String commandId);

  Future<Either<Failure, Unit>> updateCommandStatus(
      String commandId, String status);
}

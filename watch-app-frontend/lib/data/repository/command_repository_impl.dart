import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_command_data_source.dart';
import 'package:clean_arch/data/models/command_model.dart';
import 'package:clean_arch/domain/enteties/command.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/repository/command_reposetory.dart';
import 'package:clean_arch/domain/usecases/command_usecases/update_command_status_usecase.dart';
import 'package:dartz/dartz.dart';

class CommandRepositoryImpl implements CommandRepository {
  final CommandRemoteDataSource commandRemoteDataSource;

  CommandRepositoryImpl({required this.commandRemoteDataSource});

  @override
  Future<Either<Failure, Command>> createCommand(Command newCommand) async {
    try {
      final CommandModel command = CommandModel(
          adresse: newCommand.adresse,
          reference: newCommand.reference,
          commandTotalPrice: newCommand.commandTotalPrice,
          commandDate: newCommand.commandDate,
          commandStatus: newCommand.commandStatus,
          userId: newCommand.userId,
          sales: newCommand.sales);
      final res = await commandRemoteDataSource.createCommand(command);
      return right(res);
    } on RegistrationException catch (e) {
      return left(RegistrationFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Command>> getCommandById(String commandId) async {
    try {
      final res = await commandRemoteDataSource.getCommandById(commandId);
      return right(res);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } on CommandNotFoundException catch (_) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCommandStatus(
      String commandId, String status) async {
    try {
      final command =
          await commandRemoteDataSource.updateCommandstatus(commandId, status);
      return right(unit);
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Command>>> getAllCommands(String userId) async {
    try {
      final commandModels =
          await commandRemoteDataSource.getAllCommands(userId);
      return right(commandModels);
    } on ServerException {
      return left(ServerFailure());
    }
  }
}

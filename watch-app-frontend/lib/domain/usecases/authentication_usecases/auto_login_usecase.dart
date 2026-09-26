import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/token.dart';
import 'package:clean_arch/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AutoLoginUsecase {
  final AuthenticationRepository repository;

  const AutoLoginUsecase(this.repository);
  Future<Either<Failure, Token?>> call() async => await repository.autologin();
}

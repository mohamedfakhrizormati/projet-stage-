import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUsecase {
  final AuthenticationRepository repository;

  const LogoutUsecase(this.repository);
  Future<Either<Failure, Unit>> call() async => await repository.logout();
}

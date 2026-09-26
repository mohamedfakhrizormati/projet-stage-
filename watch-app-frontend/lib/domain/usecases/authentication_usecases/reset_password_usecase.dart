import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordUsecase {
  final AuthenticationRepository repository;

  const ResetPasswordUsecase(this.repository);
  Future<Either<Failure, Unit>> call(
          {required String email, required String password}) async =>
      await repository.resetPassword(email: email, password: password);
}

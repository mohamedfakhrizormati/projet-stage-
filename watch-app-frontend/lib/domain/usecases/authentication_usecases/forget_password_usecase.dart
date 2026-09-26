import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class ForgetPasswordUsecase {
  final AuthenticationRepository repository;

  const ForgetPasswordUsecase(this.repository);
  Future<Either<Failure, Unit>> call(
          {required String email, required String destination}) async =>
      await repository.forgetPassword(email: email, destination: destination);
}

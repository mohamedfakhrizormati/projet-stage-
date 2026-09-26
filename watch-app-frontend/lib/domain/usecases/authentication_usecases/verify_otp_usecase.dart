import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class OTPVerificationUsecase {
  final AuthenticationRepository repository;

  const OTPVerificationUsecase(this.repository);
  Future<Either<Failure, Unit>> call(
          {required String email, required int otp}) async =>
      await repository.verifyOTP(email: email, otp: otp);
}

import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePasswordUsercase {
  final AuthenticationRepository _authenticationRepository;

  const UpdatePasswordUsercase(this._authenticationRepository);

  Future<Either<Failure, Unit>> call({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async =>
      await _authenticationRepository.updatePassword(
          userId: userId, oldPassword: oldPassword, newPassword: newPassword);
}

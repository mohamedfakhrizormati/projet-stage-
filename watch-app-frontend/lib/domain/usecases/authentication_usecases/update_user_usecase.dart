import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUserUsecase {
  final AuthenticationRepository _authenticationRepository;

  const UpdateUserUsecase(this._authenticationRepository);

  Future<Either<Failure, Unit>> call({
    required String id,
    required String firstName,
    required String lastName,
    required String adresse,
    required String phone,
    required String gender,
    required DateTime birthDate,
  }) async =>
      await _authenticationRepository.updateUser(
          id: id,
          firstName: firstName,
          lastName: lastName,
          adresse: adresse,
          phone: phone,
          gender: gender,
          birthDate: birthDate);
}

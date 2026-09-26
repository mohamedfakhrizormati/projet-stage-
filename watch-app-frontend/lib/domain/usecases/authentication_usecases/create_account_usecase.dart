import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/user.dart';
import 'package:clean_arch/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAccountUsecase {
  final AuthenticationRepository _authenticationRepository;

  const CreateAccountUsecase(this._authenticationRepository);

  Future<Either<Failure, String>> call(
          {required String firstName,
          required String lastName,
          String? image,
          required String email,
          required String adresse,
          required String phone,
          required String gender,
          required DateTime birthDate,
          required String password}) async =>
      await _authenticationRepository.createAccount(
          firstName: firstName,
          lastName: lastName,
          image: image,
          email: email,
          adresse: adresse,
          phone: phone,
          gender: gender,
          birthDate: birthDate,
          password: password);
}

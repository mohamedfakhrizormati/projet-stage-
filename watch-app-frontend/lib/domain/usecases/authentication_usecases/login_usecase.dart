import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/token.dart';
import 'package:clean_arch/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase {
  final AuthenticationRepository _authenticationRepository;

  const LoginUsecase(this._authenticationRepository);

  Future<Either<Failure, Token>> call(
          {required String email, required String password}) async =>
      await _authenticationRepository.login(email: email, password: password);
}

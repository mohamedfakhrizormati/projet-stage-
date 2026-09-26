import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/user.dart';
import 'package:clean_arch/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserByIdUsecase {
  final AuthenticationRepository _authenticationRepository;

  const GetUserByIdUsecase(this._authenticationRepository);

  Future<Either<Failure, User>> call({required String userId}) async =>
      await _authenticationRepository.getUserById(userId: userId);
}

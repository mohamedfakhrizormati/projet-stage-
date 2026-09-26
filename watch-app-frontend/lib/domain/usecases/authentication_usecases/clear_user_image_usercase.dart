import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class ClearUserImageUsecase {
  final AuthenticationRepository repository;

  ClearUserImageUsecase(this.repository);
  Future<Either<Failure, Unit>> call(String userId) async =>
      await repository.clearUserImage(userId);
}

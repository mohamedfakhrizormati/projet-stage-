import 'dart:io';

import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateImageUsecase {
  final AuthenticationRepository _authenticationRepository;

  const UpdateImageUsecase(this._authenticationRepository);

  Future<Either<Failure, Unit>> call({
    required String userId,
    required File image,
  }) async =>
      await _authenticationRepository.updateImage(userId: userId, image: image);
}

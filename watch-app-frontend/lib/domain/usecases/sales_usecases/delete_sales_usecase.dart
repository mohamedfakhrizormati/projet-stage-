import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/repository/sales_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteSalesUsecase {
  final SalesRepository repository;

  const DeleteSalesUsecase(this.repository);

  Future<Either<Failure, Unit>> call(String salesId) async =>
      await repository.deleteSales(salesId);
}

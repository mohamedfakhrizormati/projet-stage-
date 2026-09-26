import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/repository/sales_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateSalesUsecase {
  final SalesRepository repository;

  const UpdateSalesUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Sales sale) async =>
      await repository.updateSales(sale);
}

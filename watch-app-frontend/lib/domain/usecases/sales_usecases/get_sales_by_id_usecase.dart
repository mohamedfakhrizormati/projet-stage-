import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/repository/sales_repository.dart';
import 'package:dartz/dartz.dart';

class GetSalesByIdUsecase {
  final SalesRepository repository;

  const GetSalesByIdUsecase(this.repository);

  Future<Either<Failure, Sales>> call(String salesId) async =>
      await repository.getSalesById(salesId);
}

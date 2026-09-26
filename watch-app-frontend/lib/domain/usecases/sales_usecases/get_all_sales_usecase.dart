import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/repository/sales_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllSalesUsecase {
  final SalesRepository repository;

  const GetAllSalesUsecase(this.repository);

  Future<Either<Failure, List<Sales>>> call(String userId) async =>
      repository.getAllSales(userId);
}

import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:dartz/dartz.dart';

abstract class SalesRepository {
  Future<Either<Failure, Sales>> addSales(Sales newSale);

  Future<Either<Failure, List<Sales>>> getAllSales(String userId);

  Future<Either<Failure, Sales>> getSalesById(String salesId);

  Future<Either<Failure, Unit>> updateSales(Sales sale);

  Future<Either<Failure, Unit>> deleteSales(String salesId);
}

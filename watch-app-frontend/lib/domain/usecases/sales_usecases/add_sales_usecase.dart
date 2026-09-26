import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/repository/sales_repository.dart';
import 'package:dartz/dartz.dart';

class AddSaleUsecase {
  final SalesRepository repository;

  AddSaleUsecase(this.repository);

  Future<Either<Failure, Sales>> call(Sales newSale) async =>
      await repository.addSales(newSale);
}

import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
}

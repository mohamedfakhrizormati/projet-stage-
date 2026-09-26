import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/category.dart';
import 'package:clean_arch/domain/repository/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllCategoriesUsecase {
  final CategoryRepository _categoryRepository;

  const GetAllCategoriesUsecase(this._categoryRepository);

  Future<Either<Failure, List<Category>>> call() async =>
      await _categoryRepository.getAllCategories();
}

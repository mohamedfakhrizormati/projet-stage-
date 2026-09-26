import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_category_data_source.dart';
import 'package:clean_arch/domain/enteties/category.dart';
import 'package:clean_arch/domain/repository/category_repository.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl({required this.categoryRemoteDataSource});

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      final res = await categoryRemoteDataSource.getAllCategories();
      return right(res);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } on CategoryNotFoundException catch (_) {
      return left(ServerFailure());
    }
  }
}

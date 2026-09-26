import 'package:clean_arch/di.dart';
import 'package:clean_arch/domain/enteties/category.dart';
import 'package:clean_arch/domain/usecases/category_usecases/get_all_categories_usecase.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  List<Category> allCategories = [];
  String selectedCategory = ''; // Default to "All"

  Future<bool> getAllCategories() async {
    final res = await GetAllCategoriesUsecase(sl())();
    res.fold((l) => null, (r) {
      return allCategories = r;
    });
    return true;
  }

  void updateSelectedCategory(String? categoryId) {
    selectedCategory = categoryId ?? 'all';
    update();
  }

  @override
  void onInit() {
    if (selectedCategory == '') {
      selectedCategory = 'all';
    }
    super.onInit();
  }
}

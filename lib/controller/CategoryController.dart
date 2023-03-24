import 'package:nb_utils/nb_utils.dart';
import '../data/models/Category.dart';
import '../data/service/CategoryService.dart';

class CategoryController {
  final CategoryService categoryService = CategoryService();

  static final instance = CategoryController();

  Future<List<CategoryBodyRes>?> getAllCategories() async {
    var idUser = await sharedPreferences.getString('user') ?? "";
    var res = await categoryService.getAllCategory(idUser);

    if (res is GetAllCategorySuccessRes) {
      return res.categoryList.toList();
    } else {
      return null;
    }
  }
}

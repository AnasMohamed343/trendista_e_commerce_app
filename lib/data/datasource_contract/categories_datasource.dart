import 'package:trendista_e_commerce/data/model/categories_response/Data.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';

abstract class CategoriesDataSource {
  Future<List<Category>?> getCategories();
}

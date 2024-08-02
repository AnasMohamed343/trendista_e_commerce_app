import 'package:trendista_e_commerce/domain/entities/Category.dart';

abstract class CategoriesRepository {
  Future<List<Category>?> getCategories();
}

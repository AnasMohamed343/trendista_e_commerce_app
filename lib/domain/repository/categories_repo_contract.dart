//import 'package:trendista_e_commerce/domain/entities/route_e-commerce/Category.dart';

import 'package:trendista_e_commerce/domain/entities/Category.dart';

abstract class CategoriesRepository {
  Future<List<Category>?> getCategories();
}

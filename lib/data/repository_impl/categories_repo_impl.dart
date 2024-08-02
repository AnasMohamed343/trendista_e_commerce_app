import 'package:trendista_e_commerce/data/datasource_contract/categories_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';
import 'package:trendista_e_commerce/domain/repository/categories_repo_contract.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  CategoriesDataSource categoriesDataSource;
  CategoriesRepositoryImpl({required this.categoriesDataSource});
  @override
  Future<List<Category>?> getCategories() {
    return categoriesDataSource.getCategories();
  }
}

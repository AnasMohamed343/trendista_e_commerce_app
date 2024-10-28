import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/datasource_contract/categories_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';
//import 'package:trendista_e_commerce/domain/entities/route_e-commerce/Category.dart';
import 'package:trendista_e_commerce/domain/repository/categories_repo_contract.dart';

@Injectable(as: CategoriesRepository)
class CategoriesRepositoryImpl extends CategoriesRepository {
  CategoriesDataSource categoriesDataSource;
  @factoryMethod
  CategoriesRepositoryImpl({required this.categoriesDataSource});
  @override
  Future<List<Category>?> getCategories() {
    return categoriesDataSource.getCategories();
  }
}

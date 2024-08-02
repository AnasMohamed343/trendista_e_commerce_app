import 'package:trendista_e_commerce/data/api_manager/api_manager.dart';
import 'package:trendista_e_commerce/data/datasource_contract/categories_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';

class CategoriesDataSourceImpl extends CategoriesDataSource {
  ApiManager apiManager;
  CategoriesDataSourceImpl({required this.apiManager});
  @override
  Future<List<Category>?> getCategories() async {
    var response = await apiManager.getCategories();
    return response.data?.map((catDto) => catDto.toCategory()).toList();
    //return response.data?.map((categoryDto) => Category(id: categoryDto.id, name: categoryDto.name, slug: categoryDto.slug, image: categoryDto.image)).toList();
  }
}

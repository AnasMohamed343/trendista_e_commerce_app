import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/api_manager/api_manager.dart';
import 'package:trendista_e_commerce/data/datasource_contract/categories_datasource.dart';
import 'package:trendista_e_commerce/data/model/categories_response/Data.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';

@Injectable(as: CategoriesDataSource)
class CategoriesDataSourceImpl extends CategoriesDataSource {
  ApiManager apiManager;
  @factoryMethod
  CategoriesDataSourceImpl({required this.apiManager});
  @override
  Future<List<Category>?> getCategories() async {
    var response = await apiManager.getCategories();
    return response.data?.data?.map((catDto) => catDto.toCategory()).toList();
    //return response.data?.map((catDto) => catDto.toCategory()).toList();
    //return response.data?.map((categoryDto) => Category(id: categoryDto.id, name: categoryDto.name, slug: categoryDto.slug, image: categoryDto.image)).toList();
  }
}

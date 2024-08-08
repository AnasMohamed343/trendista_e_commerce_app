import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/model/brands_response/BrandsResponse.dart';
import 'package:trendista_e_commerce/data/model/categories_response/CategoriesResponse.dart';
import 'package:trendista_e_commerce/data/model/products_response/ProductsResponse.dart';
import 'package:trendista_e_commerce/domain/repository/products_repository.dart';

@singleton
@injectable
class ApiManager {
  static const baseUrl = 'ecommerce.routemisr.com';

  Future<CategoriesResponse> getCategories() async {
    var url = Uri.https(baseUrl, '/api/v1/categories');
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    CategoriesResponse categoriesResponse = CategoriesResponse.fromJson(json);
    return categoriesResponse;
  }

  Future<BrandsResponse> getBrands() async {
    var url = Uri.https(baseUrl, '/api/v1/brands');
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    BrandsResponse brandsResponse = BrandsResponse.fromJson(json);
    return brandsResponse;
  }

  Future<ProductsResponse> getProducts(
      {ProductSort? sort, String? categoryId}) async {
    var url =
        // categoryId == null || categoryId.isEmpty
        //     ? Uri.https(baseUrl, '/api/v1/products', {'sort': sort})
        //     :
        Uri.https(baseUrl, '/api/v1/products', {
      'sort': sort,
      if (categoryId != null && categoryId.isNotEmpty)
        "category[in]": categoryId
    }); // this  how to send list to the api => if (categoryId != null) "category[in]": jsonDecode(categoryId)
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    ProductsResponse productsResponse = ProductsResponse.fromJson(json);
    return productsResponse;
  }
}

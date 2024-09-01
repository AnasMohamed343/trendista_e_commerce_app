import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/model/auth_response/AuthResponse.dart';
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

  Future<AuthResponse> register(
      {required String name,
      required String email,
      required String mobileNumber,
      required String password}) async {
    var url = Uri.https(baseUrl, '/api/v1/auth/signup');
    var response = await http.post(url, body: {
      "name": name,
      "email": email,
      "password": password,
      "rePassword": password,
      "phone": mobileNumber,
    });
    var json = jsonDecode(response.body);
    AuthResponse authResponse = AuthResponse.fromJson(json);
    return authResponse;
  }

  Future<AuthResponse> login(
      {required String email, required String password}) async {
    var url = Uri.https(baseUrl, '/api/v1/auth/signin');
    var response =
        await http.post(url, body: {"email": email, "password": password});
    var json = jsonDecode(response.body);
    AuthResponse authResponse = AuthResponse.fromJson(json);
    return authResponse;
  }
}

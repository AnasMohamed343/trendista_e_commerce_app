import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/model/categories_response/CategoriesResponse.dart';

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
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/constants.dart';
import 'package:trendista_e_commerce/core/local/prefs_helper.dart';
import 'package:trendista_e_commerce/data/model/Cart_Response/CartResponse.dart';
import 'package:trendista_e_commerce/data/model/auth_response/AuthResponse.dart';
import 'package:trendista_e_commerce/data/model/auth_response/route_auth/AuthResponse.dart';
import 'package:trendista_e_commerce/data/model/banners_response/BannerResponse.dart';
import 'package:trendista_e_commerce/data/model/brands_response/BrandsResponse.dart';
import 'package:trendista_e_commerce/data/model/favorite_response/FavoriteResponse.dart';
import 'package:trendista_e_commerce/data/model/product_details_response/ProductDetailsResponse.dart';
import 'package:trendista_e_commerce/data/model/products_response/ProductResponse.dart';
//import 'package:trendista_e_commerce/data/model/categories_response/route_e-commercce/CategoriesResponse.dart';
//import 'package:trendista_e_commerce/data/model/products_response/route_e-commerce/ProductsResponse.dart';
import 'package:trendista_e_commerce/domain/repository/products_repository.dart';
import 'package:trendista_e_commerce/data/model/categories_response/CategoryResponse.dart';

@singleton
@injectable
class ApiManager {
  static const baseUrl = 'ecommerce.routemisr.com'; //'ecommerce.routemisr.com';
  static const baseUrlVal = 'student.valuxapps.com';
  final String myToken = PrefsHelper.getToken();

  Future<BannerResponse> getBanners() async {
    var url = Uri.https(baseUrlVal, '/api/banners');
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    BannerResponse bannerResponse = BannerResponse.fromJson(json);
    return bannerResponse;
  }

  Future<CategoryResponse> getCategories() async {
    var url = Uri.https(
        baseUrlVal, '/api/categories'); // route-ecommerce => api/v1/categories
    var response = await http.get(url, headers: {
      'lang': 'en',
    });
    var json = jsonDecode(response.body);
    CategoryResponse categoriesResponse = CategoryResponse.fromJson(json);
    return categoriesResponse;
  }

  Future<BrandsResponse> getBrands() async {
    var url = Uri.https(
        baseUrl, '/api/v1/brands'); // route-ecommerce => api/v1/brands
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    BrandsResponse brandsResponse = BrandsResponse.fromJson(json);
    return brandsResponse;
  }

  // Future<ProductResponse> getProducts(
  //     {ProductSort? sort, int? categoryId}) async {
  //   var url = Uri.https(baseUrlVal, '/api/products', {
  //     'sort': sort,
  //     if (categoryId != null) "category[in]": categoryId
  //   }); // this  how to send list to the api => if (categoryId != null) "category[in]": jsonDecode(categoryId)
  //   var response = await http.get(url, headers: {
  //     'Authorization': token ?? '',
  //     'lang': 'en',
  //   });
  //   var json = jsonDecode(response.body);
  //   ProductResponse productsResponse = ProductResponse.fromJson(json);
  //   return productsResponse;
  // }
  Future<ProductResponse> getProducts({required int? categoryId}) async {
    var url = Uri.https(baseUrlVal,
        categoryId != null ? '/api/categories/$categoryId' : '/api/products');
    var response = await http.get(url, headers: {
      'Authorization': myToken,
      'lang': 'en',
    });

    var json = jsonDecode(response.body);
    return ProductResponse.fromJson(json);
  }

  Future<FavoriteResponse> getFavorites() async {
    var url = Uri.https(baseUrlVal, '/api/favorites');
    var response = await http.get(url, headers: {
      'lang': 'en',
      'Authorization': myToken,
    });
    var json = jsonDecode(response.body);
    return FavoriteResponse.fromJson(json);
  }

  Future<FavoriteResponse> addOrRemoveFavorite(
      {required String productId}) async {
    var url = Uri.https(baseUrlVal, '/api/favorites');
    var response = await http.post(url, body: {
      "product_id": productId,
    }, headers: {
      'lang': 'en',
      'Authorization': myToken,
    });
    var json = jsonDecode(response.body);
    return FavoriteResponse.fromJson(json);
  }

  Future<CartResponse> getCart() async {
    var url = Uri.https(baseUrlVal, '/api/carts');
    var response = await http.get(url, headers: {
      'lang': 'en',
      'Authorization': myToken,
    });
    var json = jsonDecode(response.body);
    return CartResponse.fromJson(json);
  }

  Future<CartResponse> addOrRemoveCart({required String productId}) async {
    var url = Uri.https(baseUrlVal, '/api/carts');
    var response = await http.post(url, body: {
      "product_id": productId,
    }, headers: {
      'lang': 'en',
      'Authorization': myToken,
    });
    var json = jsonDecode(response.body);
    return CartResponse.fromJson(json);
  }

  Future<CartResponse> updateCartQuantity({required String productId}) async {
    var url = Uri.https(baseUrlVal, '/api/carts/$productId');
    var response = await http.put(url, headers: {
      'lang': 'en',
      'Authorization': myToken,
    });
    var json = jsonDecode(response.body);
    return CartResponse.fromJson(json);
  }

  Future<ProductDetailsResponse> getProductDetails(int productId) async {
    var url = Uri.https(baseUrlVal, '/api/products/$productId');
    var response = await http.get(url, headers: {
      'lang': 'en',
      'Authorization': myToken,
    });
    print('API Response: ${response.body}');
    var json = jsonDecode(response.body);
    return ProductDetailsResponse.fromJson(json);
  }

  Future<AuthResponse> register({
    required String name,
    required String email,
    required String mobileNumber,
    required String password,
  }) async {
    var url = Uri.https(
        baseUrlVal, '/api/register'); // route-ecommerce => api/v1/auth/signup
    var response = await http.post(url, body: {
      "name": name,
      "email": email,
      "password": password,
      "phone": mobileNumber,
    });
    var json = jsonDecode(response.body);
    AuthResponse authResponse = AuthResponse.fromJson(json);
    return authResponse;
  }

  Future<AuthResponse> login(
      {required String email, required String password}) async {
    var url = Uri.https(
        baseUrlVal, '/api/login'); // route-ecommerce => api/v1/auth/signin
    var response =
        await http.post(url, body: {"email": email, "password": password});
    var json = jsonDecode(response.body);
    //await PrefsHelper.setToken(key: token ?? '', value: json['data']['token']);
    // Save token and wait for completion

    AuthResponse authResponse = AuthResponse.fromJson(json);
    // Save token and wait for completion
    await PrefsHelper.setToken(authResponse.data?.token ?? '');

    // // Reload the token after saving to confirm it's available in memory
    //  myToken = PrefsHelper.getToken();
    return authResponse;
  }

  Future<AuthResponse> getProfileData() async {
    var url = Uri.https(baseUrlVal, '/api/profile');
    var response = await http.get(url, headers: {
      'lang': 'en',
      'Authorization': myToken,
    });
    var json = jsonDecode(response.body);
    AuthResponse authResponse = AuthResponse.fromJson(json);
    return authResponse;
  }
}

//
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:injectable/injectable.dart';
// import 'package:trendista_e_commerce/data/model/auth_response/AuthResponse.dart';
// import 'package:trendista_e_commerce/data/model/brands_response/BrandsResponse.dart';
// import 'package:trendista_e_commerce/data/model/categories_response/CategoriesResponse.dart';
// import 'package:trendista_e_commerce/data/model/products_response/ProductsResponse.dart';
// import 'package:trendista_e_commerce/domain/repository/products_repository.dart';
//
// @singleton
// @injectable
// class ApiManager {
//   static const baseUrl = 'student.valuxapps.com'; //'ecommerce.routemisr.com';
//
//   Future<CategoriesResponse> getCategories() async {
//     var url = Uri.https(
//         baseUrl, '/api/v1/categories'); // route-ecommerce => api/v1/categories
//     var response = await http.get(url);
//     var json = jsonDecode(response.body);
//     CategoriesResponse categoriesResponse = CategoriesResponse.fromJson(json);
//     return categoriesResponse;
//   }
//
//   Future<BrandsResponse> getBrands() async {
//     var url = Uri.https(
//         baseUrl, '/api/v1/brands'); // route-ecommerce => api/v1/brands
//     var response = await http.get(url);
//     var json = jsonDecode(response.body);
//     BrandsResponse brandsResponse = BrandsResponse.fromJson(json);
//     return brandsResponse;
//   }
//
//   Future<ProductsResponse> getProducts(
//       {ProductSort? sort, String? categoryId}) async {
//     var url =
//     // categoryId == null || categoryId.isEmpty
//     //     ? Uri.https(baseUrl, '/api/v1/products', {'sort': sort})
//     //     :
//     Uri.https(baseUrl, '/api/v1/products', {
//       // route-ecommerce => api/v1/products
//       'sort': sort,
//       if (categoryId != null && categoryId.isNotEmpty)
//         "category[in]": categoryId
//     }); // this  how to send list to the api => if (categoryId != null) "category[in]": jsonDecode(categoryId)
//     var response = await http.get(url);
//     var json = jsonDecode(response.body);
//     ProductsResponse productsResponse = ProductsResponse.fromJson(json);
//     return productsResponse;
//   }
//
//   Future<AuthResponse> register(
//       {required String name,
//         required String email,
//         required String mobileNumber,
//         required String password}) async {
//     var url = Uri.https(
//         baseUrl, '/api/register'); // route-ecommerce => api/v1/auth/signup
//     var response = await http.post(url, body: {
//       "name": name,
//       "email": email,
//       "password": password,
//       "rePassword": password,
//       "phone": mobileNumber,
//     });
//     var json = jsonDecode(response.body);
//     AuthResponse authResponse = AuthResponse.fromJson(json);
//     return authResponse;
//   }
//
//   Future<AuthResponse> login(
//       {required String email, required String password}) async {
//     var url = Uri.https(
//         baseUrl, '/api/login'); // route-ecommerce => api/v1/auth/signin
//     var response =
//     await http.post(url, body: {"email": email, "password": password});
//     var json = jsonDecode(response.body);
//     AuthResponse authResponse = AuthResponse.fromJson(json);
//     return authResponse;
//   }
// }

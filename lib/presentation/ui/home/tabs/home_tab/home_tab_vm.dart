import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/BannerEntity.dart';
import 'package:trendista_e_commerce/domain/entities/Brand.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/repository/categories_repo_contract.dart';
import 'package:trendista_e_commerce/domain/usecases/get_banners_usecase.dart';
import 'package:trendista_e_commerce/domain/usecases/get_brands_usecase.dart';
import 'package:trendista_e_commerce/domain/usecases/get_categories_usecase.dart';
import 'package:trendista_e_commerce/domain/usecases/get_products_usecase.dart';

//import '../../../../../domain/entities/route_e-commerce/Category.dart';
import '../../../../../domain/entities/Category.dart';

@injectable
class HomeTabVM extends Cubit<HomeTabState> {
  GetBannersUseCase getBannersUseCase;
  GetCategoriesUseCase getCategoriesUseCase;
  GetBrandsUseCase getBrandsUseCase;
  GetProductsUseCase getProductsUseCase;
  @factoryMethod
  HomeTabVM({
    required this.getBannersUseCase,
    required this.getCategoriesUseCase,
    required this.getBrandsUseCase,
    required this.getProductsUseCase,
  }) : super(LoadingState(message: 'Loading..'));

  void initPage() async {
    emit(LoadingState(message: 'Loading..'));
    try {
      var banners = await getBannersUseCase.invoke();
      var categories = await getCategoriesUseCase.invoke();
      var brands = await getBrandsUseCase.invoke();
      var products = await getProductsUseCase.invoke();
      emit(SuccessState(
          banners: banners,
          categories: categories,
          brands: brands,
          products: products));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  void searchProducts(String name) async {
    emit(LoadingState(message: 'Loading..'));
    try {
      var banners = await getBannersUseCase.invoke();
      var categories = await getCategoriesUseCase.invoke();
      var brands = await getBrandsUseCase.invoke();
      var products = await getProductsUseCase.invoke();
      var filteredProducts = products
          ?.where((element) =>
              element.name!.toLowerCase().startsWith(name.toLowerCase()))
          .toList();
      emit(SuccessState(
          products: filteredProducts,
          brands: brands,
          categories: categories,
          banners: banners));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}

sealed class HomeTabState {}

class LoadingState extends HomeTabState {
  String message;
  LoadingState({required this.message});
}

class ErrorState extends HomeTabState {
  String? errorMessage;
  ErrorState({this.errorMessage});
}

class SuccessState extends HomeTabState {
  List<BannerEntity>? banners;
  List<Category>? categories;
  List<Brand>? brands;
  List<Product>? products = [];
  List<Product>? filteredProducts = [];
  SuccessState({this.categories, this.brands, this.products, this.banners});
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/Brand.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/repository/categories_repo_contract.dart';
import 'package:trendista_e_commerce/domain/usecases/get_brands_usecase.dart';
import 'package:trendista_e_commerce/domain/usecases/get_categories_usecase.dart';
import 'package:trendista_e_commerce/domain/usecases/get_products_usecase.dart';

import '../../../../../domain/entities/Category.dart';

@injectable
class HomeTabVM extends Cubit<HomeTabState> {
  GetCategoriesUseCase getCategoriesUseCase;
  GetBrandsUseCase getBrandsUseCase;
  GetProductsUseCase getProductsUseCase;
  @factoryMethod
  HomeTabVM({
    required this.getCategoriesUseCase,
    required this.getBrandsUseCase,
    required this.getProductsUseCase,
  }) : super(LoadingState(message: 'Loading..'));

  void initPage() async {
    emit(LoadingState(message: 'Loading..'));
    try {
      var categories = await getCategoriesUseCase.invoke();
      var brands = await getBrandsUseCase.invoke();
      var products = await getProductsUseCase.invoke();
      emit(SuccessState(
          categories: categories, brands: brands, products: products));
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
  List<Category>? categories;
  List<Brand>? brands;
  List<Product>? products;
  SuccessState({this.categories, this.brands, this.products});
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/Category.dart';
import 'package:trendista_e_commerce/domain/entities/Product.dart';
import 'package:trendista_e_commerce/domain/usecases/get_products_usecase.dart';

@injectable
class ProductsTabVM extends Cubit<ProductsTabState> {
  GetProductsUseCase getProductsUseCase;
  @factoryMethod
  ProductsTabVM({
    required this.getProductsUseCase,
  }) : super(LoadingState(message: 'Loading..'));

  void initPage(Category category) async {
    emit(LoadingState(message: 'Loading..'));
    try {
      var products = await getProductsUseCase.invoke(category);
      emit(SuccessState(products: products));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}

sealed class ProductsTabState {}

class LoadingState extends ProductsTabState {
  String message;
  LoadingState({required this.message});
}

class ErrorState extends ProductsTabState {
  String? errorMessage;
  ErrorState({this.errorMessage});
}

class SuccessState extends ProductsTabState {
  List<Product>? products;
  SuccessState({this.products});
}
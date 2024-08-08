import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/usecases/get_categories_usecase.dart';

import '../../../../../domain/entities/Category.dart';

@injectable
class CategoryTabVM extends Cubit<CategoryTabState> {
  GetCategoriesUseCase getCategoriesUseCase;
  @factoryMethod
  CategoryTabVM({
    required this.getCategoriesUseCase,
  }) : super(LoadingState(message: 'Loading..'));

  void initPage() async {
    emit(LoadingState(message: 'Loading..'));
    try {
      var categories = await getCategoriesUseCase.invoke();
      emit(SuccessState(
        categories: categories,
      ));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}

sealed class CategoryTabState {}

class LoadingState extends CategoryTabState {
  String message;
  LoadingState({required this.message});
}

class ErrorState extends CategoryTabState {
  String? errorMessage;
  ErrorState({this.errorMessage});
}

class SuccessState extends CategoryTabState {
  List<Category>? categories;
  SuccessState({this.categories});
}

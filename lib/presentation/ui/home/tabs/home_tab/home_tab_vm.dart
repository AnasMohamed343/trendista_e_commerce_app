import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/repository/categories_repo_contract.dart';
import 'package:trendista_e_commerce/domain/usecases/get_categories_usecase.dart';

import '../../../../../domain/entities/Category.dart';

@injectable
class HomeTabVM extends Cubit<HomeTabState> {
  GetCategoriesUseCase getCategoriesUseCase;
  @factoryMethod
  HomeTabVM({required this.getCategoriesUseCase})
      : super(LoadingState(message: 'Loading..'));

  void initPage() async {
    emit(LoadingState(message: 'Loading..'));
    try {
      var categories = await getCategoriesUseCase.invoke();
      emit(SuccessState(categories: categories));
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
  SuccessState({this.categories});
}

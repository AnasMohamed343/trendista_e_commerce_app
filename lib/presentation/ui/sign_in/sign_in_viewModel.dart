import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/auth_entity/AuthEntity.dart';
import 'package:trendista_e_commerce/domain/usecases/sign_in_usecase.dart';

@injectable
class SignInViewModel extends Cubit<SignInViewModelState> {
  @factoryMethod
  SignInViewModel({required this.signInUseCase}) : super(SignInInitialState());
  SignInUseCase signInUseCase;

  signIn({required String email, required String password}) async {
    emit(LoadingState());
    var response = await signInUseCase.Invoke(email: email, password: password);
    response.fold((response) {
      emit(SuccessState(authEntity: response));
    }, (error) {
      emit(ErrorState(errorMessage: error));
    });
  }
}

sealed class SignInViewModelState {}

class SignInInitialState extends SignInViewModelState {}

class LoadingState extends SignInViewModelState {}

class SuccessState extends SignInViewModelState {
  AuthEntity authEntity;
  SuccessState({required this.authEntity});
}

class ErrorState extends SignInViewModelState {
  String errorMessage;
  ErrorState({required this.errorMessage});
}

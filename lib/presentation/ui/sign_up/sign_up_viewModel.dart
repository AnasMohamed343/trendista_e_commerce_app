import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/usecases/sign_up_usecase.dart';

@injectable
class SignUpViewModel extends Cubit<SignUpViewModelState> {
  @factoryMethod
  SignUpViewModel({required this.signUpUseCase}) : super(SignUpInitialState());
  SignUpUseCase signUpUseCase;

  void signUp({
    required String email,
    required String password,
    required String mobileNumber,
    required String name,
  }) async {
    emit(LoadingState());
    try {
      var result = await signUpUseCase.invoke(
          email: email,
          password: password,
          mobileNumber: mobileNumber,
          name: name);
      result.fold((response) {
        emit(SuccessState(token: response.token ?? ''));
      }, (error) {
        emit(ErrorState(errorMessage: error));
      });
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}

sealed class SignUpViewModelState {}

class SignUpInitialState extends SignUpViewModelState {}

class LoadingState extends SignUpViewModelState {}

class SuccessState extends SignUpViewModelState {
  String token;
  SuccessState({required this.token});
}

class ErrorState extends SignUpViewModelState {
  String errorMessage;
  ErrorState({required this.errorMessage});
}

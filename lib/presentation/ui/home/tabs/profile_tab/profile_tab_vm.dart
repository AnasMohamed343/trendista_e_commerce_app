import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/auth_entity/AuthEntity.dart';
import 'package:trendista_e_commerce/domain/entities/auth_entity/UserEntity.dart';
import 'package:trendista_e_commerce/domain/usecases/get_profiledata_usecase.dart';

@injectable
class ProfileTabVM extends Cubit<ProfileState> {
  GetProfileDataUseCase getProfileDataUseCase;
  @factoryMethod
  ProfileTabVM({required this.getProfileDataUseCase})
      : super(LoadingState(message: ''));

  void getProfileData() async {
    try {
      var result = await getProfileDataUseCase.Invoke();
      emit(SuccessState(authEntity: result));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}

sealed class ProfileState {}

class LoadingState extends ProfileState {
  String message;
  LoadingState({required this.message});
}

class ErrorState extends ProfileState {
  String? errorMessage;
  ErrorState({this.errorMessage});
}

class SuccessState extends ProfileState {
  UserEntity? authEntity;
  SuccessState({this.authEntity});
}

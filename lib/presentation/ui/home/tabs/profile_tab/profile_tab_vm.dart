import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/auth_entity/AuthEntity.dart';
import 'package:trendista_e_commerce/domain/entities/auth_entity/UserEntity.dart';
import 'package:trendista_e_commerce/domain/entities/user_profile_entity.dart';
import 'package:trendista_e_commerce/domain/usecases/get_profiledata_usecase.dart';

@injectable
class ProfileTabVM extends Cubit<ProfileState> {
  GetProfileDataUseCase getProfileDataUseCase;
  UserProfileEntity? _userProfileEntity;

  UserProfileEntity? get userProfileEntity => _userProfileEntity;
  @factoryMethod
  ProfileTabVM({required this.getProfileDataUseCase})
      : super(LoadingState(message: ''));

  void getProfileData() async {
    try {
      var profileData = await getProfileDataUseCase.invoke();
      print('Profile Data: $profileData'); // Check the received data
      emit(SuccessState(userProfileEntity: profileData));
      _userProfileEntity = profileData;
    } catch (e) {
      print('Error at Profile Data: $e');
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  void updateProfileData(
      {required String name,
      required String email,
      required String mobileNumber,
      required String image}) async {
    try {
      var profileData = await getProfileDataUseCase.updateProfileData(
          name: name, email: email, mobileNumber: mobileNumber, image: image);
      emit(SuccessState(userProfileEntity: profileData));
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  @override
  void onChange(Change<ProfileState> change) {
    super.onChange(change);
    print('Change: $change');
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
  UserProfileEntity? userProfileEntity;
  SuccessState({this.userProfileEntity});
}

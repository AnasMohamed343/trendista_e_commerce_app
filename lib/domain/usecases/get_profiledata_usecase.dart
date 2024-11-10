import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/auth_entity/AuthEntity.dart';
import 'package:trendista_e_commerce/domain/entities/user_profile_entity.dart';
import 'package:trendista_e_commerce/domain/repository/auth_repository.dart';
import 'package:trendista_e_commerce/domain/repository/profile_repository.dart';

@injectable
class GetProfileDataUseCase {
  // AuthRepository authRepository;
  // @factoryMethod
  // GetProfileDataUseCase({required this.authRepository});
  // Future Invoke() async => await authRepository.getProfileData();
  ProfileRepository profileRepository;
  @factoryMethod
  GetProfileDataUseCase({required this.profileRepository});
  Future<UserProfileEntity?> invoke() async =>
      await profileRepository.getProfileData();

  Future<UserProfileEntity?> updateProfileData(
      {required String name,
      required String email,
      required String mobileNumber,
      required String image}) async {
    return await profileRepository.updateProfileData(
        name: name, email: email, mobileNumber: mobileNumber, image: image);
  }
}

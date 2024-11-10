import 'package:trendista_e_commerce/domain/entities/user_profile_entity.dart';

abstract class ProfileRepository {
  Future<UserProfileEntity?> getProfileData();

  Future<UserProfileEntity?> updateProfileData(
      {required String name,
      required String email,
      required String mobileNumber,
      required String image});
}

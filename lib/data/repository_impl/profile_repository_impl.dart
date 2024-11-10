import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/datasource_contract/profile_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/user_profile_entity.dart';
import 'package:trendista_e_commerce/domain/repository/profile_repository.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  ProfileDataSource profileDataSource;
  @factoryMethod
  ProfileRepositoryImpl({required this.profileDataSource});
  @override
  Future<UserProfileEntity?> getProfileData() {
    return profileDataSource.getProfileData();
  }

  @override
  Future<UserProfileEntity?> updateProfileData(
      {required String name,
      required String email,
      required String mobileNumber,
      required String image}) {
    return profileDataSource.updateProfileData(
        name: name, email: email, mobileNumber: mobileNumber, image: image);
  }
}

import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/api_manager/api_manager.dart';
import 'package:trendista_e_commerce/data/datasource_contract/profile_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/user_profile_entity.dart';

@Injectable(as: ProfileDataSource)
class ProfileDataSourceImpl extends ProfileDataSource {
  ApiManager apiManager;
  @factoryMethod
  ProfileDataSourceImpl({required this.apiManager});
  @override
  Future<UserProfileEntity?> getProfileData() async {
    var response = await apiManager.getProfileData();
    return response.data?.toUserProfileEntity();
  }

  @override
  Future<UserProfileEntity?> updateProfileData(
      {required String name,
      required String email,
      required String mobileNumber,
      required String image}) async {
    var response = await apiManager.updateProfileData(
        name: name, email: email, mobileNumber: mobileNumber, image: image);
    return response.data?.toUserProfileEntity();
  }
}

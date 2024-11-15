import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/api_manager/api_manager.dart';
import 'package:trendista_e_commerce/data/datasource_contract/auth_datasource.dart';
import 'package:trendista_e_commerce/data/model/auth_response/AuthResponse.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl extends AuthDataSource {
  ApiManager apiManager;
  @factoryMethod
  AuthDataSourceImpl({required this.apiManager});
  @override
  Future<Either<AuthResponse, String>> signUp(
      {required String email,
      required String password,
      required String mobileNumber,
      required String name}) async {
    try {
      var response = await apiManager.register(
          name: name,
          email: email,
          mobileNumber: mobileNumber,
          password: password);
      if (response.status == false) {
        // not => if (response.status != null)
        return Right(response.message ?? '');
      } else {
        return Left(response);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }

  // @override
  // Future<Either<AuthResponse, String>> signIn(
  //     {required String email, required String password}) async {
  //   try {
  //     var response = await apiManager.login(email: email, password: password);
  //     if (response.status != null) {
  //       return Right(response.message ?? '');
  //     } else {
  //       return Left(response);
  //     }
  //   } catch (e) {
  //     return Right(e.toString());
  //   }
  // }

  @override
  Future<Either<AuthResponse, String>> signIn(
      {required String email, required String password}) async {
    try {
      var response = await apiManager.login(email: email, password: password);
      // Modified: If the response status is false, it's an error
      if (response.status == false) {
        // the error that i was face in the last signIn func , that i was making [if (response.status != null)] , the true is=> response.status == false,,, the main reason because the status in my response is (bool).(The message field is a string that may contain error messages (it can be null in some response types, even on successful login/signup).)
        return Right(response.message ?? 'Unknown error');
      } else {
        return Left(response); // If status is true, it's a success
      }
    } catch (e) {
      return Right(e.toString()); // Handle exceptions
    }
  }

  // @override
  // Future getProfileData() async {
  //   var response = await apiManager.getProfileData();
  //   return response.data?.toUserEntity();
  // }
}

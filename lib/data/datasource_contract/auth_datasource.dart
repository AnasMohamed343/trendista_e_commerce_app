import 'package:dartz/dartz.dart';
import 'package:trendista_e_commerce/data/model/auth_response/AuthResponse.dart';

abstract class AuthDataSource {
  Future<Either<AuthResponse, String>> signUp({
    required String email,
    required String password,
    required String mobileNumber,
    required String name,
  });

  Future<Either<AuthResponse, String>> signIn(
      {required String email, required String password});

  Future getProfileData();
}

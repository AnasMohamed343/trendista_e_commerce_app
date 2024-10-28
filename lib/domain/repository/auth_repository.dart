import 'package:dartz/dartz.dart';
import 'package:trendista_e_commerce/domain/entities/auth_entity/AuthEntity.dart';

abstract class AuthRepository {
  Future<Either<AuthEntity, String>> signUp({
    required String email,
    required String password,
    required String mobileNumber,
    required String name,
  });

  Future<Either<AuthEntity, String>> signIn(
      {required String email, required String password});

  Future getProfileData();
}

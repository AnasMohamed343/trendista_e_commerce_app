import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/data/datasource_contract/auth_datasource.dart';
import 'package:trendista_e_commerce/domain/entities/auth_entity/AuthEntity.dart';
import 'package:trendista_e_commerce/domain/repository/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthDataSource authDataSource;
  @factoryMethod
  AuthRepositoryImpl({required this.authDataSource});
  @override
  Future<Either<AuthEntity, String>> signUp(
      {required String email,
      required String password,
      required String mobileNumber,
      required String name}) async {
    var result = await authDataSource.signUp(
        email: email,
        password: password,
        mobileNumber: mobileNumber,
        name: name);
    return result.fold((response) {
      return Left(response.toAuthEntity());
    }, (error) {
      return Right(error);
    });
  }

  @override
  Future<Either<AuthEntity, String>> signIn(
      {required String email, required String password}) async {
    var result = await authDataSource.signIn(email: email, password: password);
    return result.fold((response) {
      return Left(response.toAuthEntity());
    }, (error) {
      return Right(error);
    });
  }
}

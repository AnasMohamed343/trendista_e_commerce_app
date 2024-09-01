import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/auth_entity/AuthEntity.dart';
import 'package:trendista_e_commerce/domain/repository/auth_repository.dart';

@injectable
class SignUpUseCase {
  AuthRepository authRepository;
  @factoryMethod
  SignUpUseCase({required this.authRepository});
  Future<Either<AuthEntity, String>> invoke({
    required String email,
    required String password,
    required String mobileNumber,
    required String name,
  }) {
    return authRepository.signUp(
        email: email,
        password: password,
        mobileNumber: mobileNumber,
        name: name);
  }
}

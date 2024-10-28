import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/auth_entity/AuthEntity.dart';
import 'package:trendista_e_commerce/domain/repository/auth_repository.dart';

@injectable
class SignInUseCase {
  AuthRepository authRepository;
  @factoryMethod
  SignInUseCase({required this.authRepository});

  Future<Either<AuthEntity, String>> invoke(
      {required String email, required String password}) {
    return authRepository.signIn(email: email, password: password);
  }
}

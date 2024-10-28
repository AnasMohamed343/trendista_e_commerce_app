import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trendista_e_commerce/domain/entities/auth_entity/AuthEntity.dart';
import 'package:trendista_e_commerce/domain/repository/auth_repository.dart';

@injectable
class GetProfileDataUseCase {
  AuthRepository authRepository;
  @factoryMethod
  GetProfileDataUseCase({required this.authRepository});
  Future Invoke() async => await authRepository.getProfileData();
}

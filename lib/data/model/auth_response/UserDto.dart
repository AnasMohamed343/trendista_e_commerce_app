import 'package:trendista_e_commerce/domain/entities/auth_entity/UserEntity.dart';

class UserDto {
  UserDto({
    this.name,
    this.email,
    this.role,
  });

  UserDto.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }
  String? name;
  String? email;
  String? role;
  UserDto copyWith({
    String? name,
    String? email,
    String? role,
  }) =>
      UserDto(
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    return map;
  }

  UserEntity toUserEntity() {
    return UserEntity(role: role, email: email, name: name);
  }
}

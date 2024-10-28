import 'package:trendista_e_commerce/domain/entities/auth_entity/UserEntity.dart';

class UserDto {
  UserDto({
    this.name,
    this.phone,
    this.email,
    this.id,
    this.image,
    this.token,
  });

  UserDto.fromJson(dynamic json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }
  String? name;
  String? phone;
  String? email;
  int? id;
  String? image;
  String? token;
  UserDto copyWith({
    String? name,
    String? phone,
    String? email,
    int? id,
    String? image,
    String? token,
  }) =>
      UserDto(
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        id: id ?? this.id,
        image: image ?? this.image,
        token: token ?? this.token,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['id'] = id;
    map['image'] = image;
    map['token'] = token;
    return map;
  }

  UserEntity toUserEntity() {
    return UserEntity(
        token: token,
        email: email,
        name: name,
        id: id,
        image: image,
        phone: phone);
  }
}

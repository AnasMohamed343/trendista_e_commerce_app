import 'package:trendista_e_commerce/domain/entities/auth_entity/AuthEntity.dart';

import 'UserDto.dart';

class AuthResponse {
  AuthResponse({
    this.message,
    this.statusMsg,
    this.user,
    this.token,
  });

  AuthResponse.fromJson(dynamic json) {
    message = json['message'];
    statusMsg = json['statusMsg'];
    user = json['user'] != null ? UserDto.fromJson(json['user']) : null;
    token = json['token'];
  }
  String? message;
  String? statusMsg;
  UserDto? user;
  String? token;
  AuthResponse copyWith({
    String? message,
    String? statusMsg,
    UserDto? user,
    String? token,
  }) =>
      AuthResponse(
        message: message ?? this.message,
        statusMsg: statusMsg ?? this.statusMsg,
        user: user ?? this.user,
        token: token ?? this.token,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['statusMsg'] = statusMsg;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }

  AuthEntity toAuthEntity() {
    return AuthEntity(
        user: user?.toUserEntity(),
        token: token,
        message: message,
        statusMsg: statusMsg);
  }
}

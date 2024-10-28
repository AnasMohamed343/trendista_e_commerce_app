import 'package:trendista_e_commerce/domain/entities/auth_entity/AuthEntity.dart';

import 'UserDto.dart';

class AuthResponse {
  AuthResponse({
    this.status,
    this.message,
    this.data,
  });

  AuthResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserDto.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  UserDto? data;
  AuthResponse copyWith({
    bool? status,
    String? message,
    UserDto? data,
  }) =>
      AuthResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

  AuthEntity toAuthEntity() {
    return AuthEntity(
      data: data?.toUserEntity(),
      status: status,
      message: message,
    );
  }
}

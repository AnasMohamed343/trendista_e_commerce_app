import 'package:trendista_e_commerce/domain/entities/auth_entity/UserEntity.dart';

class AuthEntity {
  AuthEntity({
    this.status,
    this.message,
    this.data,
  });

  AuthEntity.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserEntity.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  UserEntity? data;
  AuthEntity copyWith({
    bool? status,
    String? message,
    UserEntity? data,
  }) =>
      AuthEntity(
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
}

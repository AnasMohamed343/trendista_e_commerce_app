import 'UserEntity.dart';

class AuthEntity {
  AuthEntity({
    this.message,
    this.statusMsg,
    this.user,
    this.token,
  });

  AuthEntity.fromJson(dynamic json) {
    message = json['message'];
    statusMsg = json['statusMsg'];
    user = json['user'] != null ? UserEntity.fromJson(json['user']) : null;
    token = json['token'];
  }
  String? message;
  String? statusMsg;
  UserEntity? user;
  String? token;
  AuthEntity copyWith({
    String? message,
    String? statusMsg,
    UserEntity? user,
    String? token,
  }) =>
      AuthEntity(
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
}

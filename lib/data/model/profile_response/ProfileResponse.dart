import 'UserProfileDto.dart';

class ProfileResponse {
  ProfileResponse({
    this.status,
    this.message,
    this.data,
  });

  ProfileResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserProfileDto.fromJson(json['data']) : null;
  }
  bool? status;
  dynamic message;
  UserProfileDto? data;
  ProfileResponse copyWith({
    bool? status,
    dynamic message,
    UserProfileDto? data,
  }) =>
      ProfileResponse(
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

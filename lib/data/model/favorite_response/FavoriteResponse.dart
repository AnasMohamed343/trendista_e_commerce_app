import 'Data.dart';

class FavoriteResponse {
  FavoriteResponse({
    this.status,
    this.message,
    this.data,
  });

  FavoriteResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  dynamic message;
  Data? data;
  FavoriteResponse copyWith({
    bool? status,
    dynamic message,
    Data? data,
  }) =>
      FavoriteResponse(
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

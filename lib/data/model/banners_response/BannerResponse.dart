import 'BannerDto.dart';

class BannerResponse {
  BannerResponse({
    this.status,
    this.message,
    this.data,
  });

  BannerResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BannerDto.fromJson(v));
      });
    }
  }
  bool? status;
  dynamic message;
  List<BannerDto>? data;
  BannerResponse copyWith({
    bool? status,
    dynamic message,
    List<BannerDto>? data,
  }) =>
      BannerResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

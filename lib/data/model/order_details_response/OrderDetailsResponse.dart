import 'Data.dart';

class OrderDetailsResponse {
  OrderDetailsResponse({
    this.status,
    this.message,
    this.data,
  });

  OrderDetailsResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  dynamic message;
  Data? data;
  OrderDetailsResponse copyWith({
    bool? status,
    dynamic message,
    Data? data,
  }) =>
      OrderDetailsResponse(
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
import 'Data.dart';

class AddOrderResponse {
  AddOrderResponse({
    this.status,
    this.message,
    this.data,
  });

  AddOrderResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  Data? data;
  AddOrderResponse copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      AddOrderResponse(
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

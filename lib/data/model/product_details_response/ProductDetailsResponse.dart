import 'package:trendista_e_commerce/data/model/product_details_response/product_details_dto.dart';

class ProductDetailsResponse {
  ProductDetailsResponse({
    this.status,
    this.message,
    this.data,
  });

  ProductDetailsResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? ProductDetailsDto.fromJson(json['data']) : null;
  }
  bool? status;
  dynamic message;
  ProductDetailsDto? data;
  ProductDetailsResponse copyWith({
    bool? status,
    dynamic message,
    ProductDetailsDto? data,
  }) =>
      ProductDetailsResponse(
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

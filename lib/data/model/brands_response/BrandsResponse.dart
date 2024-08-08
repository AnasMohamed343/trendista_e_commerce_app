import 'package:trendista_e_commerce/data/model/paginationDto.dart';
import 'brandDto.dart';

class BrandsResponse {
  BrandsResponse({
    this.results,
    this.metadata,
    this.data,
  });

  BrandsResponse.fromJson(dynamic json) {
    results = json['results'];
    metadata = json['metadata'] != null
        ? PaginationDto.fromJson(json['metadata'])
        : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BrandDto.fromJson(v));
      });
    }
  }
  int? results;
  PaginationDto? metadata;
  List<BrandDto>? data;
  BrandsResponse copyWith({
    int? results,
    PaginationDto? metadata,
    List<BrandDto>? data,
  }) =>
      BrandsResponse(
        results: results ?? this.results,
        metadata: metadata ?? this.metadata,
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['results'] = results;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

import '../../paginationDto.dart';
import 'categoryDto.dart';

class CategoryResponse {
  CategoryResponse({
    this.results,
    this.metadata,
    this.data,
  });

  CategoryResponse.fromJson(dynamic json) {
    results = json['results'];
    metadata = json['metadata'] != null
        ? PaginationDto.fromJson(json['metadata'])
        : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CategoryDto.fromJson(v));
      });
    }
  }
  int? results;
  PaginationDto? metadata;
  List<CategoryDto>? data;
  CategoryResponse copyWith({
    int? results,
    PaginationDto? metadata,
    List<CategoryDto>? data,
  }) =>
      CategoryResponse(
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

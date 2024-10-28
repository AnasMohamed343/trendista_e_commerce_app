import 'package:trendista_e_commerce/domain/entities/Category.dart';

import 'CategoryDto.dart';

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Data.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CategoryDto.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
  int? currentPage;
  List<CategoryDto>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;
  Data copyWith({
    int? currentPage,
    List<CategoryDto>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) =>
      Data(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }

  List<Category> toCategories() {
    return data?.map((v) => v.toCategory()).toList() ?? [];
  }
}
//
// class Data {
//   Data({this.currentPage, this.data, this.firstPageUrl, this.from, this.lastPage, this.lastPageUrl, this.nextPageUrl, this.path, this.perPage, this.prevPageUrl, this.to, this.total});
//
//   Data.fromJson(dynamic json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data?.add(CategoryDto.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }
//
//   int? currentPage;
//   List<CategoryDto>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   dynamic nextPageUrl;
//   String? path;
//   int? perPage;
//   dynamic prevPageUrl;
//   int? to;
//   int? total;
//
//   Data copyWith({int? currentPage, List<CategoryDto>? data, String? firstPageUrl, int? from, int? lastPage, String? lastPageUrl, dynamic nextPageUrl, String? path, int? perPage, dynamic prevPageUrl, int? to, int? total}) =>
//       Data(currentPage: currentPage ?? this.currentPage, data: data ?? this.data, firstPageUrl: firstPageUrl ?? this.firstPageUrl, from: from ?? this.from, lastPage: lastPage ?? this.lastPage, lastPageUrl: lastPageUrl ?? this.lastPageUrl, nextPageUrl: nextPageUrl ?? this.nextPageUrl, path: path ?? this.path, perPage: perPage ?? this.perPage, prevPageUrl: prevPageUrl ?? this.prevPageUrl, to: to ?? this.to, total: total ?? this.total);
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['current_page'] = currentPage;
//     if (data != null) {
//       map['data'] = data?.map((v) => v.toJson()).toList();
//     }
//     map['first_page_url'] = firstPageUrl;
//     map['from'] = from;
//     map['last_page'] = lastPage;
//     map['last_page_url'] = lastPageUrl;
//     map['next_page_url'] = nextPageUrl;
//     map['path'] = path;
//     map['per_page'] = perPage;
//     map['prev_page_url'] = prevPageUrl;
//     map['to'] = to;
//     map['total'] = total;
//     return map;
//   }
//
//   List<Category> toCategories() {
//     return data?.map((v) => v.toCategory()).toList() ?? [];
//   }
// }

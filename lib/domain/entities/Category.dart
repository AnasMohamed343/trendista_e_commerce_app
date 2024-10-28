import 'package:trendista_e_commerce/data/model/categories_response/CategoryDto.dart';

class Category {
  Category({
    this.id,
    this.name,
    this.image,
  });

  Category.fromJson(dynamic json) {
    id = json['id'].toInt();
    name = json['name'];
    image = json['image'];
  }
  int? id;
  String? name;
  String? image;
  Category copyWith({
    int? id,
    String? name,
    String? image,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    return map;
  }
}

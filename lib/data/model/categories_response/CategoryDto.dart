import 'package:trendista_e_commerce/domain/entities/Category.dart';

class CategoryDto {
  CategoryDto({
    this.id,
    this.name,
    this.image,
  });

  CategoryDto.fromJson(dynamic json) {
    id = json['id'].toInt();
    name = json['name'];
    image = json['image'];
  }
  int? id;
  String? name;
  String? image;
  CategoryDto copyWith({
    int? id,
    String? name,
    String? image,
  }) =>
      CategoryDto(
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

  Category toCategory() {
    return Category(
      id: id,
      name: name,
      image: image,
    );
  }
}

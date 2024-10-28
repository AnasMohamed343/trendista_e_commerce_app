import 'package:trendista_e_commerce/domain/entities/BannerEntity.dart';

class BannerDto {
  BannerDto({
    this.id,
    this.image,
  });

  BannerDto.fromJson(dynamic json) {
    id = json['id'].toInt();
    image = json['image'];
  }
  int? id;
  String? image;
  BannerDto copyWith({
    int? id,
    String? image,
  }) =>
      BannerDto(
        id: id ?? this.id,
        image: image ?? this.image,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    return map;
  }

  BannerEntity toBanner() => BannerEntity(id: id, image: image);
}

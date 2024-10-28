class BannerEntity {
  BannerEntity({
    this.id,
    this.image,
  });

  BannerEntity.fromJson(dynamic json) {
    id = json['id'].toInt();
    image = json['image'];
  }
  int? id;
  String? image;
  BannerEntity copyWith({
    int? id,
    String? image,
  }) =>
      BannerEntity(
        id: id ?? this.id,
        image: image ?? this.image,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    return map;
  }
}

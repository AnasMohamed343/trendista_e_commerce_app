class Subcategory {
  Subcategory({
    this.id,
    this.name,
    this.slug,
    this.category,
  });

  Subcategory.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    category = json['category'];
  }
  String? id;
  String? name;
  String? slug;
  String? category;
  Subcategory copyWith({
    String? id,
    String? name,
    String? slug,
    String? category,
  }) =>
      Subcategory(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        category: category ?? this.category,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['category'] = category;
    return map;
  }
}

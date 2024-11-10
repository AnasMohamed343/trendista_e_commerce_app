class ProductOrderDetailsDto {
  ProductOrderDetailsDto({
    this.id,
    this.quantity,
    this.price,
    this.name,
    this.image,
  });

  ProductOrderDetailsDto.fromJson(dynamic json) {
    id = json['id'] is int ? json['id'] : (json['id'] as double?)?.toInt();
    quantity = json['quantity'] is int
        ? json['quantity']
        : (json['quantity'] as double?)?.toInt();
    price = json['price'] is int
        ? json['price']
        : (json['price'] as double?)?.toInt();
    name = json['name'];
    image = json['image'];
  }
  int? id;
  int? quantity;
  int? price;
  String? name;
  String? image;
  ProductOrderDetailsDto copyWith({
    int? id,
    int? quantity,
    int? price,
    String? name,
    String? image,
  }) =>
      ProductOrderDetailsDto(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        name: name ?? this.name,
        image: image ?? this.image,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['quantity'] = quantity;
    map['price'] = price;
    map['name'] = name;
    map['image'] = image;
    return map;
  }
}

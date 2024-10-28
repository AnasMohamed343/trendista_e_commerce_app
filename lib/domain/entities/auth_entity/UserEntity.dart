class UserEntity {
  UserEntity({
    this.name,
    this.phone,
    this.email,
    this.id,
    this.image,
    this.token,
  });

  UserEntity.fromJson(dynamic json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }
  String? name;
  String? phone;
  String? email;
  int? id;
  String? image;
  String? token;
  UserEntity copyWith({
    String? name,
    String? phone,
    String? email,
    int? id,
    String? image,
    String? token,
  }) =>
      UserEntity(
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        id: id ?? this.id,
        image: image ?? this.image,
        token: token ?? this.token,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['id'] = id;
    map['image'] = image;
    map['token'] = token;
    return map;
  }
}

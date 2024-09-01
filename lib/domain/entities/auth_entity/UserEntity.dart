class UserEntity {
  UserEntity({
    this.name,
    this.email,
    this.role,
  });

  UserEntity.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }
  String? name;
  String? email;
  String? role;
  UserEntity copyWith({
    String? name,
    String? email,
    String? role,
  }) =>
      UserEntity(
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    return map;
  }
}

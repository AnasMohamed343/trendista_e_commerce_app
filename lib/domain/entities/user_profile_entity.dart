class UserProfileEntity {
  UserProfileEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  // UserProfileEntity.fromJson(dynamic json) {
  //   id = json['id'].toInt();
  //   //id = json['id'] is int ? json['id'] : (json['id'] as double).toInt();
  //   name = json['name'];
  //   email = json['email'];
  //   phone = json['phone'];
  //   image = json['image'].toString();
  //   points = json['points'].toInt();
  //   credit = json['credit'].toInt();
  //   token = json['token'];
  // }//i was face this error : I/flutter (23859): Error at Profile Data: type 'double' is not a subtype of type 'int?'
  //to resolve it >  you should add type checking and casting in the UserProfileDto.fromJson method to ensure these values are converted to int if they are of type double.
  UserProfileEntity.fromJson(dynamic json) {
    id = json['id'] is int ? json['id'] : (json['id'] as double?)?.toInt();
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'].toString();
    points = json['points'] is int
        ? json['points']
        : (json['points'] as double?)?.toInt();
    credit = json['credit'] is int
        ? json['credit']
        : (json['credit'] as double?)?.toInt();
    token = json['token'];
  }

  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  UserProfileEntity copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    int? points,
    int? credit,
    String? token,
  }) =>
      UserProfileEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
        points: points ?? this.points,
        credit: credit ?? this.credit,
        token: token ?? this.token,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['image'] = image;
    map['points'] = points;
    map['credit'] = credit;
    map['token'] = token;
    return map;
  }
}

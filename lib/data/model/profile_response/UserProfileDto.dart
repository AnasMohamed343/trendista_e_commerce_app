import 'package:trendista_e_commerce/domain/entities/user_profile_entity.dart';

class UserProfileDto {
  UserProfileDto({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  // UserProfileDto.fromJson(dynamic json) {
  //   id = json['id'].toInt();
  //   //id = json['id'] is int ? json['id'] : (json['id'] as double).toInt();
  //   name = json['name'];
  //   email = json['email'];
  //   phone = json['phone'];
  //   image = json['image'].toString();
  //   points = json['points'];
  //   credit = json['credit'];
  //   token = json['token'];
  // }
  UserProfileDto.fromJson(dynamic json) {
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
  UserProfileDto copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    int? points,
    int? credit,
    String? token,
  }) =>
      UserProfileDto(
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

  UserProfileEntity toUserProfileEntity() {
    return UserProfileEntity(
        id: id,
        name: name,
        email: email,
        phone: phone,
        image: image,
        points: points,
        credit: credit,
        token: token);
  }
}

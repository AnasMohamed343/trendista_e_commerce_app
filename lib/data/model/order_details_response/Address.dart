class Address {
  Address({
    this.id,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
    this.latitude,
    this.longitude,
  });

  Address.fromJson(dynamic json) {
    id = json['id'] is int ? json['id'] : (json['id'] as double?)?.toInt();
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'] is int
        ? json['latitude']
        : (json['latitude'] as double?)?.toInt();
    longitude = json['longitude'] is int
        ? json['longitude']
        : (json['longitude'] as double?)?.toInt();
  }
  int? id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  int? latitude;
  int? longitude;
  Address copyWith({
    int? id,
    String? name,
    String? city,
    String? region,
    String? details,
    String? notes,
    int? latitude,
    int? longitude,
  }) =>
      Address(
        id: id ?? this.id,
        name: name ?? this.name,
        city: city ?? this.city,
        region: region ?? this.region,
        details: details ?? this.details,
        notes: notes ?? this.notes,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['city'] = city;
    map['region'] = region;
    map['details'] = details;
    map['notes'] = notes;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }
}

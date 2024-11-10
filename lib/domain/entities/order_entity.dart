class OrderEntity {
  OrderEntity({
    this.id,
    this.total,
    this.date,
    this.status,
  });

  OrderEntity.fromJson(dynamic json) {
    id = json['id'].toInt();
    total = json['total'].toInt();
    date = json['date'];
    status = json['status'];
  }
  int? id;
  int? total;
  String? date;
  String? status;
  OrderEntity copyWith({
    int? id,
    int? total,
    String? date,
    String? status,
  }) =>
      OrderEntity(
        id: id ?? this.id,
        total: total ?? this.total,
        date: date ?? this.date,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['total'] = total;
    map['date'] = date;
    map['status'] = status;
    return map;
  }
}
